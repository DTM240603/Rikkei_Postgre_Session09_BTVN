CREATE SCHEMA bt02;
SET SEARCH_PATH TO bt02;

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(100),
    username VARCHAR(100)
);

INSERT INTO users (email, username)
SELECT
    'user' || gs || '@example.com',
    'user_' || gs
FROM generate_series(1, 500000) AS gs;

EXPLAIN ANALYZE
SELECT * FROM Users WHERE email = 'user499953@example.com';
-- Execution Time: 138.090 ms

CREATE INDEX idx_users_email ON users USING hash(email);

EXPLAIN ANALYZE
SELECT * FROM Users WHERE email = 'user499953@example.com';
-- Execution Time: 0.036 ms