-- JOINS *****
-- 1
SELECT *
FROM invoice
    JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
WHERE invoice_line.unit_price > 0.99;
-- 2
SELECT invoice_date, total, first_name, last_name
FROM invoice
    JOIN customer ON invoice.customer_id = customer.customer_id;
-- 3
SELECT a.first_name, a.last_name, b.first_name, b.last_name
FROM customer AS a
    JOIN employee AS b ON a.support_rep_id = b.employee_id;
-- 4
SELECT title, name
FROM album
    JOIN artist ON album.artist_id = artist.artist_id;
-- 5
SELECT track_id
FROM playlist_track
    JOIN playlist ON playlist.playlist_id = playlist_track.playlist_id;
-- 6
SELECT name
FROM track
    JOIN playlist_track ON playlist_track.track_id = track.track_id
WHERE playlist_track.playlist_id = 5;
-- 7
SELECT t.name, p.name
FROM track AS t
    JOIN playlist_track AS pt ON t.track_id = pt.track_id
    JOIN playlist AS p ON pt.playlist_id = p.playlist_id;
-- 8
SELECT t.name, a.title
FROM track AS t
    JOIN album AS a ON t.album_id = a.album_id
    JOIN genre AS g ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk';

-- NESTED QUERIES *****
-- 1
SELECT *
FROM invoice
WHERE invoice_id IN (SELECT invoice_id
FROM invoice_line
WHERE unit_price > 0.99);
-- 2
SELECT *
FROM playlist_track
WHERE playlist_id IN (SELECT playlist_id
FROM playlist
WHERE name = 'Music');
-- 3
SELECT name
FROM track
WHERE track_id IN (SELECT track_id
FROM playlist_track
WHERE playlist_id = 5);
-- 4
SELECT *
FROM track
WHERE genre_id IN (SELECT genre_id
FROM genre
WHERE name = 'Comedy');
-- 5
SELECT *
FROM track
WHERE album_id IN (SELECT album_id
FROM album
WHERE title = 'Fireball');
-- 6
SELECT *
FROM track
WHERE album_id IN (SELECT album_id
FROM album
WHERE artist_id IN (SELECT artist_id
FROM artist
WHERE name = 'Queen'));

-- UPDATING ROWS *****
-- 1
UPDATE customer
SET fax = null
WHERE fax IS NOT null;
-- 2
UPDATE customer
SET company = 'Self'
WHERE company IS null;
-- 3
UPDATE customer
SET last_name = 'Thomson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';
-- 4
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';
-- 5
UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = (select genre_id
    FROM genre
    WHERE name = 'Metal')
    AND composer IS null;

-- GROUP BY *****
-- 1
SELECT COUNT(*), genre.name
FROM track
    JOIN genre ON track.genre_id = genre.genre_id
GROUP BY genre.name;
-- 2
SELECT COUNT(*), genre.name
FROM track
    JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name = 'Pop' OR genre.name = 'Rock'
GROUP BY genre.name;
-- 3
SELECT artist.name, COUNT(*)
FROM album
    JOIN artist ON artist.artist_id = album.artist_id
GROUP BY artist.name;

-- USE DISTINCT *****
-- 1
SELECT DISTINCT composer
FROM track;
-- 2
SELECT DISTINCT billing_postal_code
FROM invoice;
-- 3
SELECT DISTINCT company
FROM customer;

-- DELETE ROWS *****
-- 1
DELETE
FROM practice_delete
WHERE type = 'bronze';
-- 2
DELETE 
FROM practice_delete
WHERE type = 'silver';
-- 3
DELETE
FROM practice_delete 
WHERE value = 150;

-- ECOMMERCE SIM *****

CREATE TABLE users
(
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(30),
    email VARCHAR(120)
);

INSERT INTO users
    (name, email)
VALUES
    ('Raxa', 'ImRaxa@outloook.com'),
    ('Larry', 'ImLarry@AOL.com'),
    ('Barry', 'ImBarry@Hotmail.com');

CREATE TABLE products
(
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(120),
    price DECIMAL
);

INSERT INTO products
    (name, price)
VALUES
    ('t-shirt', 12.37),
    ('baseball cap', 8.95),
    ('sneakers', 23.57);

CREATE TABLE orders
(
    cart_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    product_id INT REFERENCES products(product_id)
);

INSERT INTO orders
    (user_id, product_id)
VALUES
    (1, 2),
    (1, 1),
    (2, 2),
    (3, 1),
    (3, 2),
    (3, 3);

SELECT name, price
FROM orders
    JOIN products ON orders.product_id = products.product_id
WHERE orders.user_id = 1;

SELECT *
FROM orders;

SELECT SUM(price)
FROM orders
    JOIN products ON orders.product_id = products.product_id
WHERE orders.user_id = 1;

SELECT *
FROM orders
    JOIN products ON orders.product_id = products.product_id
WHERE orders.user_id = 1;