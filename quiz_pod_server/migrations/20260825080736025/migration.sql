BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "quizes" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "instructions" text NOT NULL,
    "questions" json NOT NULL
);


--
-- MIGRATION VERSION FOR quiz_pod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('quiz_pod', '20260825080736025', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260825080736025', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
