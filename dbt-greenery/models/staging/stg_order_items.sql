{{
  config(
    materialized='view'
  )
}}

with order_items_source as (

    select * from {{ source('src_public', 'order_items') }}

)

,   renamed_order_items as (

    select
          id
        , order_id as order_guid
        , product_id
        , quantity

    from order_items_source

)

select * from renamed_order_items