with promos_source as (

    select * from {{ source('src_public', 'promos') }}

)

,   renamed_casted as (

    select
          id
        , promo_id
        , discout as discount
        , status
    from promos_source

)

select * from renamed_casted