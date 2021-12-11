WITH time_taken_for_delivery_in_days AS
(
SELECT 
order_id,
created_at,
delivered_at,
extract( days FROM (delivered_at-created_at)) as time_taken_for_delivery_in_days
FROM dbt_raj_k_stg.stg_orders 
WHERE status= 'delivered'
)
SELECT round(avg(time_taken_for_delivery_in_days)::numeric,2)
FROM  time_taken_for_delivery_in_days