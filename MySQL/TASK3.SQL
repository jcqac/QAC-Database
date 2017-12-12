-- List the tables in the sakila database
USE sakila;
SHOW TABLES;
-- Describe each of these tables so you understand what each table contains
SELECT * FROM information_schema.columns WHERE table_schema = 'sakila';

-- List all the languages in the language table, sorted alphabetically
SELECT name FROM language ORDER BY name ASC;

-- List all the actors’ first names and last names where the last name ends in ‘MAN’ and order it alphabetically by the first name
SELECT first_name, last_name FROM actor WHERE last_name LIKE '%man' ORDER BY first_name ASC;

-- List all the film names whose description involves a feminist and a robot
SELECT title FROM film WHERE description LIKE '%feminist%' AND description LIKE '%robot%';

-- Return a list of actors who have starred in a film involving a robot
SELECT DISTINCT CONCAT(actor.first_name, ' ' , actor.last_name) AS actorName FROM actor
	INNER JOIN film_actor fa
		ON fa.actor_id = actor.actor_id
	INNER JOIN film f
		ON fa.film_id = f.film_id
	WHERE f.description LIKE '%robot%';

	--Alternatively
SELECT DISTINCT a.* FROM `actor` a
	INNER JOIN film_actor fa
		ON fa.actor_id = a.actor_id
	INNER JOIN film f
		ON fa.film_id = f.film_id
	WHERE f.description LIKE '%robot%';
	
-- Find the top 5 most popular categories of films, returning the category name and the count of the number of films in that category
SELECT category.name, COUNT(*) as count FROM category
	INNER JOIN film_category fc
		ON category.category_id = fc.category_id
	INNER JOIN film f
		ON fc.film_id = f.film_id
	GROUP BY category.name
    ORDER BY count DESC LIMIT 5;

-- Return all actor names and the films they have starred in using a JOIN
SELECT CONCAT(actor.first_name, ' ' , actor.last_name) AS actorName, f.title FROM actor
	JOIN film_actor fa
		ON fa.actor_id = actor.actor_id
	JOIN film f
		ON fa.film_id = f.film_id;

-- Return all details on the top 10 customers who have made the most rentals, including the count of the number of rentals they have made
SELECT CONCAT(customer.first_name, ' ' , customer.last_name) AS customerName, COUNT(*) as count FROM customer
	JOIN rental r
		ON customer.customer_id = r.customer_id
	GROUP BY customerName
    ORDER BY count DESC LIMIT 10;

-- Return all details on the lowest 10 customers who have spent the least amount through payments, including the total amount of payments they have made
SELECT CONCAT(customer.first_name, ' ' , customer.last_name) AS customerName, COUNT(*) as count FROM customer
	JOIN payment p
		ON customer.customer_id = p.customer_id
	GROUP BY customerName
    ORDER BY count ASC LIMIT 10;

-- Return many unique districts there are for addresses in the database
SELECT district, COUNT(*) as count FROM address GROUP BY district;

-- Return how many inactive customers there are
SELECT COUNT(*) from customer WHERE active=0;

-- Return the most popular store_id where the most popular is the one associated with the most customers
SELECT store.store_id, COUNT(*) as count FROM store 
	JOIN customer c
		ON store.store_id = c.store_id
	GROUP BY store.store_id;

-- Return the distinct film ratings
SELECT DISTINCT rating FROM film;

-- Return the film ratings and the count of how many films have that rating
SELECT rating, COUNT(*) as count FROM film GROUP BY rating;

-- Return the film ratings and count of how many films have that rating in that we have in the inventory (not just the film list)
SELECT film.rating, COUNT(*) as count FROM film 
	JOIN inventory iv
		ON film.film_id = iv.film_id
	GROUP BY rating;

-- Return the names and count value of the films that are most popularly rented out (be wary that a film could have many instances of inventory)

SELECT film.title, COUNT(*) as count FROM film
	JOIN inventory iv
		ON film.film_id = iv.film_id
	LEFT OUTER JOIN rental r
	ON iv.inventory_id = r.inventory_id
    GROUP BY film.title
    ORDER BY count DESC;

