select created_at, payment_id, route_type, strategy, target_core_code,
       decision_status, decision_reason, matched_rule_id, decision_context
from payment_route_decision
where payment_id in ('FT26111700005369', 'FT26111700000005')  -- fee, then hold/release
order by created_at;

select account_id, core_account_id, alternate_account_id, core_code, product_type,
       migration_status, routing_status, debit_enabled, credit_enabled,
       valid_from, valid_to, updated_at
from account_core_map
where account_id      in ('666663666', '251990004.00', '251990004')
   or core_account_id in ('666663666', '251990004.00', '251990004')
order by account_id, valid_from desc;

-- the exact code the fee sends
select code, name, category, status, updated_at
from rule_category
where code = 'FEES#FFOR#SOCA#DBRA#SIND#DBCH';

-- everything that is seeded, for context
select code, name, category, status
from rule_category
order by category, code;

select rule_code, rule_name, rule_type, domain, operation, priority, exception_case,
       enabled, target_core_code, route_type, condition_expression, valid_from, valid_to
from core_route_rule
where domain ilike '%PAYMENT%'
  and enabled = true
  and valid_from <= now()
  and (valid_to is null or valid_to > now())
order by exception_case desc, priority asc;

select id, domain, family, sub_family, description, rtf_type, channel,
       account_number, client_id
from internal_account_mapping
where domain = 'PMNT' and family = 'IRCT'
  and sub_family in ('CAFX', 'FXSE')    -- cancel fee, FX bank sell
order by sub_family;