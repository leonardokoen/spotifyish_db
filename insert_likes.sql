-- User A (georgeL) follows user B(muse)
INSERT INTO "user_follows_user"("A_user_id", "B_user_id")
SELECT "A"."id" AS "A_user_id", "B"."id" AS "B_user_id"
FROM "users" AS "A"
JOIN "users" AS "B" ON "A"."username" = 'georgeL' AND "B"."username" = 'muse';

-- How many followers do muse have?
SELECT COUNT(*) AS "followers" FROM "user_follows_user_view"
WHERE "B_username" = 'muse';

-- How many users do georgeL follow?
SELECT COUNT(*) AS "following" FROM "user_follows_user_view"
WHERE "A_username" = 'georgeL';

-- Unfollow a user
DELETE FROM "user_follows_user"
WHERE "A_user_id" = (
    SELECT "id" FROM "users"
    WHERE "username" = 'georgeL'
)
AND "B_user_id" = (
    SELECT "id" FROM "users"
    WHERE "username" = 'muse'
);


-- User likes a song : "Everything's Not Lost" from Coldplay.
INSERT INTO "user_likes_song"("user_id", "song_id")
SELECT "users"."id", "username_song"."song_id" FROM "users", "username_song"
WHERE "users"."username" = 'georgeL'
AND "username_song"."name" = "Everything's Not Lost" AND "username_song"."username" = 'coldplay';

-- Let's say GeorgeL likes 'Will Of The People' mc that means that he automatically likes all the songs in the album.
INSERT INTO "user_likes_mc"("user_id", "mc_id")
SELECT "users"."id", "username_mc"."mc_id" FROM "users", "username_mc"
WHERE "users"."username" = 'georgeL'
AND "username_mc"."name" = 'Will Of The People' AND "username_mc"."username" = 'muse';

INSERT INTO "user_likes_song"("user_id", "song_id")
SELECT "users"."id", "user_creates_mc_song"."song_id" FROM "users", "user_creates_mc_song"
WHERE "users"."username" = 'georgeL'
AND "user_creates_mc_song"."mc_name" = 'Will Of The People' AND "user_creates_mc_song"."username" = 'muse';

-- Let's see all the songs that georgeL likes, the same logic applies for mc.
SELECT "name" FROM "user_likes_song_view"
WHERE "username" = 'georgeL';

-- Let's see how many likes a song has the same logic applies for mc.
SELECT COUNT(*) AS "likes" FROM "user_likes_song_view"
WHERE "name" = 'lfldf';

-- Let's see who likes the song 'Verona', the same logic applies for mc.
SELECT "username" FROM "user_likes_song_view"
WHERE "name" = 'Verona';

-- Let's say GeorgeL wants to unlike 'Will Of The People' mc from muse,
-- which means that he will unlike all the songs in that mc.
DELETE FROM "user_likes_song"
WHERE "user_id" = (
    SELECT "id" FROM "users"
    WHERE "username" = 'georgeL'
)
AND "song_id" IN (
    SELECT "song_id" FROM "user_creates_mc_song"
    WHERE "mc_name" = 'Will Of The People'
    AND "username" = 'muse'
);

DELETE FROM "user_likes_mc"
WHERE "user_id" = (
    SELECT "id" FROM "users"
    WHERE "username" = 'georgeL'
)
AND "mc_id" = (
    SELECT "mc_id" FROM "username_mc"
    WHERE "name" = 'Will Of The People'
    AND "username" = 'muse'
);



