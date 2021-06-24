-- ----------------------------
--  https://napier.sqlzoo.net/wiki/Window_LAG
-- ----------------------------

--1. Show the cases in 'Spain' in March.
SELECT name, DAY(whn), confirmed, deaths, recovered
FROM covid
WHERE name = 'Spain'
  AND MONTH(whn) = 3
ORDER BY whn;

--2. The LAG function is used to show data from the preceding row or the table. 
--   When lining up rows the data is partitioned by country name 
--    and ordered by the data whn.
--   That means that only data from Italy is considered.
--   Modify the query to show confirmed for the day before.
SELECT name,
       DAY(whn),
       confirmed,
       LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) AS dbf
FROM covid
WHERE name = 'Italy'
  AND MONTH(whn) = 3
ORDER BY whn;

--3. Show the number of new cases for each day, for Italy, for March.
SELECT name,
       DAY(whn),
       confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) AS new_cases
FROM covid
WHERE name = 'Italy'
  AND MONTH(whn) = 3
ORDER BY whn;

--4. Show the number of new cases in Italy for each week - show Monday only.
SELECT name, 
       DATE_FORMAT(whn,'%Y-%m-%d'), 
       confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) AS new_cases
FROM covid
WHERE name = 'Italy'
AND WEEKDAY(whn) = 0
ORDER BY whn;
                
--5. Show the number of new cases in Italy for each week - show Monday only.
SELECT tw.name, 
       DATE_FORMAT(tw.whn, '%Y-%m-%d'), 
       tw.confirmed - lw.confirmed
FROM covid tw 
LEFT JOIN covid lw 
ON (DATE_ADD(lw.whn, INTERVAL 1 WEEK) = tw.whn
    AND tw.name=lw.name)
WHERE tw.name = 'Italy'
AND WEEKDAY(tw.whn) = 0
ORDER BY tw.whn;

--6. The query shown shows the number of confirmed cases 
--    together with the world ranking for cases.
--   United States has the highest number, Spain is number 2...
--   Notice that while Spain has the second highest confirmed cases,
--    Italy has the second highest number of deaths due to the virus.
--   Include the ranking for the number of deaths in the table.
SELECT name,
       confirmed,
       RANK() OVER (ORDER BY confirmed DESC) AS rc,
       deaths,
       RANK() OVER (ORDER BY deaths DESC) AS rc
FROM covid
WHERE whn = '2020-04-20'
ORDER BY confirmed DESC, deaths DESC;

--7. Show the infect rate ranking for each country.
--   Only include countries with a population of at least 10 million.
SELECT world.name,
       ROUND(100000 * confirmed / population, 0) AS infect_rate,
       RANK() OVER (ORDER BY (confirmed / population)) AS rc
FROM covid 
JOIN world 
ON covid.name = world.name
WHERE whn = '2020-04-20' 
  AND population > 10000000
ORDER BY population DESC;

--8. For each country that has had at last 1000 new cases in a single day, 
--    show the date of the peak number of new cases.

--!!! Same values but in different order !!!--
SELECT name,
       DATE_FORMAT(whn,'%Y-%m-%d') date,
       peak_num
FROM (SELECT name,
             whn,
             peak_num,
             RANK() OVER (PARTITION BY name ORDER BY peak_num DESC) AS rc
      FROM (SELECT name,
                   whn,
                   confirmed - LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) 
                   AS peak_num
            FROM covid) a
      WHERE peak_num > 1000) b
WHERE rc = 1
ORDER BY date;
