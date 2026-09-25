-- =========================================================================
-- schema.sql - the tables your database is made of
--
-- Project 1 | SQL: From Data to Insight
-- Team:
-- Dataset:
--
-- This is a DELIVERABLE: it is how someone rebuilds your database from
-- nothing, and the tables here must match the ERD you drew.
--
-- Written for SQLite. On MySQL, add a CREATE DATABASE / USE at the top and
-- swap the types (TEXT -> VARCHAR(n), REAL -> DECIMAL, INTEGER PRIMARY KEY
-- -> INT PRIMARY KEY AUTO_INCREMENT).
-- =========================================================================

-- SQLite does not enforce foreign keys unless you ask it to, once per
-- connection. Without this line a broken key is accepted in silence.
PRAGMA foreign_keys = ON;


-- --- Lookup tables -------------------------------------------------------
-- The categorical columns you pulled out: an id and the value it stands for.
-- These have no foreign keys of their own, so they are created and loaded
-- FIRST.




-- --- Your main table -----------------------------------------------------
-- The rows you are actually analysing: the numbers you care about, plus one
-- foreign key pointing at each lookup table above. Created and loaded LAST,
-- because every key it carries has to already exist somewhere else.




-- --- Indexes (optional) --------------------------------------------------
-- Worth adding on your foreign keys if a query starts to feel slow.
