/*
 film 테이블에서 평균 영화 길이 (length) 보다 긴 영화들의 제목 (title) 을 찾아주세요
 */

    SELECT title FROM film
    WHERE length > (SELECT AVG(length) FROM film);

 /*
  rental 테이블에서 고객별 평균 대여 횟수보다 많은 대여를 한 고객들의 이름(first_name, last_name) 을 찾아주세요
  */

SELECT first_name, last_name
FROM customer
WHERE customer_id IN(
SELECT customer_id
FROM rental
GROUP BY customer_id
HAVING COUNT(*) >
(SELECT AVG(CC)
FROM
(SELECT COUNT(*) AS CC
FROM rental
GROUP BY customer_id) AS COUNTS));


SELECT first_name, last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
HAVING COUNT(c.customer_id) > (
    SELECT AVG(CC)
    FROM (
        SELECT COUNT(*) AS CC
        FROM rental
        GROUP BY customer_id
         ) AS counts
    );

SELECT first_name, last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
HAVING COUNT(*) > (
    SELECT AVG(value)
    FROM (
        SELECT COUNT(*) AS value
        FROM rental
        GROUP BY customer_id
         ) dataView
    );

SELECT * FROM rental;
SELECT * FROM customer;

SELECT first_name, last_name
FROM customer
WHERE customer_id IN(
SELECT customer_id
FROM rental
GROUP BY customer_id
HAVING COUNT(*) > (
SELECT AVG(rc)
FROM
(SELECT COUNT(*) AS rc
FROM rental
GROUP BY customer_id) AS rental_counts
)
);
/*
 가장 많은 영화를 대여한 고객의 이름(first_name, last_name) 을 찾아주세요
 */


SELECT first_name, last_name
FROM customer
WHERE customer_id =(
    SELECT customer_id AS r
    FROM rental
    GROUP BY customer_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);


SELECT c.first_name, c.last_name
FROM customer AS c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY COUNT(*) DESC LIMIT 1;

/*
 각 고객에 대해 자신이 대여한 평균 영화 길이 (length) 보다 긴 영화들의 제목 (title) 을 찾아주세요
 */

-- customer , rental , inventory , film  / 모두 JOIN 해야함

SELECT c.first_name, c.last_name, f.title
FROM customer c
JOIN rental r ON r.customer_id = c.customer_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film f ON f.film_id = i.film_id
WHERE f.length > (
    SELECT AVG(fil.length)
    FROM film fil
    JOIN inventory inv ON inv.film_id = fil.film_id
    JOIN rental ren ON ren.inventory_id = inv.inventory_id
    WHERE ren.customer_id = c.customer_id
    );

