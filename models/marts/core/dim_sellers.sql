with sellers as (

    select * from {{ ref('stg_sellers') }}

),

geolocation as (

    select * from {{ ref('stg_geolocation') }}

)

select
    s.seller_id,
    s.seller_zip_code_prefix,
    s.seller_city,
    s.seller_state,
    g.latitude as seller_lat,
    g.longitude as seller_lng

from sellers s
left join geolocation g
    on s.seller_zip_code_prefix = g.geolocation_zip_code_prefix