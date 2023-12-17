-- In this SQL file, write (and comment!) the typical SQL queries users will run on your databas
-- All the albums Muse made.
SELECT "name" FROM "music_collections" WHERE "id" IN (
    SELECT "mc_id" FROM "user_creates_mc" WHERE "user_id" = (
        SELECT "id" FROM "users" WHERE "username" = 'muse' AND "artist_flag" = 1
    ) AND "album_flag" = 1
);

-- All singles Muse made.
SELECT "name" FROM "music_collections" WHERE "id" IN (
    SELECT "mc_id" FROM "user_creates_mc" WHERE "user_id" = (
        SELECT "id" FROM "users" WHERE "username" = 'muse' AND "artist_flag" = 1
    ) AND "single_flag" = 1
);

-- All albums Coldplay made.
SELECT "name" FROM "music_collections" WHERE "id" IN (
    SELECT "mc_id" FROM "user_creates_mc" WHERE "user_id" = (
        SELECT "id" FROM "users" WHERE "username" = 'coldplay' AND "artist_flag" = 1
    ) AND "album_flag" = 1
);

-- All the songs in 'Will Of The People' album that Muse owns and how long they last.
SELECT "name" AS "Songs List", "time_sec" AS "Duration in Seconds" FROM "songs" WHERE "id" IN (
    SELECT "song_id" FROM "song_in_mc" WHERE "mc_id" = (
        SELECT "id" FROM "music_collections" WHERE "name" = 'Will Of The People'
        AND "owner_id" = (SELECT "id" FROM "users" WHERE "username" = 'muse')
    )
    ORDER BY "order_in_mc"
);

-- All the songs in 'Will Of The People' album that Muse created and how long they last.
SELECT "name" AS "Songs List", "time_sec" AS "Duration in Seconds" FROM "songs" WHERE "id" IN (
    SELECT "song_id" FROM "user_creates_mc_song"
    WHERE "mc_name" = 'Will Of The People'
    AND "username" = 'muse'
    ORDER BY "order_in_mc"
);

-- All the songs Prachutes Album that coldplay owns and how long they last.
SELECT "name" AS "Songs List", "time_sec" AS "Duration in Seconds" FROM "songs" WHERE "id" IN (
    SELECT "song_id" FROM "song_in_mc" WHERE "mc_id" = (
        SELECT "id" FROM "music_collections" WHERE "name" = 'Parachutes'
        AND "owner_id" = (SELECT "id" FROM "users" WHERE "username" = 'coldplay')
    )
    ORDER BY "order_in_mc"
);


-- All songs Muse created in the db.
SELECT "name" AS "Songs List", "time_sec" AS "Duration in Seconds" FROM "songs" WHERE "id" IN (
    SELECT "song_id" FROM "user_creates_song" WHERE "user_id" = (
        SELECT "id" FROM "users" WHERE "username" = 'muse'
        AND "artist_flag" = 1
    )
);

-- All songs from Coldplay in the db
SELECT "name" AS "Songs List", "time_sec" AS "Duration in Seconds" FROM "songs" WHERE "id" IN (
    SELECT "song_id" FROM "user_creates_song" WHERE "user_id" = (
        SELECT "id" FROM "users" WHERE "username" = 'coldplay'
        AND "artist_flag" = 1
    )
);

-- The playlist MyAwesomeMix from georgeL
SELECT "name" AS "Songs List", "time_sec" AS "Duration in Seconds" FROM "songs" WHERE "id" IN (
    SELECT "song_id" FROM "song_in_mc" WHERE "mc_id" = (
        SELECT "mc_id" FROM "username_mc" WHERE "name" = 'MyAwesomeMix'AND "username" = 'georgeL'
    )
    ORDER BY "order_in_mc"
);
