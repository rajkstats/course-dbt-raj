WITH num_sessions_by_hour AS (
    SELECT  date_trunc('hour', created_at) as hr, 
    count(distinct session_id) as num_unique_sessions
    FROM dbt_raj_k_stg.stg_events
    GROUP BY 1
)
SELECT round(avg(num_unique_sessions),2) as avg_unique_sessions_per_hr
FROM num_sessions_by_hour