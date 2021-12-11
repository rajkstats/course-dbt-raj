WITH num_orders_by_users AS(
    SELECT 
    user_id,
    count(distinct order_id) as num_orders
    FROM dbt_raj_k_stg.stg_orders 
    GROUP BY 1
)
SELECT 
CASE 
    WHEN num_orders <=1 THEN 'one_purchase'
    WHEN num_orders>1 AND  num_orders<=2 THEN ' two_purchases'
    ELSE 'three_plus_purchases' 
END as num_purchases,
count(user_id ) as num_users
FROM num_orders_by_users 
GROUP BY 1
ORDER BY 2