-- Forecast Accuracy: Mean Absolute Percentage Error (MAPE) per product
SELECT
  product_id,
  AVG(ABS(demand_forecast - units_sold) * 1.0 / NULLIF(demand_forecast, 0)) AS forecast_error
FROM fact_inventory
GROUP BY product_id
ORDER BY forecast_error;
