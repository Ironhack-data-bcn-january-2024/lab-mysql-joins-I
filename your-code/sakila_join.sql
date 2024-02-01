-- Write a query to display for each store its store ID, city, and country.
SELECT
    store.store_id,
    city.city,
    country.country
FROM store
JOIN address 
ON store.address_id = address.address_id
JOIN city 
ON address.city_id = city.city_id
JOIN country 
ON city.country_id = country.country_id;

-- Write a query to display how much business, in dollars, each store brought in.

SELECT store.store_id, count(store.store_id) as dollars
	FROM payment
	JOIN staff
	ON payment.staff_id  = staff.staff_id
	JOIN store
	ON staff.staff_id = store.store_id
		group by store.store_id
		order by dollars;
        
-- What is the average running time of films by category?

SELECT
    category.category_id,
    AVG(film.length) AS average
FROM
    category
JOIN
    film_category ON category.category_id = film_category.category_id
JOIN
    film ON film_category.film_id = film.film_id
GROUP BY
    category.category_id;
		
-- Which film categories are longest?

SELECT
    category.category_id,
    MAX(film.length) AS longest_film
FROM
    category
JOIN
    film_category ON category.category_id = film_category.category_id
JOIN
    film ON film_category.film_id = film.film_id
GROUP BY
    category.category_id
ORDER BY
    longest_film DESC;

-- Display the most frequently rented movies in descending order.

SELECT
    inventory.film_id,
    COUNT(rental.inventory_id) AS freq_rented
FROM
    inventory
JOIN
    rental ON inventory.inventory_id = rental.inventory_id
GROUP BY
    inventory.film_id
ORDER BY
    freq_rented DESC;

-- List the top five genres in gross revenue in descending order.
SELECT
    category.name,
    SUM(payment.amount) AS gross
FROM
    payment
JOIN
    rental ON payment.rental_id = rental.rental_id
JOIN
    inventory ON rental.inventory_id = inventory.inventory_id
JOIN
    film ON inventory.film_id = film.film_id
JOIN
    film_category ON film.film_id = film_category.film_id
JOIN
    category ON film_category.category_id = category.category_id
GROUP BY
    category.name
ORDER BY
    gross DESC
LIMIT 5;

-- Is "Academy Dinosaur" available for rent from Store 1?