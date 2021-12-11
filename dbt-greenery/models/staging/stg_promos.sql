{{
  config(
    materialized='view'
  )
}}

with promos_source as (

    select * from {{ source('src_public', 'promos') }}

)

,   renamed_promos as (

    select
          id
        , promo_id
        , discout as discount
        , status
    
    from promos_source

)

select * from renamed_promos