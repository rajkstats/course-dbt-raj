{{
  config(
    materialized='view'
  )
}}

with addresses_source as (

    select * from {{ source('src_public', 'addresses') }}

)

,   renamed_addresses as (

    select
        id
        , address_id as address_guid
        , address
        , zipcode
        , state
        , country

    from  addresses_source

)

select * from renamed_addresses 