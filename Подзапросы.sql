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
            
            
#---------------------------------------------------------------------------------------------

#вывод игроков которые проводят выше среднего времени на сервере
SELECT 
    *
FROM
    player_sessions `outer`
WHERE
    `duration_minutes` > (SELECT 
            avg(`duration_minutes`)
        FROM
            player_sessions `inner`
            where
            `outer`.`player_id` = `inner`.`player_id`);


#вывод игроков получивших больше одного бана
SELECT 
    *
FROM
    players `outer`
WHERE
    1 < (SELECT 
            count(*)
        FROM
            bans `inner`
        WHERE
            `outer`.player_id = `inner`.player_id);


#вывод админов которые вынесли больше двух наказаний
SELECT 
    player_name, admin_id, steam_id
FROM
    admins `outer`,
    players
WHERE
    2 < (SELECT 
            COUNT(*)
        FROM
            bans `inner`
        WHERE
            `outer`.admin_id = `inner`.admin_id
                AND `outer`.player_id = players.player_id);

#---------------------------------------------------------------------------------------------
#Оператор EXISTS - выводит результат если подзапрос выдает какое либо значение 
SELECT 
    `name`, `dob`
FROM
    gamers
WHERE
    EXISTS( SELECT 
            *
        FROM
            gamers
        WHERE
            country = 'USA');
            
#использвание оператора екзист со связанными подзапросами
#поиск игроков, у которых любимая игра совпадает с другими игроками
SELECT 
    *
FROM
    gamers `outer`
WHERE
    EXISTS( SELECT 
            *
        FROM
            gamers `inner`
        WHERE
            `outer`.favourite_game = `inner`.favourite_game
                AND `inner`.idgamers <> `outer`.idgamers);
                
#соединние таблиц связанных подзапросах
SELECT 
    `name`,`outer`.`country`,`game_name`
FROM
    gamers `outer`, games
WHERE
    EXISTS( SELECT 
            *
        FROM
            gamers `inner`
        WHERE
            `outer`.favourite_game = `inner`.favourite_game
                AND `inner`.idgamers <> `outer`.idgamers
					and `outer`.favourite_game = `games`.idgames); 
                    
#спользование нот екзист
SELECT 
    *
FROM
    gamers `outer`
WHERE
    NOT EXISTS( SELECT 
            *
        FROM
            gamers `inner`
        WHERE
            `outer`.favourite_game = `inner`.favourite_game
                AND `inner`.idgamers <> `outer`.idgamers);
                
                

#podzapros vtorogo yrovnya vlozhenosti

SELECT 
    *
FROM
    games `outer1`
WHERE
    EXISTS( SELECT 
            *
        FROM
            gamers `outer2`
        WHERE
            `outer1`.idgames = `outer2`.favourite_game
                AND 1 < (SELECT 
                    COUNT(*)
                FROM
                    gamers_games `inner`
                WHERE
                    `inner`.idgamers = `outer2`.idgamers));
        
