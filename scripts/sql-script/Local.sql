SELECT id, code, name, category, status
FROM public.rule_category
WHERE code = 'FEES#FFOR#SOCA#DBRA#SIND#DBCH';

SELECT account_id, core_code, core_account_id, routing_status, valid_from, valid_to
FROM public.account_core_map
WHERE account_id IN ('666663666', '251990004.00')
   OR core_account_id IN ('666663666', '251990004.00');

INSERT INTO public.rule_category (id, code, name, category, status)
VALUES ('6389edde-d8fb-4c74-9ffd-7f26c53b07d7'::uuid, 'FEES#FFOR#SOCA#DBRA#SIND#DBCH', 'FX cancellation fee', 'CHARGE', 'ACTIVE')
ON CONFLICT (code, name) DO NOTHING;

-- Add only the disposable internal-account mapping.
INSERT INTO public.account_core_map (
    id, account_id, customer_master_id, core_customer_id,
    product_code, currency, branch_code,
    core_code, core_account_id, migration_wave_id,
    migration_status, routing_status,
    debit_enabled, credit_enabled, query_enabled,
    valid_from, valid_to, metadata,
    created_at, updated_at, alternate_account_id, product_type
)
SELECT
    gen_random_uuid(), 'FX_TEST_GL_67668567', NULL, NULL,
    NULL, 'VND', 'VN0010001',
    'T24', 'FX_TEST_GL_67668567', NULL,
    'NOT_STARTED', 'ACTIVE',
    true, true, true,
    now() - interval '1 day', NULL,
    '{"purpose":"disposable FX routing test"}'::jsonb,
    now(), now(), 'FX_TEST_GL_67668567', NULL
WHERE NOT EXISTS (
    SELECT 1
    FROM public.account_core_map m
    WHERE m.account_id = 'FX_TEST_GL_67668567'
       OR m.core_account_id = 'FX_TEST_GL_67668567'
);