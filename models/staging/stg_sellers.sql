with source as (

    select * from {{ source('olist_raw', 'bronze_sellers') }}

)

select
    -- Identificador del vendedor
    cast(seller_id as string) as seller_id,

    -- Ubicación
    cast(seller_zip_code_prefix as string) as seller_zip_code_prefix,
    cast(seller_city as string) as seller_city,
    cast(seller_state as string) as seller_state

from source