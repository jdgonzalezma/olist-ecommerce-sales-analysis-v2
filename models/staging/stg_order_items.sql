with source as (

    select * from {{ source('olist_raw', 'bronze_order_items') }}

)

select
-- Identificadores y llaves foráneas
    cast(order_id as string) as order_id,
    cast(order_item_id as int) as order_item_id,
    cast(product_id as string) as product_id,
    cast(seller_id as string) as seller_id,

    -- Fechas de logística
    cast(shipping_limit_date as timestamp) as shipping_limit_date,

    -- Valores monetarios
    cast(price as float) as price,
    cast(freight_value as float) as freight_value

from source