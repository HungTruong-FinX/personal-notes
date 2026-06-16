1. Anh cho em xin thêm thông tin về những cái mình cần implement 3 methods ở trong PaymentBatchService => Sẽ bổ sung thêm sau

2. Khi fetch file về từ S3 của Nuclent thì mình cần phải validate những gì
    2.1 MIME Type?
    2.2 File structure reuse TableValidator?
    2.3 Gọi phía FCC để đối chiếu số dư tài khoản trung gian?
    2.4 Điều kiện hợp lệ tài khoản VikkiMe?
    ...
=> Validate theo diagram là đủ

3. Headers của FileMetadata sẽ gồm những field gì v anh
=> Không quan tâm. Build ra từ header của file excel

4. Flow hiện tại đang get input stream thì có cần phải validate mimetype và first row header hay k.
Nếu có thì mimetype là gì và row header cx cần validate? Read first row nhưng mà cần validate những gì

FileMetadata tạo xong thì lưu ở đâu, làm sao để get ra

=> Không dùng lại flow hiện tại, viết mới. Không lưu FileMetadata

5. Document server là S3? documentId là presigned url để connect S3 bên phía nuclent hay phải tương tác như thế nào?

=> Là bất cứ resource nào