#Допускается применение выражений в предложении SELECT
SELECT 
    `country` as 'Страна', 'Цена рекомендованная:', AVG(price) as 'Цена', 'Цена в России:', AVG(price) * 1.2 * 81.23 as 'Цена с НДС'
FROM
    games
WHERE
    country IS NOT NULL
GROUP BY country;

#Использование INTERVAL
SELECT 
    `gamers_games`.`idgamers_games`,
    `gamers_games`.`game`,
    `gamers_games`.`date` + INTERVAL 14 DAY + interval 12 hour as 'Дата после прошествия двух недель',
    `gamers_games`.`time` + interval 10 hour
FROM
    `bd1`.`gamers_games`;

#INTERVAL в предложении where
SELECT 
    `gamers_games`.`idgamers_games`,
    `gamers_games`.`game`,
    `gamers_games`.`date`
FROM
    bd1.gamers_games
WHERE
    date < '2017-01-01' + INTERVAL 6 MONTH AND date > '2016-01-01' - INTERVAL 6 MONTH;

#Применение условных выражений CASE для изменения отображаемых данных
SELECT 
    CASE `name`
        WHEN 'Beresnev' THEN 'beresnev'
        WHEN 'Agaeva' THEN 'agaeva'
        ELSE `name`
    END
FROM
    `gamers`;
    
    #Сортировка значений
SELECT 
    `gamers`.`idgamers`,
    `gamers`.`name`,
    `gamers`.`country`,
    `gamers`.`favourite_game`,
    `gamers`.`dob`
FROM
    `bd1`.`gamers`
ORDER BY country;

SELECT 
    `gamers`.`idgamers`,
    `gamers`.`name`,
    `gamers`.`country`,
    `gamers`.`favourite_game`,
    `gamers`.`dob`
FROM
    `bd1`.`gamers`
ORDER BY country desc;
# Сортировка столбцов с указанием их номера
SELECT 
    `gamers`.`name`,
    `gamers`.`country`,
    `gamers`.`favourite_game`,
    `gamers`.`dob`
FROM
    `bd1`.`gamers`
ORDER BY 2, 1;
#Сортировка по агрегатным группам
SELECT 
    `gamers`.`country`, MIN(dob)
FROM
    `bd1`.`gamers`
WHERE
    country IS NOT NULL
GROUP BY country
ORDER BY 2;
SELECT 
    `gamers`.`country`, MIN(dob)
FROM
    `bd1`.`gamers`
WHERE
    country IS NOT NULL
GROUP BY country
ORDER BY 1;

#Соединение таблиц
#"Естественное" соединение - отбираются значения в одной таблицы, которые ссылаются на эти же значения (первичный ключ) в другой таблице
SELECT 
    `name`, game_name
FROM
    `gamers`,
    `games`
WHERE
    favourite_game = games.idgame;
#"Неестественное" соединение
SELECT 
    `name`, COUNT(game_name)
FROM
    `gamers`,
    `games`
WHERE
    gamers.country = games.country
GROUP BY `name`;
SELECT 
    `name`, COUNT(game_name)
FROM
    `gamers`,
    `games`
WHERE
    gamers.country = games.country AND games.country='США'
GROUP BY `name`;
#Использование пседноимов (alias) для таблиц
SELECT 
    `name`, COUNT(game_name)
FROM
    `gamers` `игроки`,
    `games` `игры`
WHERE
    `игроки`.country = `игры`.country AND `игры`.country='США'
GROUP BY `name`;
#Использование неравенств позволяет убрать очевидно лишние пары при сравнении значений между одной и той же таблицей
SELECT 
    g1.`name`, g2.`name`
FROM
    `gamers` g1,
    `gamers` g2,
    games gm
WHERE
    g1.country = gm.country
        AND g1.dob = g2.dob and g1.`name` < g2.`name`;
#Таблица с циклическими зависимостями. Соединение таблицы с собой
SELECT t1.`сотрудник` as начальник, 'над', t2.`сотрудник` подчинённый FROM bd1.`сотрудники` t1,
bd1.`сотрудники` t2
where
t1.`ид_сотрудника` = t2.`номер_начальника`;
#"Преобразование" таблицы в колонки по значению страны
SELECT 
    a.`game_name` as 'США',
    b.`game_name` as 'Китай',
    c.`game_name` as 'Россия',
    d.`game_name` as 'Южная Корея'
FROM
    `bd1`.`games` a,
    `bd1`.`games` b,
    `bd1`.`games` c,
    `bd1`.`games` d
WHERE
    a.country = 'США' and b.country = 'Китай' and c.country = 'Россия' and d.country = 'Южная Корея';
