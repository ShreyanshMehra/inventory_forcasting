-- Low Inventory Detection: Products below their reorder point (Avg Daily Sales × 5 days)
WITH avg_daily_sales AS (
  SELECT
    product_id,
    AVG(units_sold) AS avg_sales
  FROM fact_inventory
  GROUP BY product_id
)
SELECT
  f.store_id,
  f.product_id,
  f.inventory_level,
  (a.avg_sales * 5) AS reorder_point
FROM fact_inventory f
JOIN avg_daily_sales a ON f.product_id = a.product_id
WHERE f.inventory_level < (a.avg_sales * 5)
ORDER BY f.store_id, f.product_id;
