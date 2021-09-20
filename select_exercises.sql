-- 2. Use the albums_db database
USE albums_db;
-- 3. Explore the structure of the albums table
-- a. How many rows are in the albums table: 31 (Also listed in Table Information when you click on albums_db under 'TABLES' to the left)
SELECT * FROM albums;
-- b. How many unique artist names are in the albums table? 23 (Using Distinct)
SELECT DISTINCT artist FROM albums;
-- c. What is the primary key for the albums table? id
-- d. What is the oldest release date for any album in the albums table? What is the most recent release date? 1967/2011
SELECT MIN(release_date) as min_release_date From albums;
SELECT MAX(release_date) as max_release_date FROM albums;
-- 4. Write queries to find the following information:
-- a. The name of all albums by Pink Floyd: The Dark Side of the Moon and The Wall
SELECT name FROM albums WHERE artist = 'Pink Floyd';
-- b. The year Sgt. Pepper's Lonely Hearts Club Band was released: 1967
SELECT release_date FROM albums WHERE name = 'Sgt. Pepper''s Lonely Hearts Club Band';
-- c. The genre for the album Nevermind: Grunge, Alternative rock
SELECT genre FROM albums Where name = 'Nevermind';
-- d. Which albums were released in the 1990s: The Bodyguard, Jagged Little Pill, Come On Over, Falling into You, Let's Talk About Love, Dangerous, The Immaculate Collection, Titanic: Music from the Motion Picture, Metallica, Nevermind, Supernatural
SELECT name FROM albums WHERE release_date BETWEEN 1990 and 1999;
-- e. Which albums had less than 20 million certified sales: Grease: The Original Soundtrack from the Motion Picture, Bad, Sgt. Pepper's Lonely Hearts Club Band, Dirty Dancing, Let's Talk About Love, Dangerous, The Immaculate Collection, Abbey Road, Born in the U.S.A., Brothers in Arms, Titanic: Music from the Motion Picture, Nevermind, The Wall
SELECT name FROM albums WHERE sales < 20.0;
-- f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"? Sgt. Pepper's Lonely Hearts Club Band, 1, Abbey Road, Born in the U.S.A, Supernatural / Beacause "ROCK" is a specific string, this query isn't looking for all albums containing the string "ROCK". 
SELECT name FROM albums WHERE genre = 'ROCK';
-- To show all Rock genres including "Hard rock" and "Progressive rock": 
SELECT name FROM albums WHERE genre LIKE '%ROCK%';
