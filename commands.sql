---------------------------------- TASK 3 ----------------------------------
CREATE SCHEMA games;

SET search_path = games, public;

CREATE TABLE Users (
    UserId serial PRIMARY KEY,
    Age int NOT NULL CONSTRAINT user_age CHECK (Age >= 16),
    Email text UNIQUE NOT NULL,
    Nickname text UNIQUE NOT NULL,
    UserPassword text NOT NULL,
    UserLevel int,
    Balance int CONSTRAINT positive_balance CHECK (Balance >= 0)
);

CREATE TABLE GameUnique (
    GameId serial PRIMARY KEY,
    GameName text UNIQUE
);

CREATE TABLE Profiles (
    ProfileId serial PRIMARY KEY,
    GameId serial REFERENCES GameUnique (GameId),
    UserId serial REFERENCES Users (UserId),
    NumberHours int CONSTRAINT positive_hours CHECK (NumberHours >= 0)
);

CREATE TABLE CompanyUnique (
    CompanyId serial PRIMARY KEY,
    CompanyName text UNIQUE
);

CREATE TABLE Companies (
    CompanyId serial PRIMARY KEY REFERENCES CompanyUnique (CompanyId),
    WorkersNumber int CONSTRAINT positive_workers CHECK (WorkersNumber >= 0),
    HeadOfficeAdress text,
    CEOEmail text,
    Country text
);

CREATE TABLE Games (
    GameId serial PRIMARY KEY REFERENCES GameUnique (GameId),
    CompanyId serial REFERENCES Companies (CompanyId),
    GameCost int CONSTRAINT positive_cost CHECK (GameCost >= 0),
    NumberPlayers int CONSTRAINT positive_players CHECK (NumberPlayers >= 0)
);

CREATE TABLE SupportService (
    SupportServiceId serial PRIMARY KEY,
    GameId serial REFERENCES Games (GameId),
    Email text NOT NULL,
    Hotline text
);

CREATE TABLE Servers (
    ServerId serial PRIMARY KEY,
    GameId serial REFERENCES Games (GameId),
    SupportEmail text,
    Maxload int CONSTRAINT positive_load CHECK (Maxload >= 0),
    ServerPassword text,
    Country text
);

---------------------------------- TASK 4 ----------------------------------
INSERT INTO Users (Age, Email, Nickname, UserPassword, UserLevel, Balance)
    VALUES (18, 'new_user@gmail.com', 'aboba', 123465, 10, 500),
    (19, '1_user@gmail.com', 'essential_stepan', 12345, 100, 1000),
    (19, '2_user@gmail.com', 'SlivaemRegion', 123456, 100, 1000),
    (19, '3_user@gmail.com', 'ShoWTimE1024', 1234567, 100, 1000),
    (20, '4_user@gmail.com', 'astavia', 12345678, 0, 1000);

INSERT INTO GameUnique (GameName)
    VALUES ('World of Warcraft'),
    ('World of Tanks'),
    ('Genshin Impact'),
    ('Skyrim'),
    ('Counter-Strike'),
    ('Half-Life'),
    ('Minecraft');

INSERT INTO CompanyUnique (CompanyName)
    VALUES ('miHoYo'),
    ('Xbox Game Studios'),
    ('Blizzard Entertainment'),
    ('Bethesda Game Studios'),
    ('Valve'),
    ('Mojang Studios');

INSERT INTO Companies
    VALUES (1, 10000, 'Office 1', 'ceo1@gmail.com', 'China'),
    (2, 15000, 'Office 2', 'ceo2@gmail.com', 'USA'),
    (3, 15500, 'Office 3', 'ceo3@gmail.com', 'USA'),
    (4, 13000, 'Office 4', 'ceo4@gmail.com', 'USA'),
    (5, 10000, 'Office 5', 'ceo5@gmail.com', 'USA'),
    (6, 20000, 'Office 6', 'ceo6@gmail.com', 'Sweden');

INSERT INTO Profiles (GameId, UserId, NumberHours)
    VALUES (3, 5, 10);

SELECT
    *
FROM
    Profiles;

INSERT INTO Games
    VALUES (1, 3, 100, 50000000),
    (2, 2, 200, 60000000),
    (3, 1, 50, 200000),
    (4, 4, 20, 6000000),
    (5, 5, 100, 7000000),
    (6, 5, 50, 2000000),
    (7, 6, 20, 10000000);

INSERT INTO SupportService (GameId, Email, Hotline)
    VALUES (1, 'email1@gmail.com', '88015553535'),
    (2, 'email2@gmail.com', '88025553535'),
    (3, 'email3@gmail.com', '88035553535'),
    (4, 'email4@gmail.com', NULL),
    (5, 'email5@gmail.com', '88005553535'),
    (6, 'email5@gmail.com', '88005553535'),
    (7, 'email6@gmail.com', '88055553535');

INSERT INTO Servers (GameId, SupportEmail, Maxload, ServerPassword, Country)
    VALUES (1, 'blabla1@gmail.com', 2000, '12wg345', 'China'),
    (2, 'blabla2@gmail.com', 2300, '1234g256', 'Russia'),
    (1, 'blabla3@gmail.com', 3000, '1234be567', 'USA'),
    (2, 'blabla4@gmail.com', 1000, '12g1g2g111', 'USA'),
    (3, 'blabla5@gmail.com', 5000, '222gdb22', 'USA'),
    (4, 'blabla6@gmail.com', 88000, '5g2455', 'China'),
    (5, 'blabla7@gmail.com', 1000, '123g242131', 'China'),
    (6, 'blabla8@gmail.com', 2300, '12g2t2', 'China'),
    (7, 'blabla9@gmail.com', 2050, '123532t24g', 'Germany'),
    (5, 'blabla10@gmail.com', 2200, '1234g3g2', 'Germany'),
    (3, 'blabla11@gmail.com', 20000, '123g42g42g45', 'France');

---------------------------------- TASK 5 ----------------------------------
SELECT
    *
FROM
    Users;

SELECT
    *
FROM
    GameUnique;

SELECT
    *
FROM
    CompanyUnique;

SELECT
    *
FROM
    Companies;

SELECT
    *
FROM
    Games;

SELECT
    *
FROM
    SupportService;

SELECT
    *
FROM
    Servers;

---------------------------------- TASK 6 ----------------------------------



---------------------------------- TASK 7 ----------------------------------



---------------------------------- TASK 8 ----------------------------------



---------------------------------- TASK 9 ----------------------------------



---------------------------------- TASK 10 ----------------------------------



