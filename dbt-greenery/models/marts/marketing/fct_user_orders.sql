{{ config(materialized='table') }}

-- this fact table makes it easier to answer user repeat rate kind of questions

SELECT 
    user_guid,
    COUNT(1) as num_orders
FROM {{ref('dim_users')}}
JOIN {{ref('fct_orders')}}
    USING (user_guid)
GROUP BY user_guid
