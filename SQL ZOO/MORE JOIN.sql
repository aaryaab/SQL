--1 List the films where the yr is 1962
SELECT id, title
FROM movie
WHERE yr=1962

--2 Give year of 'Citizen Kane'
SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

--3 List all of the Star Trek movies, include the id, title and yr
SELECT id, title,yr
FROM movie
WHERE title LIKE '%Star Trek%';


--4 What id number does the actor 'Glenn Close' have?
SELECT id
FROM actor
WHERE name = 'Glenn Close';

--5 What is the id of the film 'Casablanca'
SELECT id
FROM movie
WHERE title= 'Casablanca';

--6 Obtain the cast list for 'Casablanca'
SELECT name
FROM actor JOIN casting ON actor.id = casting.actorid
JOIN movie ON casting.movieid = movie.id
AND title = 'Casablanca';

--7 Obtain the cast list for the film 'Alien'
SELECT name
FROM actor JOIN casting ON actor.id = casting.actorid
JOIN movie ON casting.movieid = movie.id
AND title = 'Alien';

--8 List the films in which 'Harrison Ford' has appeared
SELECT title
FROM movie JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
AND name= 'Harrison Ford';

--9List the films where 'Harrison Ford' has appeared - but not in the starring role. 
--[Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
SELECT title
FROM movie JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
AND name = 'Harrison Ford' AND ord<>1;

--10 List the films together with the leading star for all 1962 films
SELECT title, name
FROM movie JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
AND yr = 1962 AND ord = 1;


--11Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies

SELECT yr, count(title)
FROM movie JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
AND name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

--12 List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT  title,  name
FROM movie JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
where movie.id IN (SELECT casting.movieId FROM casting JOIN actor ON casting.actorid= actor.id WHERE actor.name = 'Julie Andrews') 
AND ord =1; 

--13 Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
SELECT name
FROM movie JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
AND ord = 1
GROUP by(name)
HAVING count(movie.id) >= 15
ORDER BY name;

--14 List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT  title, count(actorid)
FROM movie JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
AND yr = 1978
GROUP BY title
ORDER BY count(actorid) desc, title;

--15 List all the people who have worked with 'Art Garfunkel'
SELECT name
FROM movie JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
AND movieid IN (SELECT  movieid
FROM movie JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
AND name = 'Art Garfunkel')
AND name <> 'Art Garfunkel';

