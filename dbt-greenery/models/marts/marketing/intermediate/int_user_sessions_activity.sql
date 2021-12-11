-- this table captures all the user level activities in each of the user's session 
-- events are activities which user performs on the website which I'm further categorizing into shopping and buying 
-- this can further help us identify customer who are interested in shopping and customers who are interested in buying who have high probability of getting converted
{{ config(materialized='view') }}

SELECT 
      user_id as user_guid
    , session_id
    , SUM(CASE WHEN event_type IN ('account_created','page_view') THEN 1 ELSE 0 END) AS shopping_activity
    , SUM(CASE WHEN event_type IN ('add_to_cart','checkout','package_shipped') THEN 1 ELSE 0 END) AS buying_activity
FROM  {{ ref('stg_events') }}
GROUP BY 1,2   


