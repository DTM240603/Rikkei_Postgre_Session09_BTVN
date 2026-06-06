CREATE SCHEMA bt01;
SET SEARCH_PATH TO bt01;

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount NUMERIC(10,2)
);

INSERT INTO orders (
    customer_id,
    order_date,
    total_amount
)
SELECT
    (gs % 10000) + 1 AS customer_id,
    CURRENT_DATE - (gs % 1000) AS order_date,
    (100000 + (gs % 5000000))::NUMERIC(10,2) AS total_amount
FROM generate_series(1, 500000) AS gs;


EXPLAIN ANALYZE
SELECT * FROM Orders WHERE customer_id = 9994;
-- Execution Time: 140.677 ms

CREATE INDEX idx_orders_customer_id ON orders(customer_id);

EXPLAIN ANALYZE
SELECT * FROM Orders WHERE customer_id = 9994;
-- Execution Time: 0.094 ms