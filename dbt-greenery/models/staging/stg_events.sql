{{
  config(
    materialized='view'
  )
}}

with events_source as (

    select * from {{ source('src_public', 'events') }}

)

,   renamed_events as (

    select
        id
        , event_id
        , session_id
        , user_id
        , created_at as created_at_utc
        , page_url
        , event_type

    from events_source

)

select * from renamed_events