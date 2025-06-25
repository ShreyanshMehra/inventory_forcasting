-- Average inventory by store and product
SELECT
  f.store_id,
  f.product_id,
  p.category,
  AVG(f.inventory_level) AS avg_inventory_level
FROM fact_inventory f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY f.store_id, f.product_id, p.category
ORDER BY f.store_id, f.product_id;

-- Average inventory by product across all stores (network/warehouse level)
SELECT
  f.product_id,
  p.category,
  AVG(f.inventory_level) AS avg_inventory_network
FROM fact_inventory f
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY f.product_id, p.category
ORDER BY f.product_id;
