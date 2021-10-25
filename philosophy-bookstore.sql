-- -- Philosophy Bookstore

-- Create a table
CREATE TABLE store (id INTEGER PRIMARY KEY, book TEXT, author TEXT, price INTEGER, language TEXT, year_written INTEGER, era TEXT, condition TEXT);

-- Insert books into table
INSERT INTO store
VALUES (1, 'Republic', 'Plato', 12, 'Greek', 375, 'BCE', 'Fine');

INSERT INTO store
VALUES (2, 'Meditations', 'Aurelius, Marcus', 8, 'Latin', 180, 'CE', 'As New');

INSERT INTO store
VALUES (3, 'Being and Time', 'Heidegger, Martin', 25, 'German', 1927, 'CE', 'Very Good'); 

INSERT INTO store
VALUES (4, 'The Prince', 'Machiavelli, Niccolo', 7, 'Italian', 1532, 'CE', 'Fair');

INSERT INTO store
VALUES (5, 'Candide', 'Voltaire', 6, 'French', 1759, 'CE', 'Good');

INSERT INTO store
VALUES (6, 'Thus Spoke Zarathustra', 'Nietzsche, Friedrich', 14, 'German', 1885, 'CE', 'Very Good');

INSERT INTO store
VALUES (7, 'Walden', 'Thoreau, Henry David', 3, 'English', 1854, 'CE', 'Poor');

INSERT INTO store
VALUES (8, 'Beyond Good and Evil', 'Nietzsche, Friedrich', 12, 'German', 1886, 'CE', 'Good');

INSERT INTO store
VALUES (9, 'Letters from a Stoic', 'Seneca', 6, 'Latin', 65, 'CE', 'Fine');

INSERT INTO store
VALUES (10, 'Metaphysics', 'Aristotle', 8, 'Greek', 350, 'BCE', 'Very Good');

INSERT INTO store
VALUES (11, 'Meditations on First Philosophy', 'Decartes, Rene', 3, 'Latin', 1641, 'CE', 'Good');

INSERT INTO store
VALUES (12, 'Anthem', 'Rand, Ayn', 2, 'English', 1938, 'CE', 'Poor');

INSERT INTO store
VALUES (13, 'Second Treatise of Government', 'Locke, John', 4, 'English', 1689, 'CE', 'Good');

INSERT INTO store
VALUES (14, 'Essays and Aphorisms', 'Schopenhauer, Arthur', 5, 'German', 1859, 'CE', 'Fair');

INSERT INTO store
VALUES (15, 'Either/Or: A Fragment of Life', 'Kierkegaard, Soren', 10, 'Dutch', 1843, 'CE', 'Fine');

-- -- Queries

-- Show all
SELECT *
FROM store

-- Show all ordered by descending price
SELECT *
FROM store
ORDER BY price DESC

-- Show average book price made before 1800 CE
SELECT AVG(price) AS AVERAGE_PRICE_AFTER_1800
FROM store
WHERE year_written < 1800

-- Show average book price made after 1800 CE
SELECT AVG(price) AS AVERAGE_PRICE_AFTER_1800
FROM store
WHERE year_written > 1800

-- Show maximum book price by language and ordered by price descending
SELECT CAST(language AS varchar(max)) AS LANGUAGE, MAX(price) AS HIGHEST_PRICE
FROM store
GROUP BY CAST(language AS varchar(max))
ORDER BY 2 DESC
