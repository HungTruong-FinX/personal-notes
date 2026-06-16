## 1. Design push notification template

- Refer to Section 6 in this link: [Savings Account Loan Notification List](https://galaxyfinx.atlassian.net/wiki/spaces/VBBP/pages/987791379/Savings+Account+Loan+notification+list)

## 2. Write consumer to send notification email

- Modify add the field productType is LOAN to event payload before publish to internal kafka
    + Query productType based on accountNumber using com.finx.account.repository.AccountRepositoryImpl#findProductTypeByAccountNumber

    => DONE

- Filter message by notification_type is LOAN_BEFORE_MATURITY and productType is LOAN - Done

- Query neccessary message information in email template - Done

- Refer to **com.finx.lending.loan.infra.message.publisher.KafkaNotificationPublisher** - Done

## 3. Producer to send kafka message to notification service

- Design payload - Done

```
loan_contract_number: loanAccountNumber
loanduedate: maturityDate (maturityTimestamp::date)
TDnumber: tdAccountNumber
```

- Produce message - Done

- DML for message content in template table in notification db

## 4. PR

### account-service

- Add product type in event payload

https://github.com/GalaxyFinX/account-service/pull/1341

=> Fixed

=> Merged

### non-prod-application-workload

- Declare topic for consumer in loan-management-service

https://github.com/GalaxyFinX/non-prod-application-workload/pull/6256

=> Merged

### loan-management-service

- Consume event from {{env}}.account_service.account-events and send notification

https://github.com/GalaxyFinX/loan-management-service/pull/240

=> Fixed

=> Merged

CustomerLoanMaturityNotificationConsumer

### notification-service-v2

- Add DML for notification content

https://github.com/GalaxyFinX/notification-service-v2/pull/644

=> Fixed

=> Rollback

### non-prod-liquibase

- Add DML for notification content

https://github.com/GalaxyFinX/non-prod-liquibase/pull/606

=> Fixed

=> Rollback