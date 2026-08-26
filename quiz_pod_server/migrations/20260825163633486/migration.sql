BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "quizes" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "quizes" (
    "id" bigserial PRIMARY KEY,
    "authorUserId" uuid NOT NULL,
    "title" text NOT NULL,
    "instructions" text NOT NULL,
    "questions" json NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "teacher_student" (
    "id" bigserial PRIMARY KEY,
    "teacherUserId" uuid NOT NULL,
    "studentUserId" uuid NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "teacher_student_unique_idx" ON "teacher_student" USING btree ("teacherUserId", "studentUserId");


--
-- MIGRATION VERSION FOR quiz_pod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('quiz_pod', '20260825163633486', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260825163633486', "timestamp" = now();

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
