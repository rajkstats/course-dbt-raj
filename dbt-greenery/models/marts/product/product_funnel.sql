{{
  config(
    materialized='table'
  )
}}

SELECT
  ROUND(SUM(sessions_w_has_add2cart_checkout_pgview)/SUM(unique_sessions)*100.0,4) as per_session_w_pgview
, ROUND(SUM(sessions_w_add2cart_checkout)/SUM(sessions_w_has_add2cart_checkout_pgview)*100.0,2) as per_sessions_w_has_add2cart_checkout_pgview
, ROUND(SUM(sessions_w_checkout)/SUM(sessions_w_add2cart_checkout)*100.0,2) as per_sessions_w_add2cart_checkout
, ROUND(SUM(sessions_w_checkout)/SUM(sessions_w_has_add2cart_checkout_pgview) *100.0 ,2) as per_sessions_w_checkout
FROM {{ ref('int_product_funnel_daily') }} 
