1. Conductor

- Thêm task WAITING sau FUNDING => Đã chuyển thành asyncComplete: true

2. State Machine

Update INIT -> EXECUTION

Thêm 2 trạng thái

- INIT -> EXECUTION -> PROCESSING -> COMPLETION OR
- INIT -> EXECUTION -> COMPLETION

Dựa vào status phía FCC 

PROCESSING => PROCESSING => COMPLETION
SUCCESS => COMPLETION
FAILED => throw exception
TIMEOUT => throw exception

State transition handler
State listener / hooks

--> Complete wating 

Ở state COMPLETION, lending-payment-service sẽ trigger để move tới task tiếp theo ở Conductor
