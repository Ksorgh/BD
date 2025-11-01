/* Простые запросы с использованием select */
SELECT 
    *
FROM
    games;
    
SELECT 
    `gamers`.`idgamers`,
    gamers.`name`,
    `gamers`.`country`,
    `gamers`.`favourite_game`,
    `gamers`.`dob`
FROM
    `bd1`.`gamers`;
SELECT 
    gamers.`name`,
    `gamers`.`country`
FROM
    `bd1`.`gamers`;    
    
/* Выборка из нескольких таблиц с соединением */
SELECT 
    `gamers`.`idgamers`,
    gamers.`name`,
    `gamers`.`country`,
    `gamers`.`favourite_game`,
    `gamers`.`dob`
FROM
    `bd1`.`gamers`;
SELECT ALL
    gamers.`name`, games.`game_name`, games.`country` as 'Страна разработчика'
FROM
    `bd1`.`gamers`,
    games
WHERE
    favourite_game = `games`.`idgame`;  

/*Исключение дублирующихся значений из результатов запроса*/
SELECT DISTINCT
    `country`
FROM
    games;
    
/*Исключаются только полностью совпадающие строки */
SELECT DISTINCT
    `gamer`, `game`
FROM
    bd1.gamers_games;
    
/*Использование фильтрации значений (предложение WHERE)*/
SELECT 
    gamers.`name`
FROM
    `bd1`.`gamers`
WHERE
    `favourite_game` = 102;

/* Операции сравнения "=, <>, <=, >=" */
SELECT 
    gamers.`name`, country
FROM
    `bd1`.`gamers`
WHERE
    `country` = 'Китай';
    
SELECT 
    gamers.`name`, country
FROM
    `bd1`.`gamers`
WHERE
    `country` <> 'Китай';

SELECT 
    gamers.`name`, country
FROM
    `bd1`.`gamers`
WHERE
    `country` >= 'США';

/* При сравнении дат с помощью операторов >, <, >=, <= допускается запись YYYYMMDD без проверки конкретных допустимых значений MM и DD*/
SELECT `gamers_games`.`idgamers_games`,
    `gamers_games`.`gamer`,
    `gamers_games`.`game`,
    `gamers_games`.`date`,
    `gamers_games`.`time`
FROM `bd1`.`gamers_games`
WHERE
    `date` > 20200000;

SELECT `gamers_games`.`idgamers_games`,
    `gamers_games`.`gamer`,
    `gamers_games`.`game`,
    `gamers_games`.`date`,
    `gamers_games`.`time`
FROM `bd1`.`gamers_games`
WHERE
    `time` > '00:10:10';
    
/*Логические операторы при составных условиях*/
SELECT `gamers_games`.`idgamers_games`,
    `gamers_games`.`gamer`,
    `gamers_games`.`game`,
    `gamers_games`.`date`,
    `gamers_games`.`time`
FROM `bd1`.`gamers_games`
WHERE
    `gamers_games`.`game`= 100 OR game = 106;

SELECT `gamers_games`.`idgamers_games`,
    `gamers_games`.`gamer`,
    `gamers_games`.`game`,
    `gamers_games`.`date`,
    `gamers_games`.`time`
FROM `bd1`.`gamers_games`
WHERE
    `gamers_games`.`game`= 100 AND `date`= 20110711;

/*
AND
		True	False	UNKNOWN
True	True	False	UNKNOWN
False	False	False	False
UNKNOWN	UNKNOWN	False 	UNKNOWN

OR
		True	False	UNKNOWN
True	True	True	True
False	True	False	UNKNOWN
UNKNOWN	True	UNKNOWN	UNKNOWN

NOT
True	False
False	True	
UNKNOWN	UNKNOWN
*/

# Результаты сравнения с NULL-значениями

SELECT 
    `gamers`.`idgamers`,
    `gamers`.`name`,
    `gamers`.`country`,
    `gamers`.`favourite_game`,
    `gamers`.`dob`
FROM
    `bd1`.`gamers`
WHERE
    `gamers`.`favourite_game` >= 100
        AND `country` > 'A';
SELECT 
    `gamers`.`idgamers`,
    `gamers`.`name`,
    `gamers`.`country`,
    `gamers`.`favourite_game`,
    `gamers`.`dob`
FROM
    `bd1`.`gamers`
WHERE
    `gamers`.`favourite_game` <= 100
        AND `country` < 'A';
# NULL-значения не отбираются при помощи операций сравнения

#Для выборки, содержащей NULL-значения нужно воспользоваться конструкцией IS NULL
SELECT 
    `gamers`.`idgamers`,
    `gamers`.`name`,
    `gamers`.`country`,
    `gamers`.`favourite_game`,
    `gamers`.`dob`
FROM
    `bd1`.`gamers`
WHERE
    `gamers`.`favourite_game` >= 100
        AND `country` > 'A'
        OR `country` IS NULL
        AND favourite_game IS NOT NULL;
        
SELECT 
    `gamers`.`idgamers`,
    `gamers`.`name`,
    `gamers`.`country`,
    `gamers`.`favourite_game`,
    `gamers`.`dob`
FROM
    `bd1`.`gamers`
WHERE
    `gamers`.`favourite_game` >= 100
        AND `country` > 'A'
        OR `country` IS NULL
        AND NOT favourite_game IS NULL;

#Объединение нескольких условий при помощи логических операторов        
SELECT 
    *
FROM
    `gamers_games`
WHERE
    ((`date` > '2012-10-15'
        AND `date` < '2020-10-16')
        AND `time` > 5905);

SELECT 
    *
FROM
    `gamers_games`
WHERE
    ((`date` > '2012-10-15'
        AND `date` < '2020-10-16')
        AND `time` > '00:59:05');        
#AND более приоритетен, чем OR        
SELECT 
    *
FROM
    `gamers_games`
WHERE
    (`date` = '2017-02-01'
        OR `date` = '2012-10-16'
        AND `time` = '07:00:01');        

#NOT приоритетнее, чем AND        
SELECT 
    *
FROM
    `gamers_games`
WHERE
    (`date` = '2017-02-01'
        OR NOT `date` = '2012-10-16'
        AND `time` = '07:00:01');
SELECT 
    *
FROM
    `gamers_games`
WHERE
    (`date` = '2017-02-01'
        OR `date` = '2012-10-16'
        AND NOT `time` = '07:00:01');
        
# Операторы IN, BETWEEN и LIKE
# IN проверяет приндлежность значения к какому-либо множеству значений
SELECT 
    *
FROM
    `gamers`
WHERE
country IN ('США', 'Китай', 'Россия');

SELECT 
    *
FROM
    `gamers`
WHERE
country NOT IN ('США', 'Китай', 'Россия');

SELECT 
    *
FROM
    `gamers`
WHERE
country IN ('США', 'Китай', 'Россия') OR favourite_game IN (103, 105);

#Исключение граничных значений из конструкции BETWEEN
SELECT 
    *
FROM
    `games`
WHERE
    `price` BETWEEN '15' AND '99999.99'
        AND NOT price IN (15.00 , 99999.99);

/*Верхняя граница значения строки, задаваемая одним символом, 
не включает значения, начинающиеся на этот символ */
SELECT 
    *
FROM
    `games`
WHERE
    developer BETWEEN 'B' AND 'U';

SELECT 
    *
FROM
    `games`
WHERE
developer LIKE 'T%';

SELECT 
    *
FROM
    `games`
WHERE
developer LIKE '_e%';

SELECT 
    *
FROM
    `games`
WHERE
developer LIKE '%e';

SELECT 
    *
FROM
    `games`
WHERE
developer LIKE '_____';

SELECT 
    *
FROM
    `games`
WHERE
developer LIKE '%a%a%' AND developer LIKE '____a%';

SELECT DISTINCT
    *
FROM
    `games`
WHERE
    country LIKE 'К_тай';

#Использование символов исключения для поиска '%' и '_' в данных
#Если нужно найти сам символ исключения в данных, его нужно повторить в запросе два раза
SELECT 
    *
FROM
    `games`
WHERE
    developer LIKE '%$$$%$_%' ESCAPE '$';

#Агрегатные функции COUNT(), SUM(), AVG(), MAX(), MIN()
SELECT 
    COUNT(*)
FROM
    `games`;
#Подсчёт количества записей о разработчиках, у которых в названии есть буква 'a'
SELECT 
    COUNT(*)
FROM
    `games`
WHERE
    developer LIKE '%a%';
    
SELECT COUNT(DISTINCT developer);

SELECT 
    COUNT(ALL developer)
FROM
    `games`;

SELECT 
    AVG(YEAR(`date`)), AVG(MONTH(`date`)), AVG(DAY(`date`))
FROM
    bd1.gamers_games;

SELECT 
    AVG(`time`)
FROM
    bd1.gamers_games;
    
SELECT 
    from_unixtime(avg(UNIX_timestamp(`date`)))
FROM
    bd1.gamers_games;