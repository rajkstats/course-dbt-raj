WITH num_orders_by_hour AS (
    SELECT  date_trunc('hour', created_at) as hr, 
    count(distinct order_id) as num_orders
    FROM dbt_raj_k_stg.stg_orders
    GROUP BY 1
)
SELECT round(avg(num_orders),0) as avg_num_orders_received_per_hr
FROM num_orders_by_hour