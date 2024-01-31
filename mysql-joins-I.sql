-- 1. Write a query to display for each store its store ID, city, and country.
SELECT store_id, city, country 
FROM store
	JOIN address
		ON store.address_id = address.address_id
	JOIN city
		ON address.city_id = city.city_id
	JOIN country
		ON city.country_id = country.country_id;
    
-- 2. Write a query to display how much business, in dollars, each store brought in.

SELECT SUM(amount), store_id
FROM payment
	JOIN staff
		ON payment.staff_id = staff.staff_id
GROUP BY store_id;

-- 3. What is the average running time of films by category?
SELECT name, AVG(length)
FROM category
	JOIN film_category
		ON category.category_id = film_category.category_id
	JOIN film
		ON film_category.film_id = film.film_id
GROUP BY name;

-- 4. Which film categories are longest?

SELECT name, AVG(length) AS avg_len
FROM category
	JOIN film_category
		ON category.category_id = film_category.category_id
	JOIN film
		ON film_category.film_id = film.film_id
GROUP BY name
ORDER BY avg_len DESC;

-- 5.Display the most frequently rented movies in descending order.

SELECT title, COUNT(rental_date) AS rented
FROM film
	JOIN inventory
		ON film.film_id = inventory.film_id
	JOIN rental
		ON inventory.inventory_id = rental.inventory_id
GROUP BY title
ORDER BY rented DESC;


-- 6.List the top five genres in gross revenue in descending order.

SELECT name, SUM(amount) AS gross_rev
FROM category
	JOIN film_category
		ON category.category_id = film_category.category_id
	JOIN film
		ON film_category.film_id = film.film_id
	JOIN inventory
		ON film.film_id = inventory.film_id
	JOIN rental
		ON inventory.inventory_id = rental.inventory_id
	JOIN payment
		ON rental.rental_id = payment.payment_id
GROUP BY name
ORDER BY gross_rev DESC
LIMIT 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?

SELECT title, rental_date, return_date, store.store_id
FROM rental
	JOIN staff
		ON rental.staff_id = staff.staff_id
	JOIN store
		ON staff.store_id = store.store_id
	JOIN inventory
		ON store.store_id = inventory.inventory_id
	JOIN film
		ON inventory.film_id = film.film_id
WHERE store.store_id = 1 
	AND title = "Academy Dinosaur"
ORDER BY return_date DESC;
