-- ----------------------------
--  https://napier.sqlzoo.net/wiki/SELECT_names
-- ----------------------------

--1. Find the country that start with Y.
SELECT name
FROM world
WHERE name LIKE 'Y%';

-- Another solution using REGEXP.
SELECT name
FROM world
WHERE name REGEXP '^Y';

--2. Find the countries that end with y.
SELECT name 
FROM world
WHERE name LIKE '%y';

-- Another solution using REGEXP.
SELECT name
FROM world
WHERE name REGEXP 'Y$';

--3. Find the countries that contain the letter x.
SELECT name 
FROM world
WHERE name LIKE '%x%';

-- Another solution using REGEXP.
SELECT name
FROM world
WHERE name REGEXP 'x';

--4. Find the countries that end with land.
SELECT name 
FROM world
WHERE name LIKE '%land';

-- Another solution using REGEXP.
SELECT name
FROM world
WHERE name REGEXP 'land$';

--5. Find the countries that start with C and end with ia.
SELECT name 
FROM world
WHERE name LIKE 'C%ia';

-- Another solution using REGEXP.
SELECT name
FROM world
WHERE name REGEXP '^C.*ia$'
ORDER BY name;

--6. Find the country that has oo in the name.
SELECT name 
FROM world
WHERE name LIKE '%oo%';

-- Another solution using REGEXP.
SELECT name
FROM world
WHERE name REGEXP 'oo';

--7. Find the countries that have three or more a in the name.
SELECT name 
FROM world
WHERE name LIKE '%a%a%a%';

-- Another solution using REGEXP.
SELECT name
FROM world
WHERE name REGEXP '(.*a.*){3,}';

--8. Find the countries that have "t" as the second character.
SELECT name 
FROM world
WHERE name LIKE '_t%'
ORDER BY name;

-- Another solution using REGEXP.
SELECT name 
FROM world
WHERE name REGEXP '^[[:alpha:]]t.*$'
ORDER BY name;

--9. Find the countries that have two "o" characters separated by two others.
SELECT name 
FROM world
WHERE name LIKE '%o__o%';

-- Another solution using REGEXP.
SELECT name 
FROM world
WHERE name REGEXP 'o.{2}o';

--10. Find the countries that have exactly four characters.
SELECT name 
FROM world
WHERE name LIKE '____';

-- Using REGEXP.
SELECT name 
FROM world
WHERE name REGEXP '^[[:alpha:]]{4}$';

-- Using LENGTH().
SELECT name 
FROM world
WHERE LENGTH(name) = 4;

--11. Find the country where the name is the capital city.
--    The capital of Luxembourg is Luxembourg.
SELECT name
FROM world
WHERE name = capital;

--12. Find the country where the capital is the country plus "City".
--    The capital of Mexico is Mexico City.
SELECT name
FROM world
WHERE capital = CONCAT(name, ' City');

--13. Find the capital and the name where the capital includes the name of the country.
SELECT capital, name
FROM world
WHERE capital LIKE CONCAT('%', name, '%');

-- Using REGEXP.
SELECT capital, name
FROM world
WHERE capital REGEXP name;

--14. Find the capital and the name where the capital 
--     is an extension of name of the country.
--    You should include Mexico City as it is longer than Mexico. 
--    You should not include Luxembourg as the capital is the same as the country.
SELECT capital, name
FROM world
WHERE capital LIKE CONCAT('%', name, '%')
  AND capital != name;
  
--15. Show the name and the extension 
--     where the capital is an extension of name of the country.
--    For Monaco-Ville the name is Monaco and the extension is -Ville.
SELECT name, REPLACE(capital, name, '') AS extension
FROM world
WHERE capital LIKE CONCAT('%', name, '%')
  AND capital != name;