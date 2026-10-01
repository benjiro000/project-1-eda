-- ============================================================================
-- queries.sql - your analysis
--
-- Project 1 | SQL: From Data to Insight
-- Team: Rizki
-- Dataset: FAOSTAT - Coffee, green (production, trade)
--
-- Element codes: 5312 Area harvested (ha) | 5412 Yield (kg/ha) | 5510 Production (t)
--                5610 Import quantity (t) | 5622 Import value (1000 USD)
--                5910 Export quantity (t) | 5922 Export value (1000 USD)
-- 1000 USD / t = USD / kg, so value / quantity gives the price per kg directly.
--
-- The same queries are run in notebook 03. Each one can also be run in DB Browser (Execute SQL).
-- ============================================================================

-- name: top_producers_2024
-- Q1 context: the 10 biggest producers in 2024 with their land and yield
SELECT c.area_name,
       p.value AS production_t,
       a.value AS area_ha,
       y.value AS yield_kg_ha
FROM production AS p
INNER JOIN production AS a ON a.area_code = p.area_code AND a.year = p.year
INNER JOIN production AS y ON y.area_code = p.area_code AND y.year = p.year
INNER JOIN countries AS c  ON c.area_code = p.area_code
WHERE p.element_code = 5510       -- Production
  AND a.element_code = 5312       -- Area harvested
  AND y.element_code = 5412       -- Yield
  AND p.year = 2024
ORDER BY p.value DESC
LIMIT 10;


-- name: land_yield_price
-- Q1: per country, average area, yield, exports and export price per kg over 2015-2024
SELECT c.area_name,
       AVG(a.value)                  AS avg_area_ha,
       AVG(y.value)                  AS avg_yield_kg_ha,
       AVG(eq.value)                 AS avg_export_t,
       SUM(ev.value) / SUM(eq.value) AS export_price_usd_kg     -- 1000 USD / t = USD / kg
FROM production AS a
INNER JOIN production AS y ON y.area_code  = a.area_code AND y.year  = a.year
INNER JOIN trade AS eq     ON eq.area_code = a.area_code AND eq.year = a.year
INNER JOIN trade AS ev     ON ev.area_code = a.area_code AND ev.year = a.year
INNER JOIN countries AS c  ON c.area_code  = a.area_code
WHERE a.element_code  = 5312      -- Area harvested
  AND y.element_code  = 5412      -- Yield
  AND eq.element_code = 5910      -- Export quantity
  AND ev.element_code = 5922      -- Export value
  AND a.year BETWEEN 2015 AND 2024
GROUP BY c.area_name
HAVING AVG(eq.value) >= 20000     -- only real exporters (at least 20,000 t a year)
ORDER BY avg_area_ha DESC;


-- name: exporter_price_by_year
-- Q2: average export price received by exporting countries, per year (exporter = exports more than it imports)
SELECT eq.year,
       SUM(ev.value) / SUM(eq.value) AS exporter_price_usd_kg
FROM trade AS eq
INNER JOIN trade AS ev ON ev.area_code = eq.area_code AND ev.year = eq.year
INNER JOIN trade AS iq ON iq.area_code = eq.area_code AND iq.year = eq.year
WHERE eq.element_code = 5910      -- Export quantity
  AND ev.element_code = 5922      -- Export value
  AND iq.element_code = 5610      -- Import quantity
  AND eq.value > iq.value         -- net exporter in that year
GROUP BY eq.year
ORDER BY eq.year;


-- name: importer_price_by_year
-- Q2: average import price paid by importing countries, per year (importer = imports at least as much as it exports)
SELECT iq.year,
       SUM(iv.value) / SUM(iq.value) AS importer_price_usd_kg
FROM trade AS iq
INNER JOIN trade AS iv ON iv.area_code = iq.area_code AND iv.year = iq.year
INNER JOIN trade AS eq ON eq.area_code = iq.area_code AND eq.year = iq.year
WHERE iq.element_code = 5610      -- Import quantity
  AND iv.element_code = 5622      -- Import value
  AND eq.element_code = 5910      -- Export quantity
  AND eq.value <= iq.value        -- net importer in that year
GROUP BY iq.year
ORDER BY iq.year;


-- name: top_importers_2024
-- Q2 detail: the 10 biggest importing countries in 2024 and the price per kg they paid
SELECT c.area_name,
       iq.value            AS import_t,
       iv.value / iq.value AS import_price_usd_kg
FROM trade AS iq
INNER JOIN trade AS iv    ON iv.area_code = iq.area_code AND iv.year = iq.year
INNER JOIN trade AS eq    ON eq.area_code = iq.area_code AND eq.year = iq.year
INNER JOIN countries AS c ON c.area_code  = iq.area_code
WHERE iq.element_code = 5610      -- Import quantity
  AND iv.element_code = 5622      -- Import value
  AND eq.element_code = 5910      -- Export quantity
  AND eq.value <= iq.value        -- net importer
  AND iq.year = 2024
ORDER BY iq.value DESC
LIMIT 10;