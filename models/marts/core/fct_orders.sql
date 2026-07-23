with orders as (

    select * from {{ ref('stg_orders') }}

),

payments as (

    select * from {{ ref('int_order_payments_pivoted') }}

),

items as (

    select * from {{ ref('int_order_items_summary') }}

)

select
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,

    -- Métricas de ítems
    coalesce(i.total_items_count, 0) as total_items_count,
    coalesce(i.unique_products_count, 0) as unique_products_count,
    coalesce(i.unique_sellers_count, 0) as unique_sellers_count,
    coalesce(i.total_price_amount, 0) as total_price_amount,
    coalesce(i.total_freight_amount, 0) as total_freight_amount,

    -- Métricas de pago
    coalesce(p.credit_card_payment_value, 0) as credit_card_payment_value,
    coalesce(p.boleto_payment_value, 0) as boleto_payment_value,
    coalesce(p.voucher_payment_value, 0) as voucher_payment_value,
    coalesce(p.debit_card_payment_value, 0) as debit_card_payment_value,
    coalesce(p.total_payment_value, 0) as total_payment_value

from orders o
left join payments p
    on o.order_id = p.order_id
left join items i
    on o.order_id = i.order_id