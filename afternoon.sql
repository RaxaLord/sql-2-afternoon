-- PRACTICE JOINS
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