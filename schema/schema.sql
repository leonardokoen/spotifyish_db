-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

CREATE TABLE users(
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT,
    "email" TEXT UNIQUE NOT NULL,
    "username" TEXT UNIQUE NOT NULL,
    "password" TEXT NOT NULL,
    "profile_picture" BLOB,
    "bio" TEXT,
    "artist_flag"  INTEGER NOT NULL CHECK("artist_flag" = 0 OR "artist_flag" = 1) DEFAULT 0,
    "subscription" TEXT NOT NULL CHECK("subscription" = 'free' OR "subscription" = 'premium' OR "subscription" = 'artist'),
    "soft_deletion" INTEGER NOT NULL CHECK("soft_deletion" = 0 OR "soft_deletion" = 1) DEFAULT 0,
    PRIMARY KEY("id")
);

CREATE TABLE songs(
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "genre" TEXT,
    "time_sec" NUMERIC NOT NULL,
    "lyrics" TEXT,
    "language" TEXT,
    "date" NUMERIC NOT NULL,
    "owner_id" INTEGER,
    FOREIGN KEY("owner_id") REFERENCES "users"("id"),
    UNIQUE("name", "owner_id"),
     -- "wav_file" BLOB NOT NULL,
    PRIMARY KEY("id")
);

CREATE TABLE music_collections(
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "info" TEXT,
    "cover" BLOB,
    "date_made" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "album_flag" INTEGER NOT NULL CHECK("album_flag" = 0 OR "album_flag" = 1) DEFAULT 0,
    "playlist_flag" INTEGER NOT NULL CHECK("playlist_flag" = 0 OR "playlist_flag" = 1) DEFAULT 0,
    "single_flag" INTEGER NOT NULL CHECK("single_flag" = 0 OR "single_flag" = 1) DEFAULT 0,
    "owner_id" INTEGER,
    UNIQUE("name", "owner_id"),
    FOREIGN KEY("owner_id") REFERENCES "users"("id"),
    PRIMARY KEY("id")
);

CREATE TABLE user_creates_mc(
    "id" INTEGER,
    "user_id" INTEGER,
    "mc_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("mc_id") REFERENCES "music_collections"("id")
);

CREATE TABLE user_creates_song(
    "id" INTEGER,
    "user_id" INTEGER,
    "song_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("song_id") REFERENCES "songs"("id")
);

CREATE TABLE user_likes_mc(
    "id" INTEGER,
    "user_id" INTEGER,
    "mc_id" INTEGER,
    "date" NUMERIC DEFAULT CURRENT_TIMESTAMP,
    UNIQUE("user_id", "mc_id"),
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("mc_id") REFERENCES "music_collections"("id")
);

CREATE TABLE user_likes_song(
    "id" INTEGER,
    "user_id" INTEGER,
    "song_id" INTEGER,
    "date" NUMERIC DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "users"("id"),
    FOREIGN KEY("song_id") REFERENCES "songs"("id")
);

CREATE TABLE user_follows_user(
    "id" INTEGER,
    "A_user_id" INTEGER,
    "B_user_id" INTEGER,
    "date" NUMERIC DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("id"),
    FOREIGN KEY("A_user_id") REFERENCES "users"("id"),
    FOREIGN KEY("B_user_id") REFERENCES "users"("id")
);

CREATE TABLE song_in_mc(
    "id" INTEGER,
    "song_id" INTEGER,
    "mc_id" INTEGER,
    "order_in_mc" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("song_id") REFERENCES "songs"("id"),
    FOREIGN KEY("mc_id") REFERENCES "music_collections"("id")
);

CREATE VIEW "active_artists" AS
SELECT "id", "first_name", "email", "profile_picture", "bio" FROM "users"
WHERE "artist_flag" = 1 AND "soft_deletion" = 0
ORDER BY "first_name";

CREATE VIEW "active_users" AS
SELECT "id", "last_name", "first_name", "email", "profile_picture", "bio" FROM "users"
WHERE "artist_flag" = 0 AND "soft_deletion" = 0;

CREATE VIEW "username_mc" AS
SELECT "user_id","username", "mc_id","name"
FROM "users"
JOIN "user_creates_mc"
ON "users"."id" = "user_creates_mc"."user_id"
JOIN "music_collections"
ON "music_collections"."id" = "user_creates_mc"."mc_id";

CREATE VIEW "username_song" AS
SELECT "user_id","username", "song_id","name"
FROM "users"
JOIN "user_creates_song"
ON "users"."id" = "user_creates_song"."user_id"
JOIN "songs"
ON "songs"."id" = "user_creates_song"."song_id";

CREATE VIEW "song_mc" AS
SELECT "song_id","songs"."name" AS "song_name", "song_in_mc"."order_in_mc", "mc_id","music_collections"."name" AS "mc_name"
FROM "songs"
JOIN "song_in_mc"
ON "songs"."id" = "song_in_mc"."song_id"
JOIN "music_collections"
ON "music_collections"."id" = "song_in_mc"."mc_id";

CREATE VIEW "user_creates_mc_song" AS
SELECT "user_id", "username", "song_mc"."mc_id","mc_name", "song_id","song_name", "order_in_mc"
FROM "song_mc"
JOIN "username_mc" ON "song_mc"."mc_id" = "username_mc"."mc_id";

CREATE VIEW "user_likes_song_view" AS
SELECT "users"."id" AS "user_id", "users"."username", "songs"."id" AS "song_id", "songs"."name"
FROM "users"
JOIN "user_likes_song" ON "user_likes_song"."user_id" = "users"."id"
JOIN "songs" ON "songs"."id" = "user_likes_song"."song_id";

CREATE VIEW "user_likes_mc_view" AS
SELECT "users"."id" AS "user_id", "users"."username", "music_collections"."id" AS "song_id", "music_collections"."name"
FROM "users"
JOIN "user_likes_mc" ON "user_likes_mc"."user_id" = "users"."id"
JOIN "music_collections" ON "music_collections"."id" = "user_likes_mc"."mc_id";

CREATE VIEW "user_follows_user_view" AS
SELECT "A"."id" AS "A_id", "A"."username" AS "A_username", "B"."id" AS "B_id", "B"."username" AS "B_username"
FROM "users" AS "A"
JOIN "user_follows_user" ON "user_follows_user"."A_user_id" = "A"."id"
JOIN "users" AS "B" ON "user_follows_user"."B_user_id" = "B"."id";


-- DROP TABLE music_collections;
-- DROP TABLE users;
-- DROP TABLE songs;
-- DROP TABLE song_in_mc;
-- DROP TABLE user_follows_user;
-- DROP TABLE user_likes_song;
-- DROP TABLE user_likes_mc;
-- DROP TABLE user_creates_song;
-- DROP TABLE user_creates_mc;
