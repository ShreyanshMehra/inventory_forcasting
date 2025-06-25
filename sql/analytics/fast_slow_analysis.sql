WITH turnover AS (
  SELECT
    f.product_id,
    p.category,
    SUM(f.units_sold) * 1.0 / NULLIF(AVG(f.inventory_level), 0) AS turnover_ratio
  FROM fact_inventory f
  JOIN dim_product p ON f.product_id = p.product_id
  GROUP BY f.product_id, p.category
)
SELECT
  product_id,
  category,
  CASE
    WHEN turnover_ratio > 30 THEN 'Fast-Moving'
    WHEN turnover_ratio < 5 THEN 'Slow-Moving'
    ELSE 'Moderate'
  END AS movement_category,
  ROUND(turnover_ratio, 2) AS turnover_ratio
FROM turnover
ORDER BY turnover_ratio DESC;
