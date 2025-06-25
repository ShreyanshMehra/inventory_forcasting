-- Reorder Point Estimation for each product (Avg Daily Sales × 5 days)
SELECT
  product_id,
  AVG(units_sold) AS avg_daily_sales,
  (AVG(units_sold) * 5) AS reorder_point
FROM fact_inventory
GROUP BY product_id
ORDER BY product_id;
