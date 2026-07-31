Add validation check for decimal number in amount column - Done

Add idempotent click for finalize and approve - BE don't need to fix. It is FE problem

Fix handle failed called balance inquiry not blocked the update validation status - Done

Add query returned processing_branch_code in batch details - Done

Payment metadata accumulation - Done

TransactionID (Core TM)	=> Returned from task PARTITION_RESULT_FINALIZED (transaction_id in transaction.transactions table)
TransactionID (Bút toán Tổng - Core FCC) => transaction_batch.referenceNumber
TransactionID (Bút toán Chi tiết - Core FCC) => transaction.referenceNumber

=> Done

Refactor from Dat code in lending payment - Done

File chống trùng lặp ngày T

Fix export file - Done

Nhờ chị Hằng test lại sau khi pick code lên UAT

Test new workflow chunk dùng loop