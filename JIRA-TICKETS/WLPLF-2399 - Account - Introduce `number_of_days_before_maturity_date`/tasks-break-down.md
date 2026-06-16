## Complete Flow Summary

### The Starting Point

The flow **starts at the Loan Management Service**, which initiates loan account creation by calling Account Service's API.

---

### Phase 1: Loan Management Service (Loan-lending service)

CustomerLoanTaskService.java call loanFacade.createLoanAccount from worker task

**What happens**: When a loan is created, the Loan Management Service calls Account Service's `POST /v1/internal/accounts/loan` endpoint.

**What needs to change**:

| Class | Change |
|-------|--------|
| `com.finx.lending.loan.infra.provider.dto.LoanAccountCreationRequest` | Add field `List<String> maturityNotificationDays` |
| `com.finx.lending.loan.cl.core.domain.CustomerLoanScheme` | This is the **source of truth** for the values — the `maturityNotificationDays` values are managed in PMS and extracted from here |

**Unclear point**: How does `CustomerLoanScheme` store/provide `maturityNotificationDays`? Is it a new field there too? The requirement says "managed in PMS" — need to confirm whether PMS already has this field or it also needs a PMS change.

---

### Phase 2: Account Service — API Layer

**What happens**: The HTTP request body is deserialized into the request DTO.

**What needs to change**:

| Class | Change |
|-------|--------|
| `LoanAccountCreationRequest` ([api/.../loan/](file:///Users/hungtruong/Workspace/account-service/api/src/main/java/com/finx/account/controller/dto/request/loan/LoanAccountCreationRequest.java)) | Add field `List<String> maturityNotificationDays` (optional, no validation annotation) |

---

### Phase 3: Account Service — API→Core Mapping

**What happens**: MapStruct auto-maps the request DTO to the core domain param.

**What needs to change**:

| Class | Change |
|-------|--------|
| `LoanAccCreationParam` ([core/.../loan/](file:///Users/hungtruong/Workspace/account-service/core/src/main/java/com/finx/account/model/params/loan/LoanAccCreationParam.java)) | Add field `List<String> maturityNotificationDays` |
| `AccountMapper` ([api/.../mapper/](file:///Users/hungtruong/Workspace/account-service/api/src/main/java/com/finx/account/mapper/AccountMapper.java)) | MapStruct will auto-map since field name matches. No explicit `@Mapping` needed. |

---

### Phase 4: Account Service — Core→Infra Mapping (to Vault Core)

**What happens**: `CoreParamMapper.toLoanInstanceParamInTM()` converts `LoanAccCreationParam` into Vault Core's `InstanceParam`.

**What needs to change**:

| Class | Change |
|-------|--------|
| `CoreParamMapper` ([infra/.../mapper/](file:///Users/hungtruong/Workspace/account-service/infra/src/main/java/com/finx/account/client/though_machine/dto/mapper/CoreParamMapper.java)) | Add a mapping for `maturityNotificationDays` → `numberOfDaysBeforeMaturityDate` with **List→comma-separated String** conversion. When null/empty, let `@Builder.Default` handle it (defaults to `"5"`). |

**No change needed** for `InstanceParam` ([infra/.../request/](file:///Users/hungtruong/Workspace/account-service/infra/src/main/java/com/finx/account/client/though_machine/dto/request/InstanceParam.java)) — it already has `numberOfDaysBeforeMaturityDate` with `@Builder.Default = "5"`.

---

### Phase 5: Vault Core (Though Machine)

**What happens**: Receives the account creation request with `number_of_days_before_maturity_date` as an instance param. No change needed — this is the external system.

---

## Things That Are NOT Clear — Clarify with Your Boss

1. **What if `maturityNotificationDays` is an empty list `[]`?** Should it use the default `"5"`, or should it send an empty string? The requirement says "default value: 5" but doesn't specify empty-list behavior.

2. **Are the values always integers?** The field is `List<String>` but the default is `"5"` (a single number). Can values be like `["3", "5", "7"]`? The format says "comma separated list" which implies multiple values are possible, but the default is only one. Clarify the expected input range.

3. **Does PMS already have this field?** The requirement says "value is managed in PMS" — is `maturityNotificationDays` already a field in `CustomerLoanScheme`, or does PMS need a change too? This affects whether the Loan Management Service work is just wiring or also includes schema changes.

4. **Is the Loan Management Service's `LoanAccountCreationRequest` the same class or a different one?** The requirement mentions `com.finx.lending.loan.infra.provider.dto.LoanAccountCreationRequest` — this is in the lending service, not the account service. Need to confirm access to that codebase for the team working on it.

5. **Deployment order?** Should Account Service be deployed first (so it accepts the new field), or should both services deploy simultaneously? This matters for backward compatibility — if Loan Management Service sends `maturityNotificationDays` before Account Service is updated, the field would be silently ignored.

6. **Should `maturityNotificationDays` also be returned in GET account responses?** The requirement only mentions creation, but once the data is stored in Vault Core, consumers may want to read it back. Currently `AccountGetResponse` and `LoanAccountMapper` don't include this field.