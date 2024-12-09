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
-- Maxim


---------------------------------- TASK 7 ----------------------------------
-- Nastya
CREATE SCHEMA views;
SET search_path = views, public;

CREATE OR REPLACE VIEW users_view AS
SELECT UserId, Age, Nickname, UserLevel, Balance,  
LEFT(Email, POSITION('@' IN Email) - 1) || '***@***' AS masked_email, 
FROM Users;

SELECT * FROM users_view;

CREATE OR REPLACE VIEW games_view AS
SELECT GameId, CompanyId, GameCost, NumberPlayers
FROM Games;

SELECT * FROM games_view;

CREATE OR REPLACE VIEW servers_view AS
SELECT ServerId, GameId, Maxload, Country, SupportEmail
FROM Servers;

SELECT * FROM servers_view;

CREATE OR REPLACE VIEW profiles_view AS
SELECT ProfileId, UserId, GameId, NumberHours
FROM Profiles;

SELECT * FROM profiles_view;

CREATE OR REPLACE VIEW support_service_view AS
SELECT SupportServiceId, GameId, Email, Hotline
FROM SupportService;

SELECT * FROM support_service_view;

CREATE OR REPLACE VIEW companies_view AS
SELECT CompanyId, WorkersNumber, HeadOfficeAdress, CEOEmail, Country
FROM Companies;

SELECT * FROM companies_view;

CREATE OR REPLACE VIEW companies_unique_view AS 
SELECT CompanyId, CompanyName
FROM CompanyUnique;

SELECT * FROM companies_unique_view;

CREATE OR REPLACE VIEW game_unique_view AS
SELECT GameId, GameName
FROM GameUnique;

SELECT * FROM game_unique_view;

---------------------------------- TASK 8 ----------------------------------
DROP VIEW IF EXISTS games.GamesSummary;

CREATE VIEW games.GamesSummary AS
SELECT
    gu.GameName AS "Игра",
    cu.CompanyName AS "Производитель",
    count(DISTINCT u.UserId) AS "Сколько людей купили",
    avg(p.NumberHours) AS "Среднее количество часов в игре",
    string_agg(DISTINCT u.Nickname, ', ') AS "Никнеймы играющих в игру"
FROM
    games.GameUnique gu
    INNER JOIN games.Games g ON gu.GameId = g.GameId
    LEFT JOIN games.Companies c ON g.CompanyId = c.CompanyId
    INNER JOIN games.CompanyUnique cu ON c.CompanyId = cu.CompanyId
    LEFT JOIN games.Profiles p ON gu.GameId = p.GameId
    LEFT JOIN games.Users u ON p.UserId = u.UserId
GROUP BY
    gu.GameName,
    cu.CompanyName
ORDER BY
    "Сколько людей купили" DESC,
    "Среднее количество часов в игре" DESC;

SELECT
    *
FROM
    GamesSummary;

DROP VIEW IF EXISTS games.PlayersSummary;

CREATE VIEW games.PlayersSummary AS
with most_played_games AS (
    SELECT
        p.UserId,
        gu.GameName,
        p.NumberHours,
        rank() OVER (PARTITION BY p.UserId ORDER BY (p.NumberHours) DESC) AS rank
FROM
    games.Profiles p
    JOIN games.GameUnique gu ON p.GameId = gu.GameId
ORDER BY
    rank ASC
)
SELECT
    u.Nickname AS "Никнейм игрока",
    count(DISTINCT p.GameId) AS "Число игр во владении",
    sum(p.NumberHours) AS "Общее время в играх",
    round(avg(p.NumberHours), 0) AS "Среднее время в игре",
    max(p.NumberHours) AS "Максимальное время в игре",
    min(p.NumberHours) AS "Минимальное время в игре",
    string_agg(DISTINCT gu.GameName, ', ') AS "Игры во владении",
    count(DISTINCT p2.UserId) AS "Число игровых профилей",
    avg(p2.NumberHours) AS "Среднее время игры по профилям",
    (
        SELECT
            GameName
        FROM
            most_played_games
        LIMIT 1) AS "Любимая игра"
FROM
    games.Users u
    LEFT JOIN games.Profiles p ON u.UserId = p.UserId
    LEFT JOIN games.GameUnique gu ON p.GameId = gu.GameId
    LEFT JOIN games.Profiles p2 ON p.GameId = p2.GameId
GROUP BY
    u.Nickname,
    u.UserId;

SELECT
    *
FROM
    PlayersSummary;

DROP VIEW IF EXISTS games.CompaniesSummary;

CREATE VIEW CompaniesSummary AS
WITH TotalUsersCount AS (
    SELECT
        COUNT(DISTINCT UserId) AS TotalUsers
    FROM
        games.Users
),
MainSummary AS (
    SELECT
        cu.CompanyName,
        COUNT(DISTINCT g.GameId) AS "Число разработанных игр",
        COUNT(DISTINCT p.UserId) AS "Число привлеченных игроков",
        SUM(p.NumberHours) AS "Сколько часов потрачено за их играми",
        round(AVG(g.GameCost)) AS "Средняя цена игры",
        c.WorkersNumber AS "Число сотрудников"
    FROM
        games.CompanyUnique cu
        INNER JOIN games.Companies c ON cu.CompanyId = c.CompanyId
        LEFT JOIN games.Games g ON c.CompanyId = g.CompanyId
        LEFT JOIN games.Profiles p ON g.GameId = p.GameId
    GROUP BY
        cu.CompanyName,
        c.WorkersNumber
)
SELECT
    ms.*,
    COALESCE(CAST(ms. "Число привлеченных игроков" AS float) / tuc.TotalUsers * 100, 0) AS "Процент привлеченных игроков"
FROM
    MainSummary AS ms
    CROSS JOIN TotalUsersCount AS tuc;

SELECT
    *
FROM
    CompaniesSummary;

---------------------------------- TASK 9 ----------------------------------
-- Nastya


---------------------------------- TASK 10 ----------------------------------
-- Danil


