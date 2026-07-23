with payments as (

    select * from {{ ref('stg_order_payments') }}

)

select
    order_id,
    sum(case when payment_type = 'credit_card' then payment_value else 0 end) as credit_card_payment_value,
    sum(case when payment_type = 'boleto' then payment_value else 0 end) as boleto_payment_value,
    sum(case when payment_type = 'voucher' then payment_value else 0 end) as voucher_payment_value,
    sum(case when payment_type = 'debit_card' then payment_value else 0 end) as debit_card_payment_value,
    sum(payment_value) as total_payment_value,
    max(payment_sequential) as total_payment_installments_count

from payments
group by 1