with order_items as (

    select * from {{ ref('stg_order_items') }}

)

select
    order_id,
    count(distinct order_item_id) as total_items_count,
    count(distinct product_id) as unique_products_count,
    count(distinct seller_id) as unique_sellers_count,
    sum(price) as total_price_amount,
    sum(freight_value) as total_freight_amount,
    sum(price + freight_value) as total_order_item_amount

from order_items
group by 1