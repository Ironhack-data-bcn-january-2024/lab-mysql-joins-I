USE sakila;


-- 1.

SELECT store_id, city, country
FROM 
	store
JOIN 
	address ON store.address_id = address.address_id
JOIN 
	city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

-- 2.

SELECT store.store_id, SUM(amount) AS total_sales
FROM store
JOIN customer ON store.store_id = customer.store_id
JOIN rental ON customer.customer_id = rental.customer_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY store_id;

-- 3. 

SELECT category.category_id, category.name, AVG(length)
FROM 
	category
JOIN 
	film_category ON category.category_id = film_category.category_id
JOIN
	film ON film_category.film_id = film.film_id
GROUP BY category_id;

-- 4. 

SELECT category.category_id, category.name, max(length)
FROM 
	category
JOIN 
	film_category ON category.category_id = film_category.category_id
JOIN
	film ON film_category.film_id = film.film_id
GROUP BY category_id
ORDER BY max(length) DESC;

-- 5.

SELECT film.film_id, film.title, COUNT(rental.rental_id) AS rental_count
FROM 
	film
JOIN 
	inventory ON film.film_id = inventory.film_id
JOIN
	rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film_id, film.title
ORDER BY rental_count DESC
LIMIT 5;

-- 6.

SELECT
    name AS category ,
    SUM(amount) AS gross_revenue
FROM
    category
JOIN
    film_category ON category.category_id = film_category.category_id
JOIN
    film ON film_category.film_id = film.film_id
JOIN
    inventory ON film.film_id = inventory.film_id
JOIN
    rental ON inventory.inventory_id = rental.inventory_id
JOIN
    payment ON rental.rental_id = payment.rental_id
GROUP BY
    category.name
ORDER BY
    gross_revenue DESC
LIMIT 5;

-- 7.

SELECT
    film.title AS title,
    inventory.store_id,
    COUNT(IF(rental.return_date IS NULL, 1, NULL)) AS availability
FROM
    film
JOIN
    inventory ON film.film_id = inventory.film_id
LEFT JOIN
    rental ON inventory.inventory_id = rental.inventory_id
WHERE
    film.title = 'Academy Dinosaur' AND inventory.store_id = 1
GROUP BY
    film.title, inventory.store_id;

