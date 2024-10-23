-- 서브 쿼리(sub query) 는 중첩 쿼리(Nested query) 라고도 하며, 다른 SQL 쿼리의 맥락 안에 포함되는 퀴리이다.

-- 간단한 서브쿼리
-- 평균 결제 금액보다 많은 결제를 한 사람을 찾아보기

SELECT *
FROM payment AS p
LIMIT 10;

SELECT CONCAT(c.first_name, ' ', c.last_name)
FROM customer AS c
WHERE c.customer_id IN(
    SELECT p.customer_id
    FROM payment AS p
    WHERE p.amount > (SELECT AVG(amount) FROM payment)
    );

SELECT CONCAT(c.first_name, ' ', c.last_name)
FROM customer AS c
WHERE c.customer_id IN(
    SELECT p.customer_id
    FROM payment AS p
    WHERE p.amount > 3
);

-- Group By 가 있는 서브쿼리
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING COUNT(*) > (
        SELECT AVG(payment_count)
        FROM (
                 SELECT COUNT(*) AS payment_count
                 FROM payment
                 GROUP BY customer_id
             ) AS payment_counts
    )
);

SELECT CONCAT(c.first_name, ' ', c.last_name) AS name
FROM customer AS c
WHERE c.customer_id IN(
    SELECT p.customer_id
    FROM payment AS p
    GROUP BY p.customer_id
    HAVING COUNT(*) > (
        SELECT AVG(payment_count)
        FROM(
            SELECT COUNT(*) AS payment_count
            FROM payment
            GROUP BY customer_id
            ) AS payment_count
    )
);

-- 최대값을 가진 행 찾기
-- 가장 많은 결제를 한 고객을 찾는다.
SELECT CONCAT(first_name, ' ', last_name)
FROM customer
WHERE customer_id = (
    SELECT customer_id
    FROM (
             SELECT customer_id, COUNT(*) AS payment_count
             FROM payment
             GROUP BY customer_id
         ) AS payment_counts
    ORDER BY payment_count DESC
    LIMIT 1
    );

-- 상관 서브쿼리
SELECT p.customer_id, p.amount, p.payment_date
FROM payment AS p
WHERE p.amount > (
    SELECT AVG(amount)
    FROM payment
    WHERE customer_id = p.customer_id
    );

-- 연습문제
/*
 film 테이블에서 평균 영화 길이 (length) 보다 긴 영화들의 제목(title) 을 출력
 */
SELECT * FROM film LIMIT 10;

SELECT f.title, f.length
FROM film f
WHERE f.length > (
    SELECT AVG(length)
    FROM film
    )
ORDER BY f.length;

SELECT AVG(film.length) FROM film; -- 115.xx

/**
  rental 테이블에서 고객별 평균 대여 횟수보다 많은 대여를 한 고객들의 이름 (first_name, last_name)
  을 찾아주세요
 */
SELECT * FROM rental LIMIT 10;

SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) > (
    SELECT AVG(average)
    FROM (
          SELECT customer_id, COUNT(*) AS average
          FROM rental
          GROUP BY customer_id
         ) AS avg
    )
    );

SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) > (
        SELECT AVG(rental_count)
        FROM (
                 SELECT COUNT(*) AS rental_count
                 FROM rental
                 GROUP BY customer_id
             ) AS rental_counts
    )
);


SELECT AVG(pp)
FROM(SELECT COUNT(*) AS pp
     FROM rental
     GROUP BY customer_id) AS pps;




