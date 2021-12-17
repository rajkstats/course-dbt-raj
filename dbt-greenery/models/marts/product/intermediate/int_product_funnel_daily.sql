-- Sessions with any event of type page_view / add_to_cart / checkout
-- Sessions with any event of type add_to_cart / checkout
-- Sessions with any event of type checkout

{{
  config(
    materialized='view'
  )
}}

WITH sessions_with_events as (
SELECT
  session_id
, created_at_utc
, MAX(CASE WHEN event_type IS NOT NULL THEN 1 ELSE 0 END) as num_sessions
, MAX(CASE WHEN event_type = 'add_to_cart' or event_type = 'checkout' or event_type='page_view' THEN 1 ELSE 0 END) as has_add2cart_checkout_pgview
, MAX(CASE WHEN event_type= 'add_to_cart' or event_type= 'checkout' THEN 1 ELSE 0 END) as has_add2cart_checkout
, MAX(CASE WHEN event_type= 'checkout' THEN 1 ELSE 0 END) as has_checkout
FROM {{ ref('stg_events') }} 
GROUP BY session_id
, created_at_utc
)

SELECT  
    created_at_utc
  , SUM(num_sessions) as unique_sessions
  , SUM(CASE WHEN (has_add2cart_checkout_pgview > 0 or has_add2cart_checkout > 0 or has_checkout > 0) THEN 1 ELSE 0 END) as sessions_w_has_add2cart_checkout_pgview
  , SUM(CASE WHEN (has_add2cart_checkout > 0 or has_checkout > 0) THEN 1 ELSE 0 END) as sessions_w_add2cart_checkout
  , SUM(CASE WHEN has_checkout > 0 THEN 1 ELSE 0 END) as sessions_w_checkout
  FROM sessions_with_events

GROUP BY 1
ORDER BY 1 ASC