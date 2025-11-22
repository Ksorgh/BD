#Подзапрос
SELECT 
    *
FROM
    gamers_games
WHERE
    idgamers = (SELECT 
            idgamers
        FROM
            gamers
        WHERE
            name = 'efimov');
            
#Подзапрос с неск результатами (нерабочий)
SELECT 
    *
FROM
    gamers_games
WHERE
    idgamers = (SELECT 
            idgamers
        FROM
            gamers
        WHERE
            country = 'USA');

#Модернезироанный запрос с неск результатами (в  условии IN)
SELECT 
    *
FROM
    gamers_games
WHERE
    idgamers IN (SELECT 
            idgamers
        FROM
            gamers
        WHERE
            country = 'USA');

#Использовагние агрегатных функций
SELECT 
    *
FROM
    gamers_games
WHERE
    UNIX_TIMESTAMP(`time`) > (SELECT 
            AVG(UNIX_TIMESTAMP(`time`))
        FROM
            gamers_games)
ORDER BY `time`;

#выражения в подзапросе
SELECT 
    *
FROM
    gamers
WHERE
    UNIX_TIMESTAMP(`level`) > (SELECT 
            AVG(`level`) + 10
        FROM
            gamers_games)
            order by `level`; 

#Использование группировки с HAVING при анализе результатов подзапроса
SELECT 
    `level`, count(idgamers)
FROM
    gamers
group by `level`
having `level` > (SELECT 
            AVG(`level`)
        FROM
            gamers
            where country = 'USA');
            
#Связанные (коррелированные) подзапросы
#сканирование внешней таблицы (проверка для каждой) на проверку выполнения условия равенства значений в подзапросе дате 2017-02-01
SELECT 
    *
FROM
    gamers `outer`
WHERE
    '2017-02-01' IN (SELECT 
            `date`
        FROM
            gamers_games `inner`
        WHERE
            `outer`.idgamers = `inner`.idgamers);

#Использование значений полученных в качестве подсчета строк в подзапроссе, соотвествующих каждой строчки внешней таблице
SELECT 
    *
FROM
    gamers `outer`
WHERE
    2 < (SELECT 
            count(*)
        FROM
            gamers_games `inner`
        WHERE
            `outer`.idgamers = `inner`.idgamers);


#Поиск тех игр которые не относятся к любимым ни у одного геймера
SELECT 
    *
FROM
    games `outer`
WHERE
    NOT idgames IN (SELECT 
            favourite_game
        FROM
            gamers `inner`
        WHERE
            `outer`.idgames = `inner`.favourite_game);
            
#Связь таблицы с собой
#подсчитываем среднее сзначене времени для каждого пользователя и выводим значения time
SELECT 
    *
FROM
    gamers_games `outer`
WHERE
    `time` > (SELECT 
            avg(`time`)
        FROM
            gamers_games `inner`
        WHERE
            `outer`.idgamers = `inner`.idgamers);
            
#функция в степень
select pow(2,2);


#ГРуппировка во внешнем связанном запросе
#Ищем все даты для которых сумма времени больше как минимум на 20% чем максимальное время на эту дату
SELECT 
`date`, TIME(SUM(`time`))
FROM
    gamers_games `outer`
group by `date`
having SUM(`time`) > (SELECT 
            MAX(`time`)
        FROM
            gamers_games `inner`
        WHERE
            `outer`.`date` = `inner`.`date`);

#вывод игроков которые проводят выше среднего времени на сервере
SELECT 
    *
FROM
    player_sessions `outer`
WHERE
    `duration_minutes` > (SELECT 
            avg(`duration_minutes`)
        FROM
            player_sessions `inner`);


#вывод игроков без банов
SELECT
	player_name as 'Игрок',
    steam_id as 'SteamID',
    balance as 'Баланс',
    registration_date as 'Дата регистрации'
    FROM 
    players
    where 
    player_id 
    not in (select player_id 
    from  bans);


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