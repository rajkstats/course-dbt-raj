with products_source as (

    select * from {{ source('src_public', 'products') }}

)

,   renamed_casted as (

    select
          id
        , product_id
        , name
        , price
        , quantity
    from products_source

)

select * from renamed_casted