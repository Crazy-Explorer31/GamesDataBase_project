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