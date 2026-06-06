CREATE SCHEMA bt05;
SET SEARCH_PATH TO bt05;

CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id INT,
    amount NUMERIC(10,2),
    sale_date DATE
);

INSERT INTO sales (customer_id, amount, sale_date)
VALUES
    (1, 1500000.00, '2026-01-05'),
    (2,  800000.00, '2026-01-15'),
    (1, 2200000.00, '2026-02-10'),
    (3,  950000.00, '2026-02-18'),
    (4, 3500000.00, '2026-03-01'),
    (2, 1250000.00, '2026-03-12'),
    (5,  600000.00, '2026-04-05');

SELECT *
FROM sales;

CREATE OR REPLACE PROCEDURE calculate_total_sales(
    start_date DATE,
    end_date DATE,
    OUT total NUMERIC)
LANGUAGE plpgsql
AS $$
    BEGIN
        SELECT SUM(amount)
        INTO total
        FROM sales
        WHERE sale_date BETWEEN start_date AND end_date;
    end;
$$;

DO $$
    DECLARE v_total NUMERIC;
    BEGIN
        CALL calculate_total_sales('2026-01-05', '2026-02-10', v_total);
        RAISE NOTICE '%', v_total;
    end;
$$