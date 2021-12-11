select 
    *
from 
    {{ ref('fct_orders') }}
where 
     created_at_utc > delivered_at_utc