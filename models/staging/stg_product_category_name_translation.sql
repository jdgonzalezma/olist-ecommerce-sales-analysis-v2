with source as (

    select * from {{ source('olist_raw', 'bronze_product_category_name_translation') }}

)

select
    -- Nombres y traducciones de las categorías 
    cast(product_category_name as string) as product_category_name,
    cast(product_category_name_english as string) as product_category_name_english

from source