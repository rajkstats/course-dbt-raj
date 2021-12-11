-- this dataset can be used by marketing stakeholders at greenery for sending marketing campaigns to customers who are interested in shopping ,
-- , buying and (shopping & buying)
{{ config(materialized='table') }}
SELECT
      user_sess_act.session_id
    , user_sess_act.user_guid
    , users.email
    , user_sess_act.shopping_activity
    , user_sess_act.buying_activity
FROM
    {{ ref('int_user_sessions_activity') }} user_sess_act
    LEFT JOIN {{ ref('stg_users') }} users
    ON (users.user_guid = user_sess_act.user_guid)