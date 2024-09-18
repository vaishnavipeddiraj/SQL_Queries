1. Show the details of all the matches played in a specific city:

SELECT *
FROM Match
INNER JOIN Venue ON Match.Ground_name = Venue.ground_name
WHERE Venue.city = 'Mumbai';

2. List the top 10 batsmen in terms of the number of runs scored:

SELECT Fname_Player, Lname_Player, runs_scored
FROM Player
INNER JOIN Batting_Stats ON Player.player_id = Batting_Stats.player_id
ORDER BY runs_scored DESC
LIMIT 10;

3. Find the average economy rate for each bowler:

SELECT Fname_Player, Lname_Player, AVG(economy_rate) AS avg_economy_rate
FROM Player
INNER JOIN Bowling_Stats ON Player.player_id = Bowling_Stats.player_id
GROUP BY Player.player_id;

4. Show the number of matches played by each team in a given year:

SELECT Team.team_name, COUNT(*) AS matches_played
FROM Team
INNER JOIN Teams_Played ON Team.team_name = Teams_Played.team_name
INNER JOIN Match ON Teams_Played.Match_id = Match.Match_id
WHERE YEAR(Match.Match_date) = 2022
GROUP BY Team.team_name;

5.List the players who have won the "Player of the Match" award more than once:

SELECT Fname_Player, Lname_Player, COUNT(*) AS num_awards
FROM Player
INNER JOIN Player_Award ON Player.player_id = Player_Award.player_id
INNER JOIN Award ON Player_Award.Award_name = Award.Award_name
WHERE Award.Category = 'Player of the Match'
GROUP BY Player.player_id
HAVING COUNT(*) > 1;

6.Find the teams that have played more than 10 matches at a particular venue:

SELECT Team.team_name, COUNT(*) AS matches_played
FROM Team
INNER JOIN Teams_Played ON Team.team_name = Teams_Played.team_name
INNER JOIN Match ON Teams_Played.Match_id = Match.Match_id
WHERE Match.Ground_name = 'Eden Gardens' AND Match_played = 'Yes'
GROUP BY Team.team_name
HAVING COUNT(*) > 10;

7.Show the details of the matches that were played by a specific team:

SELECT *
FROM Match
INNER JOIN Teams_Played ON Match.Match_id = Teams_Played.Match_id
WHERE Teams_Played.team_name = 'India';

8. List the players who have scored more than 500 runs and taken more than 10 wickets in a season:

SELECT Fname_Player, Lname_Player
FROM Player
INNER JOIN Batting_Stats ON Player.player_id = Batting_Stats.player_id
INNER JOIN Bowling_Stats ON Player.player_id = Bowling_Stats.player_id
INNER JOIN Match ON Batting_Stats.match_id = Match.Match_id AND Bowling_Stats.match_id = Match.Match_id
WHERE YEAR(Match.Match_date) = 2022 AND runs_scored > 500 AND wickets_taken > 10;

9. Find the total number of catches, run outs, and stumpings for each fielder:

SELECT Fname_Player, Lname_Player, SUM(catches) AS total_catches, SUM(run_outs) AS total_run_outs, SUM(stumps) AS total_stumps
FROM Player
INNER JOIN Fielding_Stats ON Player.player_id = Fielding_Stats.player_id
GROUP BY Player.player_id;

10.Show the details of all the matches in which a particular umpire officiated:

SELECT *
FROM Match
INNER JOIN Umpire

11. Find the players who have scored a century and taken at least two wickets in the same match.

SELECT p.Fname_Player, p.Lname_Player, b.runs_scored, b.fours, b.sixes, 
       bo.overs_bowled, bo.runs_conceded, bo.wickets_taken
FROM Player p
JOIN Batting_Stats b ON p.player_id = b.player_id
JOIN Bowling_Stats bo ON p.player_id = bo.player_id
JOIN Match m ON b.match_id = m.match_id AND bo.match_id = m.match_id
WHERE b.runs_scored >= 100 AND bo.wickets_taken >= 2;

12. List the umpires who have officiated in matches in at least five different venues.

SELECT u.Fname_Umpire, u.Lname_Umpire
FROM Umpire u
JOIN Umpire_Match um ON u.umpire_id = um.umpire_id
JOIN Match m ON um.match_id = m.match_id
GROUP BY u.umpire_id
HAVING COUNT(DISTINCT m.ground_name) >= 5;

13.List the coaches who have coached teams with an average rating of at least 8.

SELECT c.Fname_Coach, c.Lname_Coach
FROM Coach c
JOIN Team t ON c.team_name = t.team_name
GROUP BY c.coach_id
HAVING AVG(t.team_rating) >= 8;

14.Find the players who have taken at least 10 catches and scored at least 500 runs in a season.

SELECT p.Fname_Player, p.Lname_Player, f.catches, b.runs_scored
FROM Player p
JOIN Batting_Stats b ON p.player_id = b.player_id
JOIN Fielding_Stats f ON p.player_id = f.player_id
JOIN Match m ON b.match_id = m.match_id AND f.match_id = m.match_id
WHERE b.runs_scored >= 500 AND f.catches >= 10;

15.Find the teams that have won all their matches in a specific year

SELECT t.team_name
FROM Team t
JOIN Match m ON t.team_name = m.winning_team AND YEAR(m.match_date) = 2022
GROUP BY t.team_name
HAVING COUNT(DISTINCT m.match_id) = COUNT(CASE WHEN t.team_name = m.winning_team THEN 1 ELSE NULL END);

16. Find the players who have bowled at least 10 overs and have an economy rate of less than 5 in a season.

SELECT p.Fname_Player, p.Lname_Player, bo.overs_bowled, bo.runs_conceded
FROM Player p
JOIN Bowling_Stats bo ON p.player_id = bo.player_id
JOIN Match m ON bo.match_id = m.match_id
WHERE bo.overs_bowled >= 10 AND bo.runs_conceded/bo.overs_bowled < 5;

17. Find the matches where a team won by a margin of at least 100 runs and a player scored a century.
SELECT m.match_id, m.match_played, m.match_date, m.winning_team, p.Fname_Player, p.Lname_Player, b.runs_scored
FROM Match m
JOIN Batting_Stats b ON m.match_id = b.match_id
JOIN Player p ON b.player_id = p.player_id
WHERE m.win_margin >= 100 AND b.runs_scored >= 100;

18. Find the top 5 players with the highest batting average:

SELECT Fname_Player, Lname_Player, (SUM(runs_scored) / COUNT(*)) AS batting_average
FROM Batting_Stats
JOIN Player ON Batting_Stats.player_id = Player.player_id
GROUP BY Batting_Stats.player_id
ORDER BY batting_average DESC
LIMIT 5;


19.Find the team that won the most number of matches in a particular year:

SELECT team_name, COUNT(*) AS wins
FROM Match
JOIN Teams_played ON Match.Match_id = Teams_played.Match_id
JOIN Team ON Teams_played.Team_name = Team.team_name
WHERE YEAR(Match_date) = '2022' AND Match_played = 'Won'
GROUP BY Teams_played.Team_name
ORDER BY wins DESC
LIMIT 1;

20.Find the top 3 venues that hosted the most number of matches:

SELECT ground_name, COUNT(*) AS num_matches
FROM Match
JOIN Venue ON Match.Ground_name = Venue.ground_name
GROUP BY Match.Ground_name
ORDER BY num_matches DESC
LIMIT 3;

21.Find the number of matches won by each team in a particular tournament:

SELECT team_name, COUNT(*) AS wins
FROM Match
JOIN Teams_played ON Match.Match_id = Teams_played.Match_id
JOIN Team ON Teams_played.Team_name = Team.team_name
WHERE Match_played = 'Won' AND Tournament = 'IPL 2022'
GROUP BY Teams_played.Team_name;

22.Find the umpires who have officiated in at least 20 matches:

SELECT Umpire_id, Fname_Umpire, Lname_Umpire, COUNT(*) AS num_matches
FROM Umpire_match
JOIN Umpire ON Umpire_match.umpire_id = Umpire.Umpire_id
GROUP BY Umpire_match.umpire_id
HAVING num_matches >= 20;

23. Retrieve the number of matches played by each team:

SELECT team_name, COUNT(*) AS matches_played
FROM Teams_played
GROUP BY team_name;

24.Retrieve the total number of catches taken by each player:

SELECT p.Fname_Player, p.Lname_Player, SUM(f.catches) AS total_catches
FROM Player p, Fielding_Stats f
WHERE p.player_id = f.player_id
GROUP BY p.Fname_Player, p.Lname_Player;

25. Retrieve the team name and their respective captain name for all teams:

SELECT t.team_name, c.Fname_Captain, c.Lname_Captain
FROM Team t, Captain c
WHERE t.team_name = c.team_name;
