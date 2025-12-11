#Различные соединения таблиц
#Выборка всех игр, которые находятся в разделе "Любимые" у нескольких пользователей
SELECT 
    game_name as 'Любимая игра'
FROM
    gamers a,
    games,
    gamers b
WHERE
    a.favourite_game = b.favourite_game
        AND a.favourite_game = idgame and a.`name`<b.`name`;

#Выборка всех игр, которые находятся в разделе "Любимые" у любых пользователей
SELECT 
    `games`.`game_name`, `gamers`.`name`
FROM
    `games`,
    `gamers`
WHERE
    `gamers`.`favourite_game` = `games`.`idgame`
ORDER BY game_name;

#Оператор JOIN
SELECT 
    *
FROM
    gamers
        JOIN
    gamers_games USING (idgamers);
#"Левое" и "правое" соединение
SELECT 
    *
FROM
    games
        LEFT JOIN
    gamers USING (country);
    
    SELECT DISTINCT
    country
FROM
    games
        RIGHT JOIN
    gamers USING (country);
#Внутреннее соединение
SELECT DISTINCT
    *
FROM
    games
        INNER JOIN
    gamers USING (country);
SELECT DISTINCT
    *
FROM
    games
        CROSS JOIN
    gamers USING (country);
# Соединение JOIN при помощи ON   
SELECT 
    *
FROM
    games
        JOIN
    gamers_games ON idgame = game
order by game_name;

#Таблица с циклическими зависимостями. Соединение таблицы с собой
SELECT 
	t1.`сотрудник` as начальник, 'над', t2.`сотрудник` подчинённый 
FROM 	bd1.`сотрудники` t1 
		LEFT JOIN
		bd1.`сотрудники` t2 ON t1.`ид_сотрудника` = t2.`номер_начальника`;
SELECT 
	t1.`сотрудник` as начальник, 'над', t2.`сотрудник` подчинённый 
FROM 	bd1.`сотрудники` t1 
		RIGHT JOIN
		bd1.`сотрудники` t2 ON t1.`ид_сотрудника` = t2.`номер_начальника`;
#"Естественное соединение" при помощи NATURAL JOIN
SELECT 
    `name`, `date`, `game_name`
FROM
    gamers
        NATURAL JOIN
    gamers_games
        NATURAL JOIN
    games;
    
#При совпадении названий внешних ключей в связанных таблицах с первичными ключами можно использовать JOIN ON
SELECT 
    `name`, `date`, `game_name`
FROM
    gamers
        JOIN
    gamers_games ON (idgamers)
        JOIN
    games ON (idgame);