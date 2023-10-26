-- This is a database where users can follow popular developer communities and also follow other users
-- Delte database if already exists
DROP DATABASE IF EXISTS communityDatabase;
-- Crate database if not exists
CREATE DATABASE IF NOT EXISTS communityDatabase;  

-- Use database
USE communityDatabase; 

-- Create a table (if not exists) for users
CREATE TABLE IF NOT EXISTS users( 
	userId INT PRIMARY KEY AUTO_INCREMENT,
    userName VARCHAR(65),
    fullName VARCHAR(65)
);

-- Create a table (if not exists) for community 
CREATE TABLE IF NOT EXISTS community(
	communityId INT PRIMARY KEY AUTO_INCREMENT,
    communityName VARCHAR(65)
);

-- Create a linktable (if not exists) for user and community 
CREATE TABLE IF NOT EXISTS userCommunity(
	id INT PRIMARY KEY AUTO_INCREMENT,
    userId INT,
    communityId INT,
    UNIQUE(userId, communityId), 
    CONSTRAINT userId FOREIGN KEY (userId)
    REFERENCES users (userId)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

-- Crate a table (if not exists) to archive deleted users
CREATE TABLE IF NOT EXISTS userArchive(
	id INT PRIMARY KEY AUTO_INCREMENT,
    uName VARCHAR(65),
    fName VARCHAR(65),
    delete_date DATETIME
);


-- Add data to users table
INSERT INTO users (userName, fullName) VALUES("DanTheCool", "Daniel Svensson"),
											 ("Lime", "Emil Karlsson"),
											 ("PiratePeter", "Peter Ek"),
											 ("LovisaTheBest", "Lovisa Granholm"),
											 ("Marcool", "Markus Holm"),
											 ("MissStina", "Stina Marklund"),
											 ("Emmsi", "Emma Pettersson"),
											 ("CoolKarlina", "Karolina Nilsson"),
											 ("QueenKlang", "Isolde Klang"),
											 ("Flipper", "Philip Eriksson");

-- Add data to community table
INSERT INTO community (communityName) VALUES("Stack Overflow"),  -- Developer communities
											("HackerNews"),
											("Github"),
											("W3Schools"),
											("Hackernoon"),
											("Hashnode"),
											("WomenWhoCode"),
											("CodeProject"),
											("Digital Ocean"),
											("Reddit"),
											("freeCodeCamp");

-- Add data to link relations between users and community
INSERT INTO userCommunity(userId, communityId) VALUES(1,1),
													 (1,4),
													 (2,5),
													 (1,10),
													 (6,3),
													 (2,9),
													 (7,8),
													 (7,5),
													 (7,3),
													 (3,3),
													 (5,1),
													 (4,1),
													 (2,6),
													 (8,7),
													 (9,2),
													 (10,9);

-- Add another user that will be removed 
INSERT INTO users (userName, fullName) VALUES("AYRFI", "Mika Svensson");

-- Delete reasently added user with id
DELETE FROM users
WHERE userId = 11;

-- Update users table so a user can have a favorite user
ALTER TABLE users
ADD COLUMN favoriteUser INT;

SELECT * FROM users;

UPDATE users
SET favoriteUser = 2
WHERE userId = 1;

UPDATE users
SET favoriteUser = 1
WHERE userId = 2;

UPDATE users
SET favoriteUser = 1
WHERE userId = 3;

UPDATE users
SET favoriteUser = 7
WHERE userId = 4;

UPDATE users
SET favoriteUser = 10
WHERE userId = 5;

UPDATE users
SET favoriteUser = 2
WHERE userId = 6;

UPDATE users
SET favoriteUser = 3
WHERE userId = 7;

UPDATE users
SET favoriteUser = 9
WHERE userId = 8;

UPDATE users
SET favoriteUser = 2
WHERE userId = 9;

UPDATE users
SET favoriteUser = 5
WHERE userId = 10;

-- Update users table so a user can have an age
ALTER TABLE users
ADD COLUMN age INT;

-- Update users table with age data
UPDATE users
SET age = 22
WHERE userId = 1;

UPDATE users
SET age = 21
WHERE userId = 2;

UPDATE users
SET age = 19
WHERE userId = 3;

UPDATE users
SET age = 17
WHERE userId = 4;

UPDATE users
SET age = 18
WHERE userId = 5;

UPDATE users
SET age = 21
WHERE userId = 6;

UPDATE users
SET age = 30
WHERE userId = 7;

UPDATE users
SET age = 19
WHERE userId = 8;

UPDATE users
SET age = 23
WHERE userId = 9;

UPDATE users
SET age = 35
WHERE userId = 10;
