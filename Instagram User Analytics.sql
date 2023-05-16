/*A) Marketing: The marketing team wants to launch some campaigns, and they need your help with the following*/

/*1.Rewarding Most Loyal Users: People who have been using the platform for the longest time.
Your Task: Find the 5 oldest users of the Instagram from the database provided*/

select * 
from users
order by created_at asc
limit 5;



/*2.Remind Inactive Users to Start Posting: By sending them promotional emails to post their 1st photo.
Your Task: Find the users who have never posted a single photo on Instagram*/

select users.id, users.username
from users left join photos on users.id=photos.user_id
where photos.id is null;


/*3.Declaring Contest Winner: The team started a contest and the user who gets the most likes on a single photo will win the contest now they wish to declare the winner.
Your Task: Identify the winner of the contest and provide their details to the team*/

select users.id, users.username, photos.id, photos.image_url, count(likes.photo_id) as most_likes
from users inner join photos on users.id=user_id
inner join likes on photos.id=likes.photo_id
group by users.id,photos.id
order by most_likes desc
limit 1;

/*4.Hashtag Researching: A partner brand wants to know, which hashtags to use in the post to reach the most people on the platform.
Your Task: Identify and suggest the top 5 most commonly used hashtags on the platform*/

Select tags.id, tags.tag_name, count(tag_id) as tag_count
from tags inner join photo_tags on tags.id=photo_tags.tag_id
group by tags.id
order by count(tag_id) desc
limit 5;


/*5.Launch AD Campaign: The team wants to know, which day would be the best day to launch ADs.
Your Task: What day of the week do most users register on? Provide insights on when to schedule an ad campaign*/

select dayname(created_at) as Weekday, count(id) as total_user_registered
from users
group by Weekday
order by count(id) desc;


/*B) Investor Metrics: Our investors want to know if Instagram is performing well and is not becoming redundant like Facebook, they want to assess the app on the following grounds*/

/*1.User Engagement: Are users still as active and post on Instagram or they are making fewer posts
Your Task: Provide how many times does average user posts on Instagram. Also, provide the total number of photos on Instagram/total number of users*/

with Avgpost_table as
(select users.id, users.username, count(photos.id) as total_post
from users inner join photos on users.id=photos.user_id
group by users.id)

select round(avg(total_post),2) as average_user_posts
from Avgpost_table;

select
round((select count(*) from photos)/(select count(*) from users),2) as avgpost;


/*2.Bots & Fake Accounts: The investors want to know if the platform is crowded with fake and dummy accounts
Your Task: Provide data on users (bots) who have liked every single photo on the site (since any normal user would not be able to do this).*/



select users.id, users.username as Botaccount, count(photo_id) as fakelikes
from users inner join likes on users.id=likes.user_id
group by users.id
having fakelikes= (select count(*) from photos);
