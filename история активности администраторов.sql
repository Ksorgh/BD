SELECT 
    `player_name`,
    `connect_time`,
    `duration_minutes`,
    `actions_count`,
    `admin_id`
FROM
    players
        NATURAL JOIN
    admins
        NATURAL JOIN
    admin_sessions
ORDER BY `connect_time`;
