#потраченые суммы на привилегии
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