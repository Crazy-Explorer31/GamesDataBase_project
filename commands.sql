create schema games;
set search_path = games, public;

create table Users (
  UserId         serial primary key,
  Age           int not null constraint user_age check (Age >= 16),
  Email        text unique not null,
  Nickname     text unique not null,
  UserPassword        text not null,
  UserLevel                     int,
  Balance int constraint positive_balance check (Balance >= 0)
);
insert into Users (Age, Email, Nickname, UserPassword, UserLevel, Balance)
values 
(18, 'new_user@gmail.com', 'aboba', 123465, 10, 500),
(19, '1_user@gmail.com', 'essential_stepan',12345, 100, 1000),
(19, '2_user@gmail.com', 'SlivaemRegion',123456, 100, 1000),
(19, '3_user@gmail.com', 'ShoWTimE1024',1234567, 100, 1000),
(20, '4_user@gmail.com', 'astavia',12345678, 0, 1000);


select * from Users;

create table GameUnique (
  GameId       serial primary key,
  GameName             text unique
);

insert into GameUnique (GameName)
values 
('World of Warcraft'),
('World of Tanks'),
('Genshin Impact'),
('Skyrim'),
('Counter-Strike'),
('Half-Life'),
('Minecraft');

select * from GameUnique;

create table Profiles (
  ProfileId         serial primary key,
  GameId serial references GameUnique(GameId),
  UserId      serial references Users(UserId),
  NumberHours int constraint positive_hours check (NumberHours >= 0)
);

insert into Profiles (GameId, UserId, NumberHours)
values (3, 5, 10);
select * from Profiles;

create table CompanyUnique (
  CompanyId     serial primary key,
  CompanyName          text unique
);

insert into CompanyUnique (CompanyName) 
values 
('miHoYo'),
('Xbox Game Studios'),
('Blizzard Entertainment'),
('Bethesda Game Studios'),
('Valve'),
('Mojang Studios');

select * from CompanyUnique;

create table Companies (
  CompanyId   serial primary key references CompanyUnique(CompanyId),
  WorkersNumber int constraint positive_workers check (WorkersNumber >= 0),
  HeadOfficeAdress  text,
  CEOEmail          text,
  Country           text
);
insert into Companies
values 
(1, 10000, 'Office 1', 'ceo1@gmail.com', 'China'),
(2, 15000, 'Office 2', 'ceo2@gmail.com', 'USA'),
(3, 15500, 'Office 3', 'ceo3@gmail.com', 'USA'),
(4, 13000, 'Office 4', 'ceo4@gmail.com', 'USA'),
(5, 10000, 'Office 5', 'ceo5@gmail.com', 'USA'),
(6, 20000, 'Office 6', 'ceo6@gmail.com', 'Sweden');

select * from Companies;


create table Games (
  GameId serial primary key references GameUnique(GameId),
  CompanyId        serial references Companies(CompanyId),
  GameCost int constraint positive_cost check (GameCost >= 0),
  NumberPlayers int constraint positive_players check (NumberPlayers >= 0)
);

insert into Games 
values
(1, 3, 100, 50000000),
(2, 2, 200, 60000000),
(3, 1, 50, 200000),
(4, 4, 20, 6000000), 
(5, 5, 100, 7000000),
(6, 5, 50, 2000000),
(7, 6, 20, 10000000);

select * from Games;

create table SupportService (
  SupportServiceId    serial primary key,
  GameId serial references Games(GameId),
  Email                    text not null,
  Hotline                           text
);

insert into SupportService (GameId, Email, Hotline)
values 
(1, 'email1@gmail.com', '88015553535'),
(2, 'email2@gmail.com', '88025553535'),
(3, 'email3@gmail.com', '88035553535'),
(4, 'email4@gmail.com', NULL),
(5, 'email5@gmail.com', '88005553535'),
(6, 'email5@gmail.com', '88005553535'),
(7, 'email6@gmail.com', '88055553535');
select * from SupportService;

create table Servers (
  ServerId            serial primary key,
  GameId serial references Games(GameId),
  SupportEmail                      text, 
  Maxload int constraint positive_load check (Maxload >= 0),
  ServerPassword                    text,
  Country                           text
);

insert into Servers (GameId, SupportEmail, Maxload, ServerPassword, Country)
values 
(1, 'blabla1@gmail.com', 2000, '12wg345', 'China'),
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

select * from Servers;
