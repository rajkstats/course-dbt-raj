{{ config(materialized='table') }}

SELECT *
FROM {{ ref('int_page_views') }}