-- =========================
-- 1. LOAD DATA FROM CSV INTO STAGING TABLE
-- =========================
-- In SQLite CLI, run:
-- .mode csv
-- .import data/inventory_forecasting.csv stg_inventory_raw

-- =========================
-- 2. DATA CLEANING & INSERTION
-- =========================

-- Remove invalid rows (negative inventory or units sold, or nulls)
DELETE FROM stg_inventory_raw
WHERE "Inventory Level" IS NULL
   OR "Units Sold" IS NULL
   OR "Inventory Level" < 0
   OR "Units Sold" < 0;

-- Populate dimension tables

INSERT OR IGNORE INTO dim_date (date, year, month, day, week, quarter)
SELECT DISTINCT
    date,
    CAST(strftime('%Y', date) AS INTEGER),
    CAST(strftime('%m', date) AS INTEGER),
    CAST(strftime('%d', date) AS INTEGER),
    CAST(strftime('%W', date) AS INTEGER),
    CAST((strftime('%m', date) - 1) / 3 + 1 AS INTEGER)
FROM stg_inventory_raw
WHERE date IS NOT NULL;


INSERT OR IGNORE INTO dim_store (store_id, region)
SELECT DISTINCT store_id, region
FROM stg_inventory_raw
WHERE store_id IS NOT NULL;


INSERT OR IGNORE INTO dim_product (product_id, category)
SELECT DISTINCT product_id, category
FROM stg_inventory_raw
WHERE product_id IS NOT NULL;


INSERT OR IGNORE INTO dim_weather (weather_condition)
SELECT DISTINCT weather_condition
FROM stg_inventory_raw
WHERE weather_condition IS NOT NULL;


INSERT OR IGNORE INTO dim_promo (holiday_promotion, seasonality)
SELECT DISTINCT holiday_promotion, seasonality
FROM stg_inventory_raw
WHERE seasonality IS NOT NULL;

-- Insert into fact table with foreign key mapping
INSERT INTO fact_inventory (
    date_id, store_id, product_id, weather_id, promo_id,
    inventory_level, units_sold, units_ordered, demand_forecast,
    price, discount, competitor_pricing
)
SELECT
    d.date_id,
    s.store_id,
    p.product_id,
    w.weather_id,
    pr.promo_id,
    r.inventory_level,
    r.units_sold,
    r.units_ordered,
    r.demand_forecast,
    r.price,
    r.discount,
    r.competitor_pricing
FROM stg_inventory_raw r
JOIN dim_date d ON r.date = d.date
JOIN dim_store s ON r.store_id = s.store_id
JOIN dim_product p ON r.product_id = p.product_id
JOIN dim_weather w ON r.weather_condition = w.weather_condition
JOIN dim_promo pr ON r.holiday_promotion = pr.holiday_promotion
                  AND r.seasonality = pr.seasonality;
