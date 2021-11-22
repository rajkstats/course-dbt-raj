with order_items_source as (

    select * from {{ source('src_public', 'order_items') }}

)

,   renamed_casted as (

    select
          id
        , order_id
        , product_id
        , quantity

    from order_items_source

)

select * from renamed_casted