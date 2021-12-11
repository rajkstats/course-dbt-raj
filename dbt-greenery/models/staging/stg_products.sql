{{
  config(
    materialized='view'
  )
}}

with products_source as (

    select * from {{ source('src_public', 'products') }}

)

,   renamed_products as (

    select
          id
        , product_id
        , name
        , price
        , quantity
  
    from products_source

)

select * from renamed_products