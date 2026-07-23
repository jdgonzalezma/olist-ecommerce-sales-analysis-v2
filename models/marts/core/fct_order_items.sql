with order_items as (

    select * from {{ ref('stg_order_items') }}

),

orders as (

    select * from {{ ref('stg_orders') }}

)

select
    -- Primary Key compuesta / Surrogate Key en dbt
    concat(i.order_id, '-', cast(i.order_item_id as string)) as order_item_key,
    
    -- Foreign Keys
    i.order_id,
    i.order_item_id,
    i.product_id,
    i.seller_id,
    o.customer_id,

    -- Fechas
    i.shipping_limit_date,
    o.order_purchase_timestamp,

    -- Métricas
    i.price,
    i.freight_value,
    (i.price + i.freight_value) as total_item_value

from order_items i
left join orders o
    on i.order_id = o.order_id