INSERT INTO public."template"
(
    event_type,
    channel_type,
    title_template,
    message_template,
    language_code,
    created_at,
    last_updated_at,
    category,
    service_required,
    is_push_only,
    customer_tenant
)
VALUES
(
    'CUSTOMER_LOAN_LOAN_REPAYMENT_REMINDER'::public.event_type,
    'IN_APP'::public.channel_type,
    'Khoản vay {{ loanContractNumber }} sẽ đến hạn trong vài ngày tới',
    'Từ 08:00 ngày {{ loanDueDate }}, Vikki sẽ sử dụng Sổ Tiết Kiệm {{ tdNumber }} để thanh toán khoản vay {{ loanContractNumber }}. Số tiền còn dư (nếu có) sẽ được chuyển vào tài khoản VikkiME của bạn.',
    'VI',
    now(),
    now(),
    'ACTIVITIES'::public.category,
    '',
    false,
    NULL
);

INSERT INTO public."template"
(
    event_type,
    channel_type,
    title_template,
    message_template,
    language_code,
    created_at,
    last_updated_at,
    category,
    service_required,
    is_push_only,
    customer_tenant
)
VALUES
(
    'CUSTOMER_LOAN_LOAN_REPAYMENT_REMINDER'::public.event_type,
    'IN_APP'::public.channel_type,
    'Your loan {{ loanContractNumber }} will due in a few days',
    'From 08:00 on {{ loanDueDate }}, we''ll use your Savings Book {{ tdNumber }} to repay your loan {{ loanContractNumber }}. Any remaining balance will be sent to your VikkiME Account.',
    'EN',
    now(),
    now(),
    'ACTIVITIES'::public.category,
    '',
    false,
    NULL
);

INSERT INTO public."template"
(
    event_type,
    channel_type,
    title_template,
    message_template,
    language_code,
    created_at,
    last_updated_at,
    category,
    service_required,
    is_push_only,
    customer_tenant
)
VALUES
(
    'CUSTOMER_LOAN_LOAN_REPAYMENT_REMINDER'::public.event_type,
    'PUSH'::public.channel_type,
    'Khoản vay {{ loanContractNumber }} sẽ đến hạn trong vài ngày tới',
    'Từ 08:00 ngày {{ loanDueDate }}, Vikki sẽ sử dụng Sổ tiết kiệm {{ tdNumber }} để thanh toán khoản vay {{ loanContractNumber }}. Số tiền còn dư (nếu có) sẽ được chuyển vào tài khoản VikkiME của bạn.',
    'VI',
    now(),
    now(),
    'ACTIVITIES'::public.category,
    '',
    false,
    NULL
);

INSERT INTO public."template"
(
    event_type,
    channel_type,
    title_template,
    message_template,
    language_code,
    created_at,
    last_updated_at,
    category,
    service_required,
    is_push_only,
    customer_tenant
)
VALUES
(
    'CUSTOMER_LOAN_LOAN_REPAYMENT_REMINDER'::public.event_type,
    'PUSH'::public.channel_type,
    'Your loan {{ loanContractNumber }} will due in a few days',
    'From 08:00 on {{ loanDueDate }}, we''ll use your Savings Book {{ tdNumber }} to repay your loan {{ loanContractNumber }}. Any remaining balance will be sent to your VikkiME Account.',
    'EN',
    now(),
    now(),
    'ACTIVITIES'::public.category,
    '',
    false,
    NULL
);