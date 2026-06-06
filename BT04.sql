CREATE SCHEMA bt04;
SET SEARCH_PATH TO bt04;

CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id INT,
    product_id INT,
    sale_date DATE,
    amount NUMERIC(10,2)
);

INSERT INTO sales (customer_id, product_id, sale_date, amount)
VALUES
    (1, 101, '2026-01-05', 500.00),
    (1, 102, '2026-01-10', 800.00),
    (2, 103, '2026-01-15', 300.00),
    (2, 104, '2026-02-02', 450.00),
    (3, 101, '2026-02-10', 1200.00),
    (3, 105, '2026-02-15', 900.00),
    (4, 102, '2026-03-01', 700.00);

SELECT * FROM sales;

-- 1. Tạo View CustomerSales tổng hợp tổng amount theo từng customer_id
CREATE VIEW CustomerSales AS
SELECT
    customer_id,
    SUM(s.amount) total_amount
FROM sales s
GROUP BY customer_id;

-- 2. Viết truy vấn SELECT * FROM CustomerSales WHERE total_amount > 1000; để xem khách hàng mua nhiều
SELECT * FROM CustomerSales WHERE total_amount > 1000;

-- 3. Thử cập nhật một bản ghi qua View và quan sát kết quả
UPDATE CustomerSales
SET total_amount = 2500
WHERE customer_id = 1;

-- CustomerSales là View tổng hợp vì sử dụng SUM() và GROUP BY nên sẽ ko ập nhật trực tiếp qua view được