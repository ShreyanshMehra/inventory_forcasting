-- =========================
-- DIMENSION TABLES
-- =========================

CREATE TABLE IF NOT EXISTS dim_date (
    date_id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT UNIQUE NOT NULL,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    week INTEGER,
    quarter INTEGER
);

CREATE TABLE IF NOT EXISTS dim_store (
    store_id TEXT PRIMARY KEY,
    region TEXT
);

CREATE TABLE IF NOT EXISTS dim_product (
    product_id TEXT PRIMARY KEY,
    category TEXT
);

CREATE TABLE IF NOT EXISTS dim_weather (
    weather_id INTEGER PRIMARY KEY AUTOINCREMENT,
    weather_condition TEXT UNIQUE
);

CREATE TABLE IF NOT EXISTS dim_promo (
    promo_id INTEGER PRIMARY KEY AUTOINCREMENT,
    holiday_promotion INTEGER,
    seasonality TEXT
);

CREATE TABLE IF NOT EXISTS fact_inventory (
    fact_id INTEGER PRIMARY KEY AUTOINCREMENT,
    date_id INTEGER,
    store_id TEXT,
    product_id TEXT,
    weather_id INTEGER,
    promo_id INTEGER,
    inventory_level INTEGER,
    units_sold INTEGER,
    units_ordered INTEGER,
    demand_forecast REAL,
    price REAL,
    discount REAL,
    competitor_pricing REAL,
    FOREIGN KEY(date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY(store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY(product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY(weather_id) REFERENCES dim_weather(weather_id),
    FOREIGN KEY(promo_id) REFERENCES dim_promo(promo_id)
);

-- =========================
-- STAGING TABLE FOR RAW LOAD
-- =========================

CREATE TABLE IF NOT EXISTS stg_inventory_raw (
    Date TEXT,
    "Store ID" TEXT,
    "Product ID" TEXT,
    Category TEXT,
    Region TEXT,
    "Inventory Level" INTEGER,
    "Units Sold" INTEGER,
    "Units Ordered" INTEGER,
    "Demand Forecast" REAL,
    Price REAL,
    Discount REAL,
    "Weather Condition" TEXT,
    "Holiday/Promotion" INTEGER,
    "Competitor Pricing" REAL,
    Seasonality TEXT
);
