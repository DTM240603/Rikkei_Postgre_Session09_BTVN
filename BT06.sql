CREATE SCHEMA bt06;
SET SEARCH_PATH TO bt06;

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC(10,2),
    category_id INT
);

INSERT INTO products (name, price, category_id)
VALUES
    ('Laptop Dell',        25000000.00, 1),
    ('iPhone 15',          22000000.00, 1),
    ('Chuột Logitech',       500000.00, 2),
    ('Bàn phím cơ Razer',   2000000.00, 2),
    ('Tai nghe Bluetooth',  1500000.00, 2),
    ('Sách PostgreSQL',      250000.00, 3);

SELECT *
FROM products
ORDER BY product_id;

CREATE OR REPLACE PROCEDURE update_product_price(
    p_category_id INT,
    p_increase_percent NUMERIC
)
LANGUAGE plpgsql
AS $$
    DECLARE
        p_product RECORD;
        v_new_price NUMERIC(10,2);
    BEGIN
        FOR p_product IN
            SELECT product_id, price
            FROM products
            WHERE category_id = p_category_id
        LOOP
            v_new_price := p_product.price + (p_product.price * p_increase_percent / 100);

            UPDATE products
            SET price = v_new_price
            WHERE product_id = p_product.product_id;
        end loop;
    end;
$$;

CALL update_product_price(1, 50);
SELECT *
FROM products
ORDER BY product_id;