with users_source as (

    select * from {{ source('src_public', 'users') }}

)

,   renamed_casted as (

    select
          id
        , user_id
        , first_name
        , last_name
        , email
        , phone_number
        , created_at
        , updated_at
        , address_id
    from users_source

)

select * from renamed_casted