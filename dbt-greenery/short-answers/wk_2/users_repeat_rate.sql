-- Repeat Rate = Users who purchased 2 or more times / users who purchased

SELECT 
    SUM(CASE WHEN num_orders > 1 THEN 1.0 ELSE 0 END) / COUNT(1)
FROM (
    -- how many times each user has ordered so far
    SELECT user_guid, COUNT(1) as num_orders
    FROM dbt_raj_k.stg_users
    JOIN dbt_raj_k.stg_orders
        USING (user_guid)
    GROUP BY  1
) base
