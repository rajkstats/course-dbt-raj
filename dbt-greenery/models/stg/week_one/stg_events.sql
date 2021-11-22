with events_source as (

    select * from {{ source('src_public', 'events') }}

)

,   renamed_casted as (

    select
        id
        , event_id
        , session_id
        , user_id
        , created_at
        , event_type

    from events_source

)

select * from renamed_casted