-- Inventory Turnover Ratio: Total Units Sold / Average Inventory Level
SELECT
  f.store_id,
  f.product_id,
  p.category,
  SUM(f.units_sold) * 1.0 / NULLIF(AVG(f.inventory_level), 0) AS inventory_turnover
FROM fact_inventory f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY f.store_id, f.product_id, p.category
ORDER BY inventory_turnover DESC;
