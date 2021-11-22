**Answers to short answer questions with queries**

- How many users do we have?

```sql
// counts distinct users
SELECT count(distinct user_id) as num_users
FROM dbt_raj_k_stg.stg_users
```
*Answer*: We have **130** users 

- On average, how many orders do we receive per hour?

```sql
// Average number of orders per hour
// Rounded because num of orders should be an integer
WITH num_orders_by_hour AS (
    SELECT  date_trunc('hour', created_at) as hr, 
    count(distinct order_id) as num_orders
    FROM dbt_raj_k_stg.stg_orders
    GROUP BY 1
)
SELECT round(avg(num_orders),0) as avg_num_orders_received_per_hr
FROM num_orders_by_hour
```
*Answer*: We receive **8 orders** on an average per hour



- On average, how long does an order take from being placed to being delivered?

```sql
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
```
*Answer*: On an average, it takes **3.93 days** for an order from being placed to delivered



- How many users have only made one purchase? Two purchases? Three+ purchases?

```sql

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

```
| num_purchases  | num_users  | 
| :------------ |:---------------:| 
| one_purchase      | 25 | 
| two_purchases      | 22       | 
| three_plus_purchases  | 81        |



- On average, how many unique sessions do we have per hour?

```sql

WITH num_sessions_by_hour AS (
    SELECT  date_trunc('hour', created_at) as hr, 
    count(distinct session_id) as num_unique_sessions
    FROM dbt_raj_k_stg.stg_events
    GROUP BY 1
)
SELECT round(avg(num_unique_sessions),2) as avg_unique_sessions_per_hr
FROM num_sessions_by_hour

```
*Answer*: On an average, we receive **7.39 sessions** per hour