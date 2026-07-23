with source as (

    select * from {{ source('olist_raw', 'bronze_order_reviews') }}

)

select
    -- Identificadores de las reseñas
    cast(review_id as string) as review_id,
    cast(order_id as string) as order_id,
    
    -- Contenido y calificación
    cast(review_score as int) as review_score,
    cast(review_comment_title as string) as review_comment_title,
    cast(review_comment_message as string) as review_comment_message,

    -- Marcas de tiempo
    cast(review_creation_date as date) as review_creation_date,
    cast(review_answer_timestamp as timestamp) as review_answer_timestamp

from source
where review_id is not null 
  and order_id is not null