with source as (

    select * from {{ source('olist_raw', 'bronze_geolocation') }}

),

aggregated as (

    select
        cast(geolocation_zip_code_prefix as string) as geolocation_zip_code_prefix,
        -- Coordenadas -> FLOAT / DOUBLE (promedio para deduplicar por código postal)
        avg(cast(geolocation_lat as float)) as latitude,
        avg(cast(geolocation_lng as float)) as longitude,
        -- Ubicación -> STRING
        max(cast(geolocation_city as string)) as city,
        max(cast(geolocation_state as string)) as state

    from source
    group by 1

)

select * from aggregated