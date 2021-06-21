-- ----------------------------
--  https://napier.sqlzoo.net/wiki/The_JOIN_operation
-- ----------------------------

--1. The first example shows the goal scored by a player with the last name 'Bender'. 
--   The * says to list all the columns in the table - a shorter way of saying matchid,
--    teamid, player, gtime.
/*
   SELECT * 
   FROM goal 
   WHERE player LIKE '%Bender';
*/
--   Modify it to show the matchid and player name for all goals scored by Germany.
--   To identify German players, check for: teamid = 'GER'.
SELECT matchid, player
FROM goal 
WHERE teamid = 'GER';

--2. From the previous query you can see that Lars Bender's scored a goal in game 1012. 
--   Now we want to know what teams were playing in that match.
--   Notice in the that the column matchid in the goal table 
--    corresponds to the id column in the game table. 
--   We can look up information about game 1012 by finding that row in the game table.
--   Show id, stadium, team1, team2 for just game 1012.
SELECT id, stadium, team1, team2
FROM game
WHERE game.id = '1012';

-- Using JOIN
SELECT id, stadium, team1, team2
FROM game
JOIN goal
ON game.id = goal.matchid
WHERE player LIKE '%Bender';

--3. Show the player, teamid, stadium and mdate for every German goal.
SELECT player, teamid, stadium, mdate
FROM game 
JOIN goal 
ON game.id = goal.matchid
WHERE goal.teamid = 'GER';

--4. Show the team1, team2 and player for every goal scored 
--    by a player called Mario player LIKE 'Mario%'. 
SELECT team1, team2, player
FROM goal
JOIN game
ON goal.matchid = game.id
WHERE player LIKE 'Mario%';
                    
--5. Show player, teamid, coach, gtime for all goals scored 
--    in the first 10 minutes gtime<=10.
SELECT player, teamid, coach, gtime
FROM goal
JOIN eteam
ON goal.teamid = eteam.id 
WHERE gtime <= 10;

--6. List the dates of the matches and the name of the team 
--    in which 'Fernando Santos' was the team1 coach.
SELECT mdate, teamname
FROM game 
JOIN eteam 
ON game.team1 = eteam.id
WHERE eteam.coach = 'Fernando Santos';

--7. List the player for every goal scored in a game 
--    where the stadium was 'National Stadium, Warsaw'.
SELECT player
FROM goal
JOIN game
ON goal.matchid = game.id
WHERE game.stadium = 'National Stadium, Warsaw';
               
--8. Show the name of all players who scored a goal against Germany.
SELECT DISTINCT player
FROM game 
JOIN goal 
ON game.id = goal.matchid 
WHERE goal.teamid != 'GER'
  AND (team1 = 'GER' OR team2 = 'GER');
  
--9. Show teamname and the total number of goals scored.
SELECT teamname, COUNT(*) AS num_goals
FROM eteam 
JOIN goal 
ON eteam.id = goal.teamid
GROUP BY teamname;

--10. Show the stadium and the number of goals scored in each stadium.
SELECT stadium, COUNT(*) AS num_goals
FROM game 
JOIN goal 
ON game.id = goal.matchid
GROUP BY stadium;

--11. For every match involving 'POL', 
--     show the matchid, date and the number of goals scored.
SELECT matchid, mdate, COUNT(*) AS num_goals
FROM game 
JOIN goal 
ON game.id = goal.matchid
WHERE game.team1 = 'POL' 
   OR game.team2 = 'POL'
GROUP BY goal.matchid, game.mdate;

--12. For every match where 'GER' scored, 
--     show matchid, match date and the number of goals scored by 'GER'.
SELECT matchid, mdate, COUNT(*) AS num_goals
FROM game 
JOIN goal 
ON game.id = goal.matchid
WHERE goal.teamid = 'GER'
GROUP BY goal.matchid, game.mdate;

--13. List every match with the goals scored by each team as shown.
/*
   mdate         team1   score1   team2   score2
   1 July 2012   ESP          4   ITA          0
   10 June 2012  ESP          1   ITA          1
   10 June 2012  IRL          1   CRO          3
   ...
*/
SELECT mdate, 
       team1, 
       SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1,
       team2, 
       SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2
FROM game 
LEFT JOIN goal 
ON game.id = goal.matchid
GROUP BY mdate, team1, team2
ORDER BY mdate, matchid, team1, team2;


-- ----------------------------
--  https://napier.sqlzoo.net/wiki/JOIN_Quiz
-- ----------------------------

--1. You want to find the stadium where player 'Dimitris Salpingidis' scored.
--   Select the JOIN condition to use:
/*
   game  JOIN goal ON (id = matchid)
*/

--2. You JOIN the tables goal and eteam in an SQL statement. 
--   Indicate the list of column names that may be used in the SELECT line:
/*
   matchid, teamid, player, gtime, id, teamname, coach
*/

--3. Select the code which shows players, their team 
--    and the amount of goals they scored against Greece(GRE).
SELECT player, teamid, COUNT(*)
FROM game 
JOIN goal 
ON matchid = id
WHERE (team1 = "GRE" OR team2 = "GRE")
  AND teamid != 'GRE'
GROUP BY player, teamid;

--4. Select the result that would be obtained from this code:
SELECT DISTINCT teamid, mdate
FROM goal 
JOIN game 
on (matchid=id)
WHERE mdate = '9 June 2012';

/*
   DEN   9 June 2012
   GER   9 June 2012
*/

--5. Select the code which would show the player and their team 
--    for those who have scored against Poland(POL) in National Stadium, Warsaw.
SELECT DISTINCT player, teamid 
FROM game 
JOIN goal 
ON matchid = id 
WHERE stadium = 'National Stadium, Warsaw' 
  AND (team1 = 'POL' OR team2 = 'POL')
  AND teamid != 'POL';

--6. Select the code which shows the player, their team and the time they scored, 
--    for players who have played in Stadion Miejski (Wroclaw) but not against Italy(ITA).
SELECT DISTINCT player, teamid, gtime
FROM game 
JOIN goal 
ON matchid = id
WHERE stadium = 'Stadion Miejski (Wroclaw)'
  AND ((teamid = team2 AND team1 != 'ITA') OR (teamid = team1 AND team2 != 'ITA'));

--7. Select the result that would be obtained from this code:
SELECT teamname, COUNT(*)
FROM eteam 
JOIN goal 
ON teamid = id
GROUP BY teamname
HAVING COUNT(*) < 3;

/*
   Netherlands          2
   Poland               2
   Republic of Ireland  1
   Ukraine              2
*/
