-- Assignment 16: Transactions

-- Create a table to store movie details with the following column definition.
CREATE TABLE movies (
    name        VARCHAR(20),
    director    VARCHAR(20),
    actor       VARCHAR(10),
    actress     VARCHAR(10),
    budget      NUMERIC(10,2),
    releaseyear NUMERIC(4,0),
    rating      NUMERIC(1,0)
);


-- Insert at least 10 movie details.
INSERT INTO movies (name, director, actor, actress, budget, releaseyear, rating)
VALUES
    ('MovieOne',   'DirectorOne',   'ActorOne',   'ActressOne',   120.00, 2018, 4),
    ('MovieTwo',   'DirectorTwo',   'ActorTwo',   'ActressTwo',    90.00, 2019, 3),
    ('MovieThree', 'DirectorThree', 'ActorThree', 'ActressThree', 150.00, 2020, 5),
    ('MovieFour',  'DirectorFour',  'ActorFour',  'ActressFour',   75.00, 2017, 2),
    ('MovieFive',  'DirectorFive',  'ActorFive',  'ActressFive',  110.00, 2021, 4),
    ('MovieSix',   'DirectorSix',   'ActorSix',   'ActressSix',    80.00, 2016, 1),
    ('MovieSeven', 'DirectorSeven', 'ActorSeven', 'ActressSeven', 130.00, 2022, 3),
    ('MovieEight', 'DirectorEight', 'ActorEight', 'ActressEight',  95.00, 2015, 2),
    ('MovieNine',  'DirectorNine',  'ActorNine',  'ActressNine',  160.00, 2023, 5),
    ('MovieTen',   'DirectorTen',   'ActorTen',   'ActressTen',    70.00, 2014, 3);

-- Display the details.
SELECT * FROM movies;


-- Create a savepoint.
SAVEPOINT sp_before_movie_deletes;

-- Delete details of 5 movies.
DELETE FROM movies
WHERE name IN ('MovieOne', 'MovieTwo', 'MovieThree', 'MovieFour', 'MovieFive');

-- Display the details.
SELECT * FROM movies;


-- Add two more new movie details.
INSERT INTO movies (name, director, actor, actress, budget, releaseyear, rating)
VALUES
    ('MovieEleven', 'DirectorEleven', 'ActorEleven', 'ActressEleven', 105.00, 2024, 4),
    ('MovieTwelve', 'DirectorTwelve', 'ActorTwelve', 'ActressTwelve', 115.00, 2025, 3);

-- Display the details.
SELECT * FROM movies;


-- Rollback to savepoint created at line 3 (the first savepoint above).
-- This restores the five deleted rows and removes the two subsequently inserted rows, returning the table to its original 10 movie rows.
ROLLBACK TO SAVEPOINT sp_before_movie_deletes;

-- Display the details.
SELECT * FROM movies;


-- Add a column PRODUCER VARCHAR2 (20).
-- PostgreSQL equivalent: VARCHAR(20).
ALTER TABLE movies
ADD COLUMN producer VARCHAR(20);

-- Display details.
SELECT * FROM movies;


-- Create a savepoint.
SAVEPOINT sp_before_producer_updates;

-- Update the values for the newly added column.
-- Producer names are illustrative because the source does not specify them.
UPDATE movies
SET producer = CASE name
    WHEN 'MovieOne'   THEN 'ProducerOne'
    WHEN 'MovieTwo'   THEN 'ProducerTwo'
    WHEN 'MovieThree' THEN 'ProducerThree'
    WHEN 'MovieFour'  THEN 'ProducerFour'
    WHEN 'MovieFive'  THEN 'ProducerFive'
    WHEN 'MovieSix'   THEN 'ProducerSix'
    WHEN 'MovieSeven' THEN 'ProducerSeven'
    WHEN 'MovieEight' THEN 'ProducerEight'
    WHEN 'MovieNine'  THEN 'ProducerNine'
    WHEN 'MovieTen'   THEN 'ProducerTen'
    ELSE producer
END;

-- Display the details.
SELECT * FROM movies;


-- Rollback to savepoint created at line 12 (the savepoint immediately before the producer UPDATE).
-- The producer UPDATE is undone; the producer column remains present.
ROLLBACK TO SAVEPOINT sp_before_producer_updates;

-- Display the details.
SELECT * FROM movies;


-- Drop the newly added column.
ALTER TABLE movies
DROP COLUMN producer;

-- Display the details.
SELECT * FROM movies;


-- Delete all the movies whose ratings are below 3.
DELETE FROM movies
WHERE rating < 3;

-- Display the details.
SELECT * FROM movies;


-- Make the changes permanent.
COMMIT;


-- Start a new transaction in read only mode.
BEGIN TRANSACTION READ ONLY;

-- Display the details.
SELECT * FROM movies;

-- Delete all movie details.
-- EXPECTED RESULT: PostgreSQL rejects this DELETE because the transaction is READ ONLY. The transaction enters an error/aborted state.
DELETE FROM movies;

-- Rollback the read only transaction.
-- Run this after the expected read-only DELETE error.
ROLLBACK;
