-- number of sessions that had a checkout event / total number of unique sessions

{{sessions_with_checkout()}}

SELECT 
    SUM(has_checkout)::numeric / COUNT(session_id) as conv_rate
FROM sessions_with_checkout