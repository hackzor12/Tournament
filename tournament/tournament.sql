-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


--Use psql tournament to connect and run these commands
--Create a database called tournament
CREATE DATABASE tournament;

--Create a table called players with an auto incrementing id and a text field name
CREATE TABLE Players(
id serial PRIMARY KEY,
name varchar(20)
);

--Create a table called Matches with an auto incrementing id, an int field winner, and and int field loser
CREATE TABLE Matches(
id serial PRIMARY KEY,
winner int REFERENCES Players (id),
loser int REFERENCES Players (id));

--Create a view called Standings so we can do operations on it later
CREATE VIEW Standings AS
SELECT p.id as id, p.name as name,
(SELECT count(*) FROM Matches WHERE Matches.winner = p.id) as won,
(SELECT count(*) FROM Matches WHERE p.id in (winner, loser)) as matches
FROM Players p
GROUP BY p.id
ORDER BY won DESC;