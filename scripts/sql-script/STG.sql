select * from partner_integration_config
where integration_type = 'FCC_ACCOUNT_BALANCE_INQUIRY';

select * from partner_integration_config
where request_transformer_filter is not null;

select * from partner_integration_config
where payload_signature_filter is not null;