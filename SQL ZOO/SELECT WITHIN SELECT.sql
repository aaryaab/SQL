--SELECT WITHIN SELECT

--1 List each country name where the population is larger than that of 'Russia'.

SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

--2 Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

SELECT name
FROM world
WHERE continent = 'Europe'
and 
gdp/population >(select gdp / population from world where name = 'United Kingdom');

--3 List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.     

SELECT name, continent 
FROM world
WHERE continent IN ( SELECT continent FROM world WHERE name IN ('Argentina', 'Australia'));

--4 Which country has a population that is more than United Kingom but less than Germany? Show the name and the population.

SELECT name, population
FROM world
WHERE population BETWEEN 
(SELECT population  FROM world WHERE name = 'United Kingdom') 
AND 
(SELECT population FROM world WHERE name = 'GERMANY')
AND population NOT IN (SELECT population FROM world WHERE name in ('Germany','United Kingdom')); 

--5 Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

SELECT name, CONCAT(CAST(100*ROUND((population / (SELECT population FROM world WHERE name ='Germany')), 2) AS INT), '%')
FROM world
WHERE continent = 'Europe';
-- CAST is used for typecasting and avoding the trailig 0s


--6  Which countries have a GDP greater than every country in Europe
SELECT name
FROM world
WHERE gdp > ALL(SELECT gdp FROM world WHERE continent = 'Europe' and gdp > 0);
-- gdp > 0 to check the null values


--7 Find the largest country (by area) in each continent, show the continent, the name and the area:

SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)

--8 List each continent and the name of the country that comes first alphabetically.

SELECT x.continent, x.name
FROM world x
WHERE  x.name <= ALL(SELECT y.name FROM world y WHERE x.continent = y.continent)
ORDER BY name


--9 Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.

SELECT name, continent, population
FROM  world x
WHERE 25000000 > ALL( SELECT y.population FROM world y WHERE x.continent = y.continent)


--10 Some countries have populations more than three times that of all of their neighbours (in the same continent). Give the countries and continents.  

SELECT name, continent
FROM world x
WHERE population > ALL (SELECT 3*y.population FROM world y WHERE  x.continent = y.continent
and x.name <> y.name)

-- You see when you do the sub-query that checks x.population>3*(all of y.populations for same continent) 
--YOU MUST SPECIFY NOT TO CHECK AGAINST THE SAME COUNTRY; otherwise you are stating to check that x>3x which is mathematically impossible.


