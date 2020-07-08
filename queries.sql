#just some queries that I ran on the cloned Instagram data set 

# # finding the 5 oldest users
SELECT * FROM users
ORDER BY created_at
LIMIT 5;

#what day of the week do most users register on 
SELECT 
    COUNT(username) as user_count,
    DAYNAME(created_at) as weekday
FROM users
GROUP BY weekday
ORDER BY user_count DESC;

#Gather users who do not post photos 
SELECT username, image_url
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.id IS NULL;

#Individual with most likes on photo
SELECT 
    username, COUNT(likes.user_id) as like_count
FROM photos
INNER JOIN likes    
    ON likes.photo_id = photos.id
INNER JOIN users
    ON users.id = photos.user_id
GROUP BY photos.id
ORDER BY like_count DESC
LIMIT 1;


#how many times does the average user post?
SELECT
    ((SELECT COUNT(*) FROM photos)/
        (SELECT COUNT(*) FROM users)) as average_posts

#what are the top 5 most commonly used hashtags
SELECT 
    tags.tag_name,
    COUNT(photo_tags.photo_id) as total
FROM tags
JOIN photo_tags
    ON photo_tags.tag_id  = tags.id
GROUP BY tags.tag_name
ORDER BY total DESC
LIMIT 5;

#finding users who have liked every single photo on site

SELECT username, 
    count(*) as total
FROM users
INNER JOIN likes
    ON likes.user_id = users.id
GROUP BY username
HAVING total = 257;

    
    