-- ----------------------------
--  https://napier.sqlzoo.net/wiki/SELECT_basics
-- ----------------------------

--1. Show the population of Germany.
SELECT population 
FROM world
WHERE name = 'Germany';

--2. Show the name and the population for 'Sweden', 'Norway' and 'Denmark'.
SELECT name, population 
FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');

--3. Show the country and the area for countries with an area between 200,000 and 250,000.
SELECT name, area 
FROM world
WHERE area BETWEEN 200000 AND 250000;


-- ----------------------------
--  https://napier.sqlzoo.net/wiki/SELECT_Quiz
-- ----------------------------

--1. Select the code which produces this table.
/*
name			population
Bahrain		1234571
Swaziland	1220000
Timor-Leste	1066409
*/
SELECT name, population
FROM world
WHERE population BETWEEN 1000000 AND 1250000;

--2. Pick the result you would obtain from this code:
SELECT name, population
FROM world
WHERE name LIKE 'Al%';

/*
Albania	3200000
Algeria	32900000
*/


--3. Select the code which shows the countries that end in A or L.
SELECT name 
FROM world
WHERE name LIKE '%a' OR name LIKE '%l';

--4. Pick the result from the query
SELECT name, length(name)
FROM world
WHERE length(name) = 5 AND continent = 'Europe';

/*
name	length(name)
Italy	5
Malta	5
Spain	5
*/

--5. Here are the first few rows of the world table:
/*
name			region		area		population	gdp
Afghanistan	South Asia	652225	26000000	
Albania		Europe		28728		3200000		6656000000
Algeria		Middle East	2400000	32900000		75012000000
Andorra		Europe		468		64000	
...
*/
--Pick the result you would obtain from this code:
SELECT name, area*2 
FROM world 
WHERE population = 64000;

/*
Andorra	936
*/

--6. Select the code that would show the countries with an area larger than 50000 
--   and a population smaller than 10000000.
SELECT name, area, population
FROM world
WHERE area > 50000 AND population < 10000000;

--7. Select the code that shows the population density of China, Australia, Nigeria 
--   and France
SELECT name, population/area
FROM world
WHERE name IN ('China', 'Nigeria', 'France', 'Australia');
