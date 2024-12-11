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
    (19, '1_user@gmail.com', 'essential_stepan', 12345, 100, 4000),
    (19, '2_user@gmail.com', 'SlivaemRegion', 123456, 100, 3000),
    (19, '3_user@gmail.com', 'ShoWTimE1024', 1234567, 100, 10000),
    (20, '4_user@gmail.com', 'astavia', 12345678, 0, 15000);

INSERT INTO GameUnique (GameName)
    VALUES ('World of Warcraft'),
    ('World of Tanks'),
    ('Genshin Impact'),
    ('Skyrim'),
    ('Counter-Strike'),
    ('Half-Life'),
    ('Minecraft'),
    ('StarCraft II');

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
    VALUES (3, 5, 10),
    (7, 4, 70),
    (7, 1, 55),
    (1, 5, 20),
    (2, 5, 31),
    (3, 5, 40),
    (4, 5, 55),
    (5, 5, 10),
    (6, 5, 70),
    (7, 5, 10),
    (8, 5, 10),
    (8, 1, 14),
    (8, 2, 14),
    (2, 3, 10);

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
    (7, 6, 20, 10000000),
    (8, 3, 20, 140000);

INSERT INTO SupportService (GameId, Email, Hotline)
    VALUES (1, 'email1@gmail.com', '88015553535'),
    (2, 'email2@gmail.com', '88025553535'),
    (3, 'email3@gmail.com', '88035553535'),
    (4, 'email4@gmail.com', NULL),
    (5, 'email5@gmail.com', '88005553535'),
    (6, 'email6@gmail.com', '88006553535'),
    (7, 'email7@gmail.com', '88057553535'),
    (8, 'email8@gmail.com', '88058553535');

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
    (3, 'blabla11@gmail.com', 20000, '123g42g42g45', 'France'),
    (8, 'blabla12@gmail.com', 3000, '1234fgbe567', 'USA');

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
-- Запрос 1: Список всех игр и количества пользователей, играющих в каждую игру
SELECT
    GameUnique.GameName,
    Games.NumberPlayers AS NumberOfUsers
FROM
    GameUnique
    JOIN Games ON GameUnique.GameId = Games.GameId
ORDER BY
    Games.NumberPlayers DESC;

-- Ожидаемый результат: список игр с количеством пользователей, упорядоченный по убыванию числа пользователей.
-- Запрос 2: Пользователи с балансами и рангами для каждой группы по количеству проведенных часов
SELECT
    u.UserId,
    u.Nickname,
    p.NumberHours,
    u.Balance,
    RANK() OVER (PARTITION BY p.NumberHours ORDER BY u.Balance) AS HourBalanceRank
FROM
    Users u
    JOIN Profiles p ON u.UserId = p.UserId;

-- Ожидаемый результат: список пользователей, ранжированных по количеству часов, проведенных в играх
-- Запрос 3: Пользователи, имеющие баланс выше среднего, и игры, в которые они играют
WITH AveragedBalance AS (
    SELECT
        AVG(Balance) AS AvgBalance
    FROM
        Users
)
SELECT
    u.UserId,
    u.Nickname,
    p.GameId,
    g.GameName
FROM
    Users u
    JOIN Profiles p ON u.UserId = p.UserId
    JOIN GameUnique g ON p.GameId = g.GameId
    JOIN AveragedBalance ab ON u.Balance > ab.AvgBalance
ORDER BY
    u.UserId;

-- Ожидаемый результат: пользователи с балансом выше среднего и игры, в которые они играют.
-- Запрос 4: Компании, выпускающие игры стоимостью ниже средней, отсортированные по убыванию стоимости игр
WITH AveragedGameCost AS (
    SELECT
        AVG(GameCost) AS AvgGameCost
    FROM
        Games
)
SELECT
    cu.CompanyName,
    g.GameId,
    g.GameCost
FROM
    Companies c
    JOIN Games g ON c.CompanyId = g.CompanyId
    JOIN CompanyUnique cu ON c.CompanyId = cu.CompanyId
WHERE
    g.GameCost < (
        SELECT
            AvgGameCost
        FROM
            AveragedGameCost)
ORDER BY
    g.GameCost;

-- Запрос 5: Компании, у которых количество работников больше средней величины, упорядоченные по количеству работников
WITH AveragedWorkers AS (
    SELECT
        AVG(WorkersNumber) AS AvgWorkers
    FROM
        Companies
)
SELECT
    cu.CompanyName,
    c.WorkersNumber
FROM
    Companies c
    JOIN CompanyUnique cu ON c.CompanyId = cu.CompanyId
WHERE
    c.WorkersNumber > (
        SELECT
            AvgWorkers
        FROM
            AveragedWorkers)
ORDER BY
    c.WorkersNumber;

---------------------------------- TASK 7 ----------------------------------
-- Nastya
CREATE SCHEMA views;

CREATE OR REPLACE VIEW users_view AS
SELECT
    UserId,
    Age,
    Nickname,
    UserLevel,
    Balance,
    LEFT (Email,
        POSITION('@' IN Email) - 1) || '***@***' AS masked_email
FROM
    Users;

SELECT
    *
FROM
    users_view;

CREATE OR REPLACE VIEW games_view AS
SELECT
    GameId,
    CompanyId,
    GameCost,
    NumberPlayers
FROM
    Games;

SELECT
    *
FROM
    games_view;

CREATE OR REPLACE VIEW servers_view AS
SELECT
    ServerId,
    GameId,
    Maxload,
    Country,
    SupportEmail
FROM
    Servers;

SELECT
    *
FROM
    servers_view;

CREATE OR REPLACE VIEW profiles_view AS
SELECT
    ProfileId,
    UserId,
    GameId,
    NumberHours
FROM
    Profiles;

SELECT
    *
FROM
    profiles_view;

CREATE OR REPLACE VIEW support_service_view AS
SELECT
    SupportServiceId,
    GameId,
    Email,
    Hotline
FROM
    SupportService;

SELECT
    *
FROM
    support_service_view;

CREATE OR REPLACE VIEW companies_view AS
SELECT
    CompanyId,
    WorkersNumber,
    HeadOfficeAdress,
    CEOEmail,
    Country
FROM
    Companies;

SELECT
    *
FROM
    companies_view;

CREATE OR REPLACE VIEW companies_unique_view AS
SELECT
    CompanyId,
    CompanyName
FROM
    CompanyUnique;

SELECT
    *
FROM
    companies_unique_view;

CREATE OR REPLACE VIEW game_unique_view AS
SELECT
    GameId,
    GameName
FROM
    GameUnique;

SELECT
    *
FROM
    game_unique_view;

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
CREATE OR REPLACE FUNCTION tg_update ()
    RETURNS TRIGGER
    AS $$
BEGIN
    IF NEW.Age IS NULL OR NEW.Age < 16 THEN
        RAISE EXCEPTION 'Возраст некорректен';
    END IF;
    IF NEW.Nickname IS NULL THEN
        RAISE EXCEPTION 'Никнейм обязателен';
    END IF;
    RETURN new;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER t_update
    BEFORE INSERT OR UPDATE ON Users FOR EACH ROW
    EXECUTE FUNCTION tg_update ();

CREATE TABLE users_history (
    operation_name text,
    operation_time timestamp(0),
    updated_by text,
    UserId int,
    old_nickname text,
    new_nickname text,
    old_password text,
    new_password text,
    old_email text,
    new_email text
);

CREATE OR REPLACE FUNCTION tg_log_fn ()
    RETURNS TRIGGER
    AS $$
BEGIN
    INSERT INTO users_history
        VALUES (tg_op, CURRENT_TIMESTAMP, CURRENT_USER, OLD.UserId, OLD.Nickname, NEW.Nickname, OLD.UserPassword, NEW.UserPassword, OLD.Email, NEW.Email);
    RETURN NULL;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER tg_log_fn
    AFTER DELETE OR INSERT OR UPDATE ON Users FOR EACH ROW
    EXECUTE FUNCTION tg_log_fn ();

-------chech_if_working-------------
UPDATE
    Users
SET
    Email = '0_user@gmail.com'
WHERE
    Email = 'new_user@gmail.com';

SELECT
    *
FROM
    users_history;

---------------------------------- TASK 10 ----------------------------------
-- Добавляет нового пользвоателя игровой площадки, попутно создавая профиль в игре game_name
CREATE OR REPLACE PROCEDURE add_user (user_age int, user_email text, user_nickname text, user_password text, user_level int, user_balance int, game_name text)
    AS $$
DECLARE
    user_id int;
    game_id int;
BEGIN
    SELECT
        GameId INTO game_id
    FROM
        GameUnique
    WHERE
        GameName = game_name;
    IF game_id IS NULL THEN
        RAISE EXCEPTION 'Нет игры с таким названием.';
    END IF;
    INSERT INTO Users (Age, Email, Nickname, UserPassword, UserLevel, Balance)
        VALUES (user_age, user_email, user_nickname, user_password, user_level, user_balance)
    RETURNING
        UserId INTO user_id;
    INSERT INTO Profiles (GameId, UserId, NumberHours)
        VALUES (game_id, user_id, 0);
END;
$$
LANGUAGE plpgsql;

-- Добавит нового пользователя и создаст ему профиль в игре Майнкрафт
CALL add_user (19, 'Nikita2005@gmail.com', 'Nagibator228', '1337zxc', 0, 70, 'Minecraft');

SELECT
    *
FROM
    Users
WHERE
    Email = 'Nikita2005@gmail.com';

--Упадет с ошибкой
CALL add_user (49, 'NeSkuf1975@gmail.com', 'NeSkuf', '1111111', 0, 0, 'CheZaIgra');

-- Процедура покупки пользователем user_id игры game_name
CREATE OR REPLACE PROCEDURE buy_game (user_id int, game_name text)
    AS $$
DECLARE
    game_id int;
    game_cost int;
    user_balance int;
BEGIN
    SELECT
        g.GameId,
        g.GameCost INTO game_id,
        game_cost
    FROM
        Games AS g
        INNER JOIN GameUnique AS gu ON g.GameId = gu.GameId
    WHERE
        gu.GameName = game_name;
    SELECT
        Balance INTO user_balance
    FROM
        Users
    WHERE
        UserId = user_id;
    IF user_balance < game_cost THEN
        RAISE EXCEPTION 'МаЛо дEнЯк.';
    END IF;
    UPDATE
        Users
    SET
        Balance = Balance - game_cost
    WHERE
        UserId = user_id;
    INSERT INTO Profiles (GameId, UserId, NumberHours)
        VALUES (game_id, user_id, 0);
END;
$$
LANGUAGE plpgsql;

-- Игра купится, балланс уменьшится, профиль создастся.
CALL buy_game (6, 'Half-Life');

SELECT
    *
FROM
    Users
WHERE
    UserId = 6;

SELECT
    *
FROM
    Profiles
WHERE
    UserId = 6;

-- Упадет с ошибкой
CALL buy_game (6, 'Half-Life');

