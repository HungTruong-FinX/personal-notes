1. Điều kiện triggered message vault.core_api.v1.contracts.contract_notification.events là gì? Message LOAN_BEFORE_MATURITY chỉ được gửi một hay nhiều lần từ TM core?
=> Phụ thuộc vào core. Không quan 1 hay nhiều lần lời nhắc

2. Timeline cho requirement này
=> 2 ngày

3. Đối với những message đã tồn tại và number_of_days_before_maturity_date < 5 ngày thì mình cũng sẽ gửi email như bình thường? Hay có constraint gì thêm về con số 5 ngày?
=> Không quan tâm, cứ có message là bắn email nhắc nhở

4. Loan due date để thực hiện thanh toán khoản vay là field maturity_date hay là effective_datetime
=> maturity_date

5. Chưa cần quan tâm đến idempotency