<domain>.<product>.<channel>.<feature>

├── lending
   ├── lending.savings_book_loan
        ├── lending.savings_book_loan.app.registration         Đăng ký vay mới
        ├── lending.savings_book_loan.app.management     Xem lại khoản vay
        ├── lending.savings_book_loan.app.settlement       Thanh/tất toán khoản vay
   ├── lending.overdraft
        ├── lending.overdraft.app.activation     Kích hoạt tài khoản OD
        ├── lending.overdraft.app.detail         Thông tin hạn mức
        ├── lending.overdraft.app.management     Xem chi tiết OD trong loantab
        ├── lending.overdraft.app.spending       Sử dụng hạn mức chi tiêu OD từ CASA
        ├── lending.overdraft.app.statement      Xem sao kê tài khoản OD
        ├── lending.overdraft.app.lock_unlock    Khóa / Mở khóa tài khoản OD
        └── lending.overdraft.app.settlement     Tất toán tài khoản OD

Bấm vào nút đăng ký vay ở "Vay cầm cố sổ tiết kiệm"

POST api/loan-origination/v1/originations

Bấm vào nút thanh toán khoản vay

API mới chưa có. Nhưng expected behavior

26/09/2026

- Check usage and dig deeper to open feature. 

     + How to support ops.* => No need. Library will check it first before going to normal key validation
     + Parent child turn on off testing => Done
     + NOT_EILIGIBLE => Done
     + TENANT_BLOCKED => Done

- Check idempotent key - Done

- Shift time testing - Done

Tasks:

Check postingRequestId if populated from lending-payment => 

Remove log in RepaymentService in lending-worker => can be kept

Publish platform kit

Create PRs => Nhắc review

Write docs => Bắc Phạm handles