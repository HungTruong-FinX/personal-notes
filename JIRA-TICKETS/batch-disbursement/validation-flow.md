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
