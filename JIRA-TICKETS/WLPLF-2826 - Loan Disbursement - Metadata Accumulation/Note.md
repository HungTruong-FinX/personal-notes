JIRA: https://galaxyfinx.atlassian.net/browse/WLPLF-2826

Test cases:

1. Happy case - All files completed

Link: https://backoffice.dev.vikkibank.io/v1/assets/1/mda_uh1ZvoYZiSEeaLIhv9HtPsZ

Expected result:

```json
{
  "validationCompleted": {
    "amount": 72000000.00,
    "currency": "VND",
    "quantity": 2
  },
  "importValidationCompleted": {
    "amount": 72000000.00,
    "currency": "VND",
    "quantity": 2
  }
}
```

2. Import draft validation failed

Link: https://backoffice.dev.vikkibank.io/v1/assets/1/mda_ojYQ2S-kqG9gNkqwy4qENBw

Expected result: 

```json
{
  "importValidationFailed": {
    "amount": 144000000.00,
    "currency": "VND",
    "quantity": 5
  },
  "importValidationCompleted": {
    "amount": 216000000.00,
    "currency": "VND",
    "quantity": 6
  }
}
```

3. Import draft validation success - transaction validation failed

Link: https://backoffice.dev.vikkibank.io/v1/assets/1/mda_R90_7Wud9Lde8Y0z29_I-lK

Expected result: 

```json
{
  "validationFailed": {
    "amount": 288000000.00,
    "currency": "VND",
    "quantity": 8
  },
  "validationCompleted": {
    "amount": 108000000.00,
    "currency": "VND",
    "quantity": 3
  },
  "importValidationCompleted": {
    "amount": 396000000.00,
    "currency": "VND",
    "quantity": 11
  }
}
```

4. Exception while validating draft

Link: https://backoffice.dev.vikkibank.io/v1/assets/1/mda_O_JAIrgmJRpFqW3YH1sDT_r

Expected result: 

```json
{
  "importValidationFailed": {
    "amount": 144000000.00,
    "currency": "VND",
    "quantity": 5
  },
  "importValidationCompleted": {
    "amount": 216000000.00,
    "currency": "VND",
    "quantity": 6
  }
}
```

5. Exception while validating transaction

Link: https://backoffice.dev.vikkibank.io/v1/assets/1/mda_R90_7Wud9Lde8Y0z29_I-lK

Expected result: 

```json
{
  "validationFailed": {
    "amount": 288000000.00,
    "currency": "VND",
    "quantity": 8
  },
  "validationCompleted": {
    "amount": 108000000.00,
    "currency": "VND",
    "quantity": 3
  },
  "importValidationCompleted": {
    "amount": 396000000.00,
    "currency": "VND",
    "quantity": 11
  }
}
```