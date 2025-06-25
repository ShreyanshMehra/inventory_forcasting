-- Promotion and Seasonality Impact on Average Sales
SELECT
  pr.seasonality,
  pr.holiday_promotion,
  p.category,
  AVG(f.units_sold) AS avg_sales
FROM fact_inventory f
JOIN dim_promo pr ON f.promo_id = pr.promo_id
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY pr.seasonality, pr.holiday_promotion, p.category
ORDER BY pr.seasonality, pr.holiday_promotion, p.category;
