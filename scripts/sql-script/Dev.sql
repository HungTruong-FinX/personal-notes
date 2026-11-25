select
  account_id,
  core_account_id,
  core_code,
  currency,
  branch_code,
  product_type,
  routing_status,
  debit_enabled,
  credit_enabled,
  valid_from,
  valid_to
from public.account_core_map
where account_id in ('VND1221200010001', '242519000')
order by account_id, valid_from desc;

select distinct product_type from account_core_map;

select distinct routing_status from account_core_map;

select * from account_core_map
where product_type = 'INTERNAL_ACCOUNT';

select * from account_core_map;