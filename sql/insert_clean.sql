-- Remove invalid rows
DELETE FROM stg_inventory_raw
WHERE "Inventory Level" IS NULL
   OR "Units Sold" IS NULL
   OR "Inventory Level" < 0
   OR "Units Sold" < 0;

-- Insert into dim_store
INSERT OR IGNORE INTO dim_store (store_id, region)
SELECT DISTINCT "Store ID", Region FROM stg_inventory_raw WHERE "Store ID" IS NOT NULL;

-- Insert into dim_product
INSERT OR IGNORE INTO dim_product (product_id, category)
SELECT DISTINCT "Product ID", Category FROM stg_inventory_raw WHERE "Product ID" IS NOT NULL;

-- Insert into dim_weather
INSERT OR IGNORE INTO dim_weather (weather_condition)
SELECT DISTINCT "Weather Condition" FROM stg_inventory_raw WHERE "Weather Condition" IS NOT NULL;

-- Insert into dim_promo
INSERT OR IGNORE INTO dim_promo (holiday_promotion, seasonality)
SELECT DISTINCT "Holiday/Promotion", Seasonality FROM stg_inventory_raw WHERE Seasonality IS NOT NULL;

-- Insert into dim_date
INSERT OR IGNORE INTO dim_date (date, year, month, day, week, quarter)
SELECT DISTINCT
    Date,
    CAST(strftime('%Y', Date) AS INTEGER),
    CAST(strftime('%m', Date) AS INTEGER),
    CAST(strftime('%d', Date) AS INTEGER),
    CAST(strftime('%W', Date) AS INTEGER),
    CAST((strftime('%m', Date) - 1) / 3 + 1 AS INTEGER)
FROM stg_inventory_raw WHERE Date IS NOT NULL;

-- Insert into fact_inventory
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
    r."Inventory Level",
    r."Units Sold",
    r."Units Ordered",
    r."Demand Forecast",
    r.Price,
    r.Discount,
    r."Competitor Pricing"
FROM stg_inventory_raw r
JOIN dim_date d ON r.Date = d.date
JOIN dim_store s ON r."Store ID" = s.store_id
JOIN dim_product p ON r."Product ID" = p.product_id
JOIN dim_weather w ON r."Weather Condition" = w.weather_condition
JOIN dim_promo pr ON r."Holiday/Promotion" = pr.holiday_promotion AND r.Seasonality = pr.seasonality;
