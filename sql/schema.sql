-- ============================================================================
-- schema.sql - Coffee database (FAOSTAT, Coffee, green)
-- Project 1 | SQL: From Data to Insight
-- Team: Rizki
--
-- 3 lookup tables (countries, elements, flags) + 2 fact tables (production, trade)
-- "processed" was dropped: under flag A only it has just 2 rows, too sparse to use.
-- Notebook 02 runs these same statements, then fills the tables with to_sql.
-- You can also run this whole file in DB Browser (Execute SQL) to create the empty tables.
-- ============================================================================

-- Drop children first, then parents, so the script can be run again
DROP TABLE IF EXISTS production;
DROP TABLE IF EXISTS trade;
DROP TABLE IF EXISTS processed;
DROP TABLE IF EXISTS countries;
DROP TABLE IF EXISTS elements;
DROP TABLE IF EXISTS flags;

-- Lookup tables (parents)
CREATE TABLE countries (
    area_code  INTEGER PRIMARY KEY,
    area_name  TEXT NOT NULL
);

CREATE TABLE elements (
    element_code  INTEGER PRIMARY KEY,
    element_name  TEXT NOT NULL,
    unit          TEXT NOT NULL
);

CREATE TABLE flags (
    flag              TEXT PRIMARY KEY,
    flag_description  TEXT NOT NULL
);

-- Fact tables (children)
CREATE TABLE production (
    area_code     INTEGER NOT NULL,
    year          INTEGER NOT NULL,
    element_code  INTEGER NOT NULL,
    value         REAL    NOT NULL,
    flag          TEXT    NOT NULL,
    PRIMARY KEY (area_code, year, element_code),
    FOREIGN KEY (area_code)    REFERENCES countries(area_code),
    FOREIGN KEY (element_code) REFERENCES elements(element_code),
    FOREIGN KEY (flag)         REFERENCES flags(flag)
);

CREATE TABLE trade (
    area_code     INTEGER NOT NULL,
    year          INTEGER NOT NULL,
    element_code  INTEGER NOT NULL,
    value         REAL    NOT NULL,
    flag          TEXT    NOT NULL,
    PRIMARY KEY (area_code, year, element_code),
    FOREIGN KEY (area_code)    REFERENCES countries(area_code),
    FOREIGN KEY (element_code) REFERENCES elements(element_code),
    FOREIGN KEY (flag)         REFERENCES flags(flag)
);