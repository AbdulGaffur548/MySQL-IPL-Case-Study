create database ipl;
show databases;
use ipl;

-- 1. WHAT ARE THE TOP 5 PLAYERS WITH THE MOST PLAYER OF THE MATCH AWARDS.
select * from matches;

select player_of_match,count(player_of_match) as player_of_the_match_award from matches 
group by player_of_match 
order by player_of_the_match_award desc
limit 5;

-- 2. HOW MANY MATCHES WERE WON BY EACH TEAM IN EACH SEASON?

select season,winner,count(winner) as wins from matches
group by season,winner 
order by season;

-- 3. WHAT IS THE AVERAGE STRIKE RATE OF BATSMEN IN THE IPL DATASET?

select batsman,sum(total_runs)/count(ball) * 100  as strike_rate from deliveries 
group by batsman 
order by strike_rate desc;

-- 4. WHAT IS THE NUMBER OF MATCHES WON BY EACH TEAM BATTING FIRST VERSUS BATTING SECOND?


-- 5. WHICH BATSMAN HAS THE HIGHEST STRIKE RATE (MINIMUM 200 RUNS SCORED)?

select batsman,strike_rate from 
(select batsman,sum(total_runs),sum(total_runs)/count(ball) * 100  as strike_rate from deliveries 
group by batsman having sum(total_runs) > 200) as x
order by strike_rate desc;

-- 6. HOW MANY TIMES HAS EACH BATSMAN BEEN DISMISSED BY THE BOWLER 'MALINGA'?

select batsman,count(batsman) from deliveries where bowler = 'sl malinga'
group by batsman; 

-- 7. WHAT IS THE AVERAGE PERCENTAGE OF BOUNDARIES (FOURS AND SIXES COMBINED) HIT BY EACH BATSMAN?

select batsman,count(batsman_runs)/count(batsman_runs) * 100 from deliveries 
where batsman_runs ='4' or batsman_runs ='6' group by batsman order by count(batsman_runs) desc;

select batsman,avg(batsman_runs)/count(batsman_runs)*100 from deliveries 
where batsman_runs ='4' or batsman_runs ='6' group by batsman order by avg(batsman_runs) desc;

select batsman,
(count(case when batsman_runs = '4' or batsman_runs = '6' then 1 end)/count(*)) * 100 boundries 
from deliveries
group by batsman
order by boundries desc;

-- 8. WHAT IS THE AVERAGE NUMBER OF BOUNDARIES HIT BY EACH TEAM IN EACH SEASON?

select season,
select batting_team,count(batsman_runs) from deliveries 
where batsman_runs = '4' or batsman_runs = '6'
group by batting_team order by count(batsman_runs) desc;

-- 11. WHICH BOWLER HAS THE BEST BOWLING FIGURES (MOST WICKETS TAKEN) IN A SINGLE MATCH?

select bowler,count(dismissal_kind) from deliveries 
where dismissal_kind is not null
group by bowler;

select bowler,sum(case when dismissal_kind is null then 0 else 1 end) as wickets from deliveries 
where dismissal_kind is not null group by bowler;

select bowler,count(*) from deliveries 
where player_dismissed is not null 
group by bowler
order by count(*) desc;

select
     m.id,
     d.bowler,
     count(*) as wickets
from 
	matches m
    inner join
	deliveries d on  m.id = d.match_id
where d.player_dismissed is null
group by m.id,d.bowler
order by wickets desc;

select m.id as match_no,d.bowler,count(*) as wickets_taken
from matches as m
join deliveries as d on d.match_id=m.id
where d.player_dismissed is not null
group by m.id,d.bowler
order by wickets_taken desc
limit 1;

select match_id,bowler,count(player_dismissed) from deliveries
group by match_id,bowler






-- 12. HOW MANY MATCHES RESULTED IN A WIN FOR EACH TEAM IN EACH CITY?

select city,winner,count(winner) from matches
group by city,winner
order by count(winner) desc;

-- 13. HOW MANY TIMES DID EACH TEAM WIN THE TOSS IN EACH SEASON?

select season,toss_winner,count(toss_winner) as wins from matches
group by season,toss_winner
order by season,wins desc;

-- 14. HOW MANY MATCHES DID EACH PLAYER WIN THE "PLAYER OF THE MATCH" AWARD?

select player_of_match,count(player_of_match) as player_of_the_match_award from matches 
group by player_of_match 
order by player_of_the_match_award desc; 

-- 15. WHAT IS THE AVERAGE NUMBER OF RUNS SCORED IN EACH OVER OF THE INNINGS IN EACH MATCH?

SELECT
    match_id,
    `over`,
    AVG(total_runs) AS average_runs_per_ball
FROM
    deliveries
GROUP BY
    match_id,
    `over`;

-- 16. WHICH TEAM HAS THE HIGHEST TOTAL SCORE IN A SINGLE MATCH?

select match_id,batting_team,sum(total_runs) from deliveries
group by match_id,batting_team
order by sum(total_runs) desc limit 1;

-- 17. WHICH BATSMAN HAS SCORED THE MOST RUNS IN A SINGLE MATCH?
select match_id,batsman,sum(total_runs) from deliveries
group by match_id,batsman
order by sum(total_runs) desc limit 1;



SELECT season, result, COUNT(id) AS matches_won
FROM matches
WHERE result LIKE '%won%'
GROUP BY season, result
ORDER BY season, result;















