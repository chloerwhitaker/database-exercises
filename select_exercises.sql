-- Use the albums_db database
USE albums_db;
-- Explore the structure of the albums table
-- How many rows are in the albums table: 31 (Listed in Table Information)
-- How many unique artist names are in the albums table? 23 (Using Distinct)
SELECT DISTINCT artist FROM albums;
-- What is the primary key for the albums table? id
-- What is the oldest release date for any album in the albums table? What is the most recent release date? 1967
SELECT MIN(release_date) as min_release_date From albums;
-- The name of all albums by Pink Floyd: The Dark Side of the Moon and The Wall
SELECT name FROM albums WHERE artist = 'Pink Floyd';
-- The year Sgt. Pepper's Lonely Hearts Club Band was released: 1967
SELECT release_date FROM albums WHERE name = 'Sgt. Pepper''s Lonely Hearts Club Band';
-- The genre for the album Nevermind: Grunge, Alternative rock
SELECT genre FROM albums Where name = 'Nevermind';
-- Which albums were released in the 1990s: The Bodyguard, Jagged Little Pill, Come On Over, Falling into You, Let's Talk About Love, Dangerous, The Immaculate Collection, Titanic: Music from the Motion Picture, Metallica, Nevermind, Supernatural
SELECT name FROM albums WHERE release_date BETWEEN 1990 and 1999;
-- Which albums had less than 20 million certified sales: Grease: The Original Soundtrack from the Motion Picture, Bad, Sgt. Pepper's Lonely Hearts Club Band, Dirty Dancing, Let's Talk About Love, Dangerous, The Immaculate Collection, Abbey Road, Born in the U.S.A., Brothers in Arms, Titanic: Music from the Motion Picture, Nevermind, The Wall
SELECT name FROM albums WHERE sales < 20.0;
-- All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"? Sgt. Pepper's Lonely Hearts Club Band, 1, Abbey Road, Born in the U.S.A, Supernatural / Beacause "ROCK" is a specific string, you'd have to use an * with the query to get all genres containing the string 'rock'. 
SELECT name FROM albums WHERE genre = 'ROCK';
