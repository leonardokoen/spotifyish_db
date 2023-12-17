-- INSERT ARTISTS
INSERT INTO users ("first_name", "email", "username", "password", "bio", "artist_flag", "subscription")
VALUES
('MUSE', 'muse@email.com', 'muse', 'password123', 'Muse are an English
rock band from Teignmouth, Devon, formed in 1994. The band consists of
Matt Bellamy (lead vocals, guitar, keyboards), Chris Wolstenholme
 (bass guitar, backing vocals), and Dominic Howard (drums).', 1, 'artist'),
('Imagine Dragons', 'id@email.com', 'imaginedragons', 'password123', 'Imagine Dragons is an American
pop rock band based in Las Vegas, Nevada in 2008, and currently consists of lead singer Dan Reynolds,
guitarist Wayne Sermon, bassist Ben McKee and drummer Daniel Platzman.', 1, 'artist'),
('Coldplay', 'coldplay@email.com', 'coldplay', 'password123', 'Coldplay are a British rock band formed in London in 1997.
 They consist of vocalist and pianist Chris Martin, guitarist Jonny Buckland,
bassist Guy Berryman, drummer Will Champion and manager Phil Harvey.', 1, 'artist')
;

-- INSERT USERS
INSERT INTO users ("first_name", "last_name","email", "username", "password", "subscription")
VALUES
('George', 'Leroy', 'gl@email.com', 'georgeL', 'pass123', 'free'),
('Maria', 'Kara', 'mk@email.com', 'mariaK', 'pass123', 'free'),
('John', 'Fiesta', 'jf@email.com', 'johnF', 'pass123', 'premium'),
('Ken', 'Loid', 'kl@email.com', 'kenL', 'pass123', 'premium'),
('Sandy', 'Brookers', 'sb@email.com', 'sandyB', 'pass123', 'premium'),
('Cali', 'Fox', 'cf@email.com', 'caliF', 'pass123', 'free');

-- Artisrts Inserts Songs that muse owns, The combination of the name and the artist_id is unique.
INSERT INTO songs("name", "time_sec", "date", "owner_id")
VALUES
('Will Of The People', 198, '2022/09/26', (SELECT "id" FROM "users" WHERE "username" = "muse")),
('Compliance', 250, '2022/09/26', (SELECT "id" FROM "users" WHERE "username" = "muse")),
('Liberation', 186, '2022/09/26', (SELECT "id" FROM "users" WHERE "username" = "muse")),
("Won't Stand Down", 209, '2022/09/26', (SELECT "id" FROM "users" WHERE "username" = "muse")),
('Ghosts(How Can I Move On)', 217, '2022/09/26', (SELECT "id" FROM "users" WHERE "username" = "muse")),
("You Make Me Feel Like It's Halloween", 180, '2022/09/26', (SELECT "id" FROM "users" WHERE "username" = "muse")),
('Kill Or Be Killed', 299, '2022/09/26', (SELECT "id" FROM "users" WHERE "username" = "muse")),
('Verona', 297, '2022/09/26', (SELECT "id" FROM "users" WHERE "username" = "muse")),
('Euphoria', 203, '2022/09/26', (SELECT "id" FROM "users" WHERE "username" = "muse")),
('We Are Fucking Fucked', 216, '2022/09/26', (SELECT "id" FROM "users" WHERE "username" = "muse"));


-- This table is used for collaborating songs between artists,
-- So we should update the table with the information that muse creted those songs,
-- This is different from owning the song.
INSERT INTO  user_creates_song("user_id", "song_id")
SELECT "users"."id", "songs"."id" FROM  "users" ,"songs"
WHERE "users"."username" = 'muse'
AND "songs"."name" = 'Will Of The People'
AND "songs"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = "muse")
UNION
SELECT "users"."id", "songs"."id" FROM  "users" ,"songs"
WHERE "users"."username" = 'muse'
AND "songs"."name" = 'Compliance'
AND "songs"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = "muse")
UNION
SELECT "users"."id", "songs"."id" FROM  "users" ,"songs"
WHERE "users"."username" = 'muse'
AND "songs"."name" = 'Liberation'
AND "songs"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = "muse")
UNION
SELECT "users"."id", "songs"."id" FROM  "users" ,"songs"
WHERE "users"."username" = 'muse'
AND "songs"."name" = "Won't Stand Down"
AND "songs"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = "muse")
UNION
SELECT "users"."id", "songs"."id" FROM  "users" ,"songs"
WHERE "users"."username" = 'muse'
AND "songs"."name" = 'Ghosts(How Can I Move On)'
AND "songs"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = "muse")
UNION
SELECT "users"."id", "songs"."id" FROM  "users" ,"songs"
WHERE "users"."username" = 'muse'
AND "songs"."name" = "You Make Me Feel Like It's Halloween"
AND "songs"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = "muse")
UNION
SELECT "users"."id", "songs"."id" FROM  "users" ,"songs"
WHERE "users"."username" = 'muse'
AND "songs"."name" = 'Kill Or Be Killed'
AND "songs"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = "muse")
UNION
SELECT "users"."id", "songs"."id" FROM  "users" ,"songs"
WHERE "users"."username" = 'muse'
AND "songs"."name" = 'Verona'
AND "songs"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = "muse")
UNION
SELECT "users"."id", "songs"."id" FROM  "users" ,"songs"
WHERE "users"."username" = 'muse'
AND "songs"."name" = 'Euphoria'
AND "songs"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = "muse")
UNION
SELECT "users"."id", "songs"."id" FROM  "users" ,"songs"
WHERE "users"."username" = 'muse'
AND "songs"."name" = 'We Are Fucking Fucked'
AND "songs"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = "muse");


INSERT INTO music_collections("name", "info", "date_made", "album_flag", "owner_id")
VALUES
('Will Of The People', 'Will of the People is the ninth studio album by the English rock band Muse,
 released through Warner Records and Helium-3 on 26 August 2022. Self-produced by the band,
 it is a genre-hopping album that Matthew Bellamy described as "a greatest hits album of new songs."', '2022/09/26', 1, (SELECT "id" FROM "users" WHERE "username" = "muse"));

INSERT INTO user_creates_mc("user_id", "mc_id")
SELECT "users"."id", "music_collections"."id" FROM  "users" ,"music_collections"
WHERE "users"."username" = 'muse'
AND "music_collections"."name" = 'Will Of The People'
AND "music_collections"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = "muse");


INSERT INTO  song_in_mc("mc_id","song_id","order_in_mc")
SELECT "username_mc"."mc_id", "username_song"."song_id", 1 FROM "username_mc" ,"username_song"
WHERE "username_mc"."name" = 'Will Of The People' AND "username_mc"."username" = 'muse'
AND "username_song"."name" = 'Will Of The People' AND "username_song"."username" = 'muse'
UNION
SELECT "username_mc"."mc_id", "username_song"."song_id", 2 FROM "username_mc" ,"username_song"
WHERE "username_mc"."name" = 'Will Of The People' AND "username_mc"."username" = 'muse'
AND "username_song"."name" = 'Compliance' AND "username_song"."username" = 'muse'
UNION
SELECT "username_mc"."mc_id", "username_song"."song_id", 3 FROM "username_mc" ,"username_song"
WHERE "username_mc"."name" = 'Will Of The People' AND "username_mc"."username" = 'muse'
AND "username_song"."name" = 'Liberation' AND "username_song"."username" = 'muse'
UNION
SELECT "username_mc"."mc_id", "username_song"."song_id", 4 FROM "username_mc" ,"username_song"
WHERE "username_mc"."name" = 'Will Of The People' AND "username_mc"."username" = 'muse'
AND "username_song"."name" = 'Ghosts(How Can I Move On)' AND "username_song"."username" = 'muse'
UNION
SELECT "username_mc"."mc_id", "username_song"."song_id", 5 FROM "username_mc" ,"username_song"
WHERE "username_mc"."name" = 'Will Of The People' AND "username_mc"."username" = 'muse'
AND "username_song"."name" = "You Make Me Feel Like It's Halloween" AND "username_song"."username" = 'muse'
UNION
SELECT "username_mc"."mc_id", "username_song"."song_id", 6 FROM "username_mc" ,"username_song"
WHERE "username_mc"."name" = 'Will Of The People' AND "username_mc"."username" = 'muse'
AND "username_song"."name" = 'Kill Or Be Killed' AND "username_song"."username" = 'muse'
UNION
SELECT "username_mc"."mc_id", "username_song"."song_id", 7 FROM "username_mc" ,"username_song"
WHERE "username_mc"."name" = 'Will Of The People' AND "username_mc"."username" = 'muse'
AND "username_song"."name" = 'Verona' AND "username_song"."username" = 'muse'
UNION
SELECT "username_mc"."mc_id", "username_song"."song_id", 8 FROM "username_mc" ,"username_song"
WHERE "username_mc"."name" = 'Will Of The People' AND "username_mc"."username" = 'muse'
AND "username_song"."name" = 'Euphoria' AND "username_song"."username" = 'muse'
UNION
SELECT "username_mc"."mc_id", "username_song"."song_id", 9 FROM "username_mc" ,"username_song"
WHERE "username_mc"."name" = 'Will Of The People' AND "username_mc"."username" = 'muse'
AND "username_song"."name" = 'We Are Fucking Fucked' AND "username_song"."username" = 'muse';


INSERT INTO songs("name", "time_sec", "date", "owner_id")
VALUES
("Don't Panic", 137, '2000/07/21', (SELECT "id" FROM "users" WHERE "username" = "coldplay")),
('Shiver', 299, '2000/07/21', (SELECT "id" FROM "users" WHERE "username" = "coldplay")),
('Spies', 318, '2000/07/21', (SELECT "id" FROM "users" WHERE "username" = "coldplay")),
('Sparks', 227, '2000/07/21', (SELECT "id" FROM "users" WHERE "username" = "coldplay")),
('Yellow', 268, '2000/07/21', (SELECT "id" FROM "users" WHERE "username" = "coldplay")),
('Trouble', 273, '2000/07/21', (SELECT "id" FROM "users" WHERE "username" = "coldplay")),
('Parachutes', 46, '2000/07/21', (SELECT "id" FROM "users" WHERE "username" = "coldplay")),
('High Speed', 254, '2000/07/21', (SELECT "id" FROM "users" WHERE "username" = "coldplay")),
('We Never Change', 249, '2000/07/21', (SELECT "id" FROM "users" WHERE "username" = "coldplay")),
("Everything's Not Lost", 435, '2000/07/21', (SELECT "id" FROM "users" WHERE "username" = "coldplay"));


INSERT INTO  user_creates_song("user_id", "song_id")
SELECT "users"."id", "songs"."id" FROM  "users" ,"songs"
WHERE "users"."username" = 'coldplay'
AND "songs"."name" = "Don't Panic"
AND "songs"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = "coldplay")
UNION
SELECT "users"."id", "songs"."id" FROM  "users" ,"songs"
WHERE "users"."username" = 'coldplay'
AND "songs"."name" = 'Shiver'
AND "songs"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = "coldplay")
UNION
SELECT "users"."id", "songs"."id" FROM  "users" ,"songs"
WHERE "users"."username" = 'coldplay'
AND "songs"."name" = 'Spies'
AND "songs"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = "coldplay")
UNION
SELECT "users"."id", "songs"."id" FROM  "users" ,"songs"
WHERE "users"."username" = 'coldplay'
AND "songs"."name" = 'Sparks'
AND "songs"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = "coldplay")
UNION
SELECT "users"."id", "songs"."id" FROM  "users" ,"songs"
WHERE "users"."username" = 'coldplay'
AND "songs"."name" = 'Yellow'
AND "songs"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = "coldplay")
UNION
SELECT "users"."id", "songs"."id" FROM  "users" ,"songs"
WHERE "users"."username" = 'coldplay'
AND "songs"."name" = 'Trouble'
AND "songs"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = "coldplay")
UNION
SELECT "users"."id", "songs"."id" FROM  "users" ,"songs"
WHERE "users"."username" = 'coldplay'
AND "songs"."name" = 'Parachutes'
AND "songs"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = "coldplay")
UNION
SELECT "users"."id", "songs"."id" FROM  "users" ,"songs"
WHERE "users"."username" = 'coldplay'
AND "songs"."name" = 'High Speed'
AND "songs"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = "coldplay")
UNION
SELECT "users"."id", "songs"."id" FROM  "users" ,"songs"
WHERE "users"."username" = 'coldplay'
AND "songs"."name" = 'We Never Change'
AND "songs"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = "coldplay")
UNION
SELECT "users"."id", "songs"."id" FROM  "users" ,"songs"
WHERE "users"."username" = 'coldplay'
AND "songs"."name" = "Everything's Not Lost"
AND "songs"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = "coldplay");

INSERT INTO music_collections("name", "info", "date_made", "album_flag", "owner_id")
VALUES
('Parachutes', 'Parachutes is the debut studio album by British rock band Coldplay. It was released on 10 July 2000 by Parlophone in the United Kingdom.
 The album was produced by the band and British record producer Ken Nelson, except for one track, "High Speed", which was produced by Chris Allison', '2000/07/21', 1,
(SELECT "id" FROM "users" WHERE "username" = "coldplay"));

INSERT INTO user_creates_mc("user_id", "mc_id")
SELECT "users"."id", "music_collections"."id" FROM  "users" ,"music_collections"
WHERE "users"."first_name" = 'Coldplay'
AND "music_collections"."name" = 'Parachutes'
AND "music_collections"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = "coldplay");

INSERT INTO  song_in_mc("mc_id","song_id","order_in_mc")
SELECT "username_mc"."mc_id", "username_song"."song_id", 1 FROM "username_mc" ,"username_song"
WHERE "username_mc"."name" = 'Parachutes' AND "username_mc"."username" = 'coldplay'
AND "username_song"."name" = "Don't Panic" AND "username_song"."username" = 'coldplay'
UNION
SELECT "username_mc"."mc_id", "username_song"."song_id", 2 FROM "username_mc" ,"username_song"
WHERE "username_mc"."name" = 'Parachutes' AND "username_mc"."username" = 'coldplay'
AND "username_song"."name" = 'Shiver' AND "username_song"."username" = 'coldplay'
UNION
SELECT "username_mc"."mc_id", "username_song"."song_id", 3 FROM "username_mc" ,"username_song"
WHERE "username_mc"."name" = 'Parachutes' AND "username_mc"."username" = 'coldplay'
AND "username_song"."name" = 'Spies' AND "username_song"."username" = 'coldplay'
UNION
SELECT "username_mc"."mc_id", "username_song"."song_id", 4 FROM "username_mc" ,"username_song"
WHERE "username_mc"."name" = 'Parachutes' AND "username_mc"."username" = 'coldplay'
AND "username_song"."name" = 'Sparks' AND "username_song"."username" = 'coldplay'
UNION
SELECT "username_mc"."mc_id", "username_song"."song_id", 5 FROM "username_mc" ,"username_song"
WHERE "username_mc"."name" = 'Parachutes' AND "username_mc"."username" = 'coldplay'
AND "username_song"."name" = 'Yellow' AND "username_song"."username" = 'coldplay'
UNION
SELECT "username_mc"."mc_id", "username_song"."song_id", 6 FROM "username_mc" ,"username_song"
WHERE "username_mc"."name" = 'Parachutes' AND "username_mc"."username" = 'coldplay'
AND "username_song"."name" = 'Trouble' AND "username_song"."username" = 'coldplay'
UNION
SELECT "username_mc"."mc_id", "username_song"."song_id", 7 FROM "username_mc" ,"username_song"
WHERE "username_mc"."name" = 'Parachutes' AND "username_mc"."username" = 'coldplay'
AND "username_song"."name" = 'Parachutes' AND "username_song"."username" = 'coldplay'
UNION
SELECT "username_mc"."mc_id", "username_song"."song_id", 8 FROM "username_mc" ,"username_song"
WHERE "username_mc"."name" = 'Parachutes' AND "username_mc"."username" = 'coldplay'
AND "username_song"."name" = 'High Speed' AND "username_song"."username" = 'coldplay'
UNION
SELECT "username_mc"."mc_id", "username_song"."song_id", 9 FROM "username_mc" ,"username_song"
WHERE "username_mc"."name" = 'Parachutes' AND "username_mc"."username" = 'coldplay'
AND "username_song"."name" = 'We Never Change' AND "username_song"."username" = 'coldplay'
UNION
SELECT "username_mc"."mc_id", "username_song"."song_id", 10 FROM "username_mc" ,"username_song"
WHERE "username_mc"."name" = 'Parachutes' AND "username_mc"."username" = 'coldplay'
AND "username_song"."name" = "Everything's Not Lost" AND "username_song"."username" = 'coldplay';



-- The playlist MyAwesomeMix from georgeL
INSERT INTO music_collections("name", "info", "playlist_flag", "owner_id")
VALUES
('MyAwesomeMix', 'This is an awesome mix made with songs of my 2 favourite bands Muse and Coldplay', 1, (SELECT "id" FROM "users" WHERE "username" = 'georgeL'));

INSERT INTO user_creates_mc("user_id", "mc_id")
SELECT "users"."id", "music_collections"."id" FROM  "users" ,"music_collections"
WHERE "users"."username" = 'georgeL'
AND "music_collections"."name" = 'MyAwesomeMix'
AND "music_collections"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = 'georgeL');


INSERT INTO  song_in_mc("mc_id","song_id","order_in_mc")
SELECT "username_mc"."mc_id", "username_song"."song_id", 1 FROM "username_mc" ,"username_song"
WHERE "username_mc"."name" = 'MyAwesomeMix' AND "username_mc"."username" = 'georgeL'
AND "username_song"."name" = 'Will Of The People' AND "username_song"."username" = 'muse'
UNION
SELECT "username_mc"."mc_id", "username_song"."song_id", 2 FROM "username_mc" ,"username_song"
WHERE "username_mc"."name" = 'MyAwesomeMix' AND "username_mc"."username" = 'georgeL'
AND "username_song"."name" = "Don't Panic" AND "username_song"."username" = 'coldplay';

-- Let's say Maria wants to collaborate with George in that playlist and add a song from Coldplay
INSERT INTO user_creates_mc("user_id", "mc_id")
SELECT "users"."id", "music_collections"."id" FROM  "users" ,"music_collections"
WHERE "users"."username" = 'mariaK'
AND "music_collections"."name" = 'MyAwesomeMix'
AND "music_collections"."owner_id" = (SELECT "id" FROM "users" WHERE "username" = 'georgeL');

INSERT INTO  song_in_mc("mc_id","song_id","order_in_mc")
SELECT "username_mc"."mc_id", "username_song"."song_id", 3 FROM "username_mc" ,"username_song"
WHERE "username_mc"."name" = 'MyAwesomeMix' AND "username_mc"."username" = 'mariaK'
AND "username_song"."name" = 'We Never Change' AND "username_song"."username" = 'coldplay';
