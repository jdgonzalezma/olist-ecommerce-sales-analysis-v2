with source as (

    select * from {{ source('olist_raw', 'bronze_order_payments') }}

)

select
    -- Identificador de la orden
    cast(order_id as string) as order_id,
    
    -- Secuencia de pago (en caso de múltiples métodos para una misma orden)
    cast(payment_sequential as int) as payment_sequential,

    -- Método y condiciones de pago
    cast(payment_type as string) as payment_type,
    cast(payment_installments as int) as payment_installments,

    -- Valor monetario
    cast(payment_value as float) as payment_value

from source