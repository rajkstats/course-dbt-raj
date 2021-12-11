{{ config(materialized='table') }}
-- price is dynamic and keeps changing on every order, hence not including here
 
SELECT 
    product_id as product_guid,
    name,
    quantity as product_in_stock
FROM {{ref('stg_products')}}