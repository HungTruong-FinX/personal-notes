./gradlew clean build publishToMavenLocal

./gradlew clean build --refresh-dependencies

./gradlew :sdk:clean :sdk:build :sdk:publishToMavenLocal

Use localMaven with 2 different version locally build

Yes, you can do this cleanly with `publishToMavenLocal`.

Your SDK coordinates are:

```text
com.finx.lending.sdk:orchestration:<version>
```

Consumers already have `mavenLocal()` before Nexus, so Gradle will prefer your local artifact when the version matches.

**Recommended Flow**

From `lending-orchestration-service`, publish the Spring Boot 3 SDK from `enhance/legacy-sdk` as `1.0.0`:

```bash
cd /Users/hungtruong/Workspace/lending-orchestration-service
git switch enhance/legacy-sdk
./gradlew :sdk:clean :sdk:build :sdk:publishToMavenLocal -Pversion=1.0.0
```

Then publish the Spring Boot 4 SDK from `enhance/sdk` as `2.0.0`:

```bash
cd /Users/hungtruong/Workspace/lending-orchestration-service
git switch enhance/sdk
./gradlew :sdk:clean :sdk:build :sdk:publishToMavenLocal -Pversion=2.0.0
```

This will install locally under:

```text
~/.m2/repository/com/finx/lending/sdk/orchestration/
```

Then test each service.

For `payment-batches-service`, it already uses:

```toml
lending-orchestration-version = '1.0.0'
```

So run:

```bash
cd /Users/hungtruong/Workspace/payment-batches-service
./gradlew clean build --refresh-dependencies
```

For `lending-payment-service`, it already uses:

```toml
lending-sdk-version = '2.0.0'
```

So run:

```bash
cd /Users/hungtruong/Workspace/lending-payment-service
./gradlew clean build --refresh-dependencies
```

**Important note:** if you run `./gradlew :sdk:publishToMavenLocal` without `-Pversion=...`, your SDK publishes as:

```text
com.finx.lending.sdk:orchestration:localMaven
```

Then the consuming services will not pick it up unless you temporarily change their `libs.versions.toml` to `localMaven`.

So for your current setup, publishing with `-Pversion=1.0.0` and `-Pversion=2.0.0` is the least disruptive path.

## After published to localMaven

Sometimes, we need to put this in main build.gradle so that it looks for localMaven build with higher priority

```toml
configurations.configureEach {
    resolutionStrategy.eachDependency {
        if (requested.group == 'com.finx.platform') {
            useVersion('localMaven')
            because('Use locally published platform-kit artifacts during development')
        }
    }
}
```