1. User uploads file
2. POST /v1/internal/payments/batches => initBatch
3. Extract file metadata + validate mimeType
4. File structure validation (header,...)
5. Open Spring @Transactional
6. Save transaction batch
7. Save transaction draft (transaction draft is the rows in the file. Relationship n to 1 to transaction batch). Must stream file to save by chunks
8. Validate row by row in the batch, update any error message (like this field can't be blank, this must be number,...) if existed
    8.1 STT không được để trống (additionalData.recordNumber - errorCode: 6)
    8.2 Mã đơn vị không được để trống (branchCode - errorCode: 7)
    8.3 Số hợp đồng không được để trống (additionalData.contractNumber - errorCode: 9)
    8.4 Số hợp đồng cá nhân không được để trống (referenceNumber - errorCode: 10)
    8.5 Họ tên không được để trống (customerFullName - errorCode: 11)
    8.6 Số tài khoản không được để trống (destinationAccountNumber - errorCode: 14)
    8.7 CCCD không được để trống (customerNid - errorCode: 20)
    8.8 Số tiền giải ngân không được để trống (amount - errorCode: 24)
    8.9 Nội dung không được để trống (additionalData.content - errorCode: 29)

9. Return error to user if file uploaded is not valid
10. Continue saving transaction. Each will be imported, stream the file again and save by chunks
11. Validate business rules on transaction. 
12. If error, update any error message (this nid already existed in the system,...) if existed
13. Notify user file uploaded successfully. End of flow

Problems:

1. Run async while the transaction may not commit. If failed, we don't have batch transaction and transaction to run import

2. We open stream the file 3 times

3. Not handling the transaction by chunks but by the whole connection

Steps to accomplish task:

1. Build repository - Done

2. Build service to save all - Done

Notes:

1. Save batch first then validate header. We don't want validate header but go to save batch

2. We should not update batch status in LendingDisbursementFileValidator but in the PaymentBatchService

Presigned URL: https://hungtruong-finx.s3.ap-southeast-1.amazonaws.com/payment-batches/happy-case.xlsx?response-content-disposition=inline&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEAkaDmFwLXNvdXRoZWFzdC0xIkgwRgIhAMWsGgefTCS%2FJ1cVxDPhrhhqBZXY3lWthxeE7%2F1G4aHWAiEA1UgKgjScJeMyKT7jI8GBDi%2FqSiUz7DWRzOG%2FXIh1lwsqwgMI0v%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARAAGgw1NzQ3NzEwMjMzOTkiDLk7aUMAEQ2lGGQ%2FniqWA3H%2FxQq0JCRBKHbG8rHdVv%2FKcSY3RkvpFvYtqf0YLCVW3euO7Ckfv5ZRmxfez9m2Yo%2Fj8YLZthJXhBGirBsPPT8e4mOYpbOcBPjmA87RZVn7x7re2ZXbNbQHIb2Ew6g8k5BTeT2eUwLOM1BjBEwCFxoJCLHL859PfbEO8P7pkPBIHRe2vOxehNWbSmTdis90lugZZ4MA5Vo61sa37SqIiT7%2BLAHp10FKJ6QhMZSL1%2BhArOlRPMCTEI2hO%2FoQnEqRY7BbC0qxpofTbgJVFG8bw0nodLOspeazB72x%2FLelGoNz8922whvwsfWuDFXXlGx8RJgCPEcdkIwX2lwM9TfkNmoQ1vOi8z%2FLhfX9m7yaazbJKPLpOTFhSUR%2BtK1aC7a1Axmk%2Bi1cA%2FUZrnax%2FlIX%2BVp4pgSZ5TexGRdhBWwDhkmECEwCNPznfMXiOPJ9VzgB%2Fu2wC8nonkUVGOx33M5moBusQ2ofgMDdegnHx98oro2ISpiI9syxGoQE8ZVWBkH%2B7%2Fk07a4izWyC7KwtXk2GWaOnJdLz2xIw4eHX0QY63QJ8aKosdAGVDHQY3RUovmj3g3pKL0xG2JCLtEm95Y0pwKwfMdw1gAWR08fmcG2RSshZe7Z4D%2FLDCiXfZ%2B%2FL0DDQLY9VMPysy9ihVs6oATyE17z55cTypl1EfH%2BwmGGVXulN3fn76Ep5AMZPdnOZ5U0RVoC641rz4KBFBqXmmvTdA3wLJBxm1S1P%2BISk6ss8O%2FBgugY2atjUpwKqVO%2FNOQ0yFVhMf%2Bx0YkBrCh6cfpNUx6gqjdXkwQpySqwF%2FvkhvC18QkLKol05KWxpTGN%2FdHftUz%2BHTmEB3KdiJRJAVO5IgTe91oxK36i1Nqx7Ia%2F92vgwJPoEGpfRB0h59f%2BqDnPI9pIh6Y%2FIJDWiSRqc6I23WzY0GqOj0bdEWGEFhPqwR6J4LOe%2FGnMlh4rcOoQSlyWS%2B261SLVP77uY9bG1%2BXvM9ZpZ0K5sVFE5t4rrFFCUuFVDeICkDfmiKQWeQnoo&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIAYLUYFZYT77H3LR6R%2F20260620%2Fap-southeast-1%2Fs3%2Faws4_request&X-Amz-Date=20260620T083349Z&X-Amz-Expires=43200&X-Amz-SignedHeaders=host&X-Amz-Signature=e9ec88e8529e6fb62f151b3d5206c50dfc19618db3a7422fde9d00b1eca6dbff

Draft failed: B2606230000000261

Wrong mime type file (APPLICATION/ZIP): https://backoffice.dev.vikkibank.io/v1/assets/1/mda_ph26JkgwUOPGy6WPeC4Kwux

Tika mime type: https://backoffice.dev.vikkibank.io/v1/assets/1/mda_ULfcx2HsbDfry09a8RkVifA

Valid data with error: https://backoffice.dev.vikkibank.io/v1/assets/1/mda_OjE50evXZmi1380s8u6sw7N