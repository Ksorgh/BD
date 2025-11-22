#История активности администраторов 
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

#Пополнение баланса сайта игроками
SELECT 
	`amount` as 'Сумма',
    `player_name` as 'Никнейм',
    `steam_id` as 'SteamID64',
    `transaction_date` as 'Дата'
FROM 
	transactions
	NATURAL JOIN players
		WHERE `amount` > 0;

#История покупок привилегий
SELECT 
    abs(amount) AS 'Сумма',
    privileges.name AS 'Привилегия',
    player_name AS 'Никнейм',
    steam_id AS 'SteamID64',
    transaction_date AS 'Дата'
FROM
    transactions
        JOIN
    players ON players.player_id = transactions.player_id
        JOIN
    privileges ON transactions.related_privilege_id = privileges.privilege_id
WHERE
    transaction_type = 'purchase'
order by transaction_date desc;


#Статистика администраторов по наказаниям
SELECT 
    p.player_name AS 'Администратор',
    bt.name AS 'Тип_бана',
    COUNT(b.ban_id) AS 'Количество_банов',
    AVG(b.duration_minutes) AS 'Средняя_длительность_мин',
    MIN(b.ban_date) AS 'Первый_бан',
    MAX(b.ban_date) AS 'Последний_бан'
FROM admins a
JOIN players p ON a.player_id = p.player_id
JOIN bans b ON a.admin_id = b.admin_id
JOIN ban_types bt ON b.ban_type_id = bt.ban_type_id
WHERE a.is_active = 1
GROUP BY p.player_name, bt.name
HAVING COUNT(b.ban_id) > 0
ORDER BY Количество_банов DESC;


#Статистика игроков по транзакиям
SELECT 
    p.player_name AS 'Никнейм',
    p.steam_id AS 'SteamID',
    p.balance AS 'Текущий_баланс',
    SUM(CASE WHEN t.transaction_type = 'deposit' THEN t.amount ELSE 0 END) AS 'Всего_пополнено',
    SUM(CASE WHEN t.transaction_type = 'withdrawal' THEN ABS(t.amount) ELSE 0 END) AS 'Всего_выведено',
    SUM(CASE WHEN t.transaction_type = 'purchase' THEN ABS(t.amount) ELSE 0 END) AS 'Всего_потрачено',
    COUNT(t.transaction_id) AS 'Всего_транзакций',
    MAX(t.transaction_date) AS 'Последняя_транзакция'
FROM players p
LEFT JOIN transactions t ON p.player_id = t.player_id
GROUP BY p.player_id, p.player_name, p.steam_id, p.balance
HAVING Всего_транзакций > 0
ORDER BY Всего_потрачено DESC;

#Статистика сервера за неделю
SELECT 
    (SELECT COUNT(*) FROM players) AS 'Всего_игроков',
    (SELECT COUNT(*) FROM players WHERE last_seen >= DATE_SUB(NOW(), INTERVAL 7 DAY)) AS 'Активных_за_неделю',
    (SELECT COUNT(*) FROM player_privileges WHERE is_active = 1 AND expire_date > NOW()) AS 'Активных_привилегий',
    (SELECT COUNT(*) FROM bans WHERE is_active = 1) AS 'Активных_банов',
    (SELECT SUM(amount) FROM transactions WHERE transaction_type = 'deposit') AS 'Всего_пополнений'
FROM player_sessions;


#вывод топ 5 игроков по онлайну
SELECT 
    player_name AS 'Игрок',
    steam_id AS 'SteamID',
    (
        SELECT ROUND(SUM(TIMESTAMPDIFF(MINUTE, connect_time, disconnect_time)) / 60, 1)
        FROM player_sessions ps 
        WHERE ps.player_id = p.player_id
    ) AS 'Часов_всего'
FROM players p
ORDER BY Часов_всего DESC
LIMIT 5;