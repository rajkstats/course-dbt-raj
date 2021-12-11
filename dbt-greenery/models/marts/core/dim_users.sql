{{ config(materialized='table') }}

SELECT user_guid,
    first_name, 
    last_name, 
    email,
    created_at_utc,
    zipcode,
    state,
    country
FROM {{ref('stg_users')}} AS u
LEFT JOIN {{ref('stg_addresses')}} AS a
      USING (address_guid)