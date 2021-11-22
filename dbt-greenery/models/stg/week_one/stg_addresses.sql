with addresses_source as (

    select * from {{ source('src_public', 'addresses') }}

)

,   renamed_casted as (

    select
        id
        , address_id
        , address
        , zipcode
        , state
        , country

    from  addresses_source

)

select * from renamed_casted