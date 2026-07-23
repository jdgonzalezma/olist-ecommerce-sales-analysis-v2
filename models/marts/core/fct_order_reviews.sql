with order_reviews as (

    select * from {{ ref('stg_order_reviews') }}

),

orders as (

    select order_id from {{ ref('stg_orders') }}

)

select
    r.review_id,
    r.order_id,
    r.review_score,
    r.review_comment_title,
    r.review_comment_message,
    r.review_creation_date,
    r.review_answer_timestamp

from order_reviews r
inner join orders o
    on r.order_id = o.order_id