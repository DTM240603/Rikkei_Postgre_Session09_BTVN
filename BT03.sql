CREATE SCHEMA bt03;
SET SEARCH_PATH TO bt03;

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    category_id INT,
    price NUMERIC(10,2),
    stock_quantity INT
);

INSERT INTO products (
    category_id,
    price,
    stock_quantity
)
SELECT
    (gs % 100) + 1 AS category_id,
    (100000 + (gs % 5000000))::NUMERIC(10,2) AS price,
    (gs % 500) AS stock_quantity
FROM generate_series(1, 500000) AS gs;

EXPLAIN ANALYZE
SELECT *
FROM products
WHERE category_id = 50
ORDER BY price;
-- Execution Time: 69.283 ms

CREATE INDEX idx_products_category_id ON products(category_id);
CLUSTER products USING idx_products_category_id;

EXPLAIN ANALYZE
SELECT *
FROM products
WHERE category_id = 50
ORDER BY price;
-- Execution Time: 0.962 ms

CREATE INDEX idx_products_price ON products(price);

EXPLAIN ANALYZE
SELECT *
FROM products
WHERE category_id = 50
ORDER BY price;
-- Execution Time: 1.021 ms