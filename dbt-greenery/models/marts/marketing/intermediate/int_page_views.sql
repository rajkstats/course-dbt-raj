{{ config(materialized='view') }}

SELECT
    event_id,
    created_at_utc,
    session_id,
    user_id,
    page_url
FROM
    {{ ref('stg_events') }}
WHERE
    event_type = 'page_view'