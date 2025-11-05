............................................................................

🎬 5. Movie Rental / Streaming Database (like Netflix)
📋 Tables

  Users(user_id, name, email, subscription_type)

Movies(movie_id, title, genre, release_year, rating)

Watch_History(history_id, user_id, movie_id, watch_date)

Subscriptions(sub_id, user_id, start_date, end_date, plan_amount)

💡 Project Tasks

Find the most-watched genre.

List users whose subscription expired.

Find top 5 most active users (based on watch count).

Write a trigger that updates a user’s “active” status when subscription ends.

......................................................................................  

create database prj;
use prj;
show tables;

create table Users(
user_id int primary key,
name varchar(20),
email varchar(50),
subscription_type varchar(20));

create table Movies(
movie_id int primary key,
title varchar(20),
genre varchar(20),
release_year year ,
rating int);

create table Watch_history(
history_id int primary key,
user_id int,
movie_id int,
watch_date date);

create table subscriptions(
sub_id int primary key,
user_id int,
start_date date,
end_date date,
plan_amount float);

INSERT INTO Users VALUES
(1, 'Aarav', 'aarav@gmail.com', 'Premium'),
(2, 'Diya', 'diya@yahoo.com', 'Basic'),
(3, 'Kabir', 'kabir@hotmail.com', 'Standard'),
(4, 'Riya', 'riya@gmail.com', 'Premium'),
(5, 'Arjun', 'arjun@gmail.com', 'Basic'),
(6, 'Meera', 'meera@yahoo.com', 'Standard'),
(7, 'Ishaan', 'ishaan@gmail.com', 'Premium'),
(8, 'Sanya', 'sanya@gmail.com', 'Basic'),
(9, 'Rohan', 'rohan@gmail.com', 'Standard'),
(10, 'Tara', 'tara@yahoo.com', 'Premium');


INSERT INTO Movies VALUES
(101, 'Inception', 'Sci-Fi', 2010, 9),
(102, 'Avengers', 'Action', 2012, 8),
(103, 'Interstellar', 'Sci-Fi', 2014, 9),
(104, 'Joker', 'Drama', 2019, 8),
(105, 'Frozen', 'Animation', 2013, 7),
(106, 'Dangal', 'Sports', 2016, 8),
(107, 'KGF', 'Action', 2018, 7),
(108, 'Drishyam', 'Thriller', 2015, 8),
(109, 'Pathaan', 'Action', 2023, 6),
(110, 'Pushpa', 'Action', 2021, 8);


INSERT INTO Watch_history VALUES
(1001, 1, 101, '2025-10-01'),
(1002, 2, 102, '2025-09-20'),
(1003, 3, 103, '2025-09-25'),
(1004, 4, 104, '2025-09-30'),
(1005, 5, 105, '2025-09-28'),
(1006, 6, 106, '2025-10-02'),
(1007, 7, 107, '2025-10-03'),
(1008, 8, 108, '2025-09-29'),
(1009, 9, 109, '2025-10-04'),
(1010, 10, 110, '2025-10-05');


INSERT INTO Subscriptions VALUES
(201, 1, '2025-01-01', '2026-01-01', 999.00),
(202, 2, '2025-03-01', '2025-09-01', 499.00),
(203, 3, '2025-05-01', '2026-05-01', 699.00),
(204, 4, '2025-04-01', '2026-04-01', 999.00),
(205, 5, '2025-02-15', '2025-08-15', 499.00),
(206, 6, '2025-03-10', '2026-03-10', 699.00),
(207, 7, '2025-06-01', '2026-06-01', 999.00),
(208, 8, '2025-05-10', '2025-11-10', 499.00),
(209, 9, '2025-01-20', '2026-01-20', 699.00),
(210, 10, '2025-07-01', '2026-07-01', 999.00);


use prj;
select genre as most_watched_genre,count(movie_id) as total_movies
from Movies
group by genre
order by count(movie_id) desc
limit 1;

select u.name as expired_subs_holders,u.email as Email
from Users as u
inner join Subscriptions as s
on u.user_id=s.user_id
where s.end_date<now();         # now() returns the current date and time

use prj;
select count(movie_id) as watch_count,u.name as Name , u.email as Email
from Users as u
inner join Watch_history as w
on u.user_id=w.user_id
group by u.user_id
order by watch_count desc
limit 5;



create table Users1(
user_id int primary key,
name varchar(20),
email varchar(50),
subscription_type varchar(20),
active boolean);



INSERT INTO Users1 VALUES
(1, 'Aarav', 'aarav@gmail.com', 'Premium',true),
(2, 'Diya', 'diya@yahoo.com', 'Basic',false),
(3, 'Kabir', 'kabir@hotmail.com', 'Standard',true),
(4, 'Riya', 'riya@gmail.com', 'Premium',false),
(5, 'Arjun', 'arjun@gmail.com', 'Basic',true),
(6, 'Meera', 'meera@yahoo.com', 'Standard',false),
(7, 'Ishaan', 'ishaan@gmail.com', 'Premium',true),
(8, 'Sanya', 'sanya@gmail.com', 'Basic',false),
(9, 'Rohan', 'rohan@gmail.com', 'Standard',true),
(10, 'Tara', 'tara@yahoo.com', 'Premium',false);


use prj;
DELIMITER //

CREATE TRIGGER update_user_status_after_subcrps_1
AFTER UPDATE ON Subscriptions
FOR EACH ROW
BEGIN
  IF NEW.end_date < NOW() THEN
    UPDATE Users1
    SET active = FALSE
    WHERE user_id = NEW.user_id;
  else 
   update Users1
   set active =true
   where user_id=new.user_id;
  END IF;
END //






