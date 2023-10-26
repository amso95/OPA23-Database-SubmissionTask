-- Use database
USE communityDatabase; 

-- Display all data in users
SELECT * FROM users;
-- Display all data in community
SELECT * FROM community;
-- Display all data in userCommunity
SELECT * FROM userCommunity;

-- Display all relation between user and community only displaying username, name and community
SELECT u.userName AS "User name", u.fullName AS "Name", c.communityName AS "Community" FROM users u
JOIN userCommunity uc
ON u.userId = uc.userId
JOIN community c
ON c.communityId = uc.communityId;

-- Display all users that follows Stack Overflow
SELECT u.userName AS "User name", u.fullName AS "Name", c.communityName AS "Community" FROM users u
JOIN userCommunity uc
ON u.userId = uc.userId
JOIN community c
ON c.communityId = uc.communityId
WHERE c.communityName = "Stack Overflow";


-- Display all communities that user with username Lime follows
SELECT u.userName AS "User name", u.fullName AS "Name", c.communityName AS "Community" FROM users u
JOIN userCommunity uc
ON u.userId = uc.userId
JOIN community c
ON c.communityId = uc.communityId
WHERE u.userName = "Lime";

-- Display all relation between user and community only displaying username, name and community order by community name
SELECT u.userName AS "User name", u.fullName AS "Name", c.communityName AS "Community" FROM users u
JOIN userCommunity uc
ON u.userId = uc.userId
JOIN community c
ON c.communityId = uc.communityId
ORDER BY c.communityName;

-- Display all data in users
SELECT * FROM users;

-- Display users that are older than the avegare age of all the users in users table with subquery
SELECT * FROM users
WHERE age > (SELECT AVG(age) FROM users);

-- Displaying with self join shows the full name of the users and the username of that users favorite user
SELECT u.fullName AS "Name", fu.userName AS "Favorite user" FROM users u
JOIN users fu
ON u.favoriteUser = fu.userId;

-- We want to be able to more easiely see the users favorite user and make a view of that select query
CREATE OR REPLACE VIEW usersFavoriteUser AS
SELECT u.fullName AS "Name", fu.userName AS "Favorite user" FROM users u
JOIN users fu
ON u.favoriteUser = fu.userId;

-- How to use the view
SELECT * FROM usersFavoriteUser;

-- Procedure that display fhe followers that follow the community you input to the procedure
DELIMITER $$
CREATE PROCEDURE showFollowers
(
	com_name VARCHAR(65)
)
BEGIN
	IF EXISTS(SELECT * FROM community WHERE community.communityName = com_name) THEN
		SELECT u.userName AS "User name", u.fullName AS "Name", c.communityName AS "Community" FROM users u
		JOIN userCommunity uc
		ON u.userId = uc.userId
		JOIN community c
		ON c.communityId = uc.communityId
		WHERE c.communityName = com_name;
	ELSE
		SELECT "Community name that you put in do not exists";
	END IF;
END$$
DELIMITER ;

-- Displays Stack Overflows followers
CALL showFollowers("Stack Overflow");
-- Displays a respond message when community name do not exists
CALL showFollowers("Stac Overflow");

-- Trigger that will archive user when it's deleted 
DELIMITER $$
CREATE TRIGGER removeAndArchiveUser
AFTER DELETE ON users
FOR EACH ROW
BEGIN
	INSERT INTO userArchive (uName, fName, delete_date) VALUES (OLD.userName, OLD.fullName, NOW());
END$$
DELIMITER ;

-- Use DELETE FROM users to activate trigger
DELETE FROM users
WHERE userId = 6;

-- Display all data in users to controll user with id 6 is removed
SELECT * FROM users;
-- Display all data in userArchive
SELECT * FROM userArchive;