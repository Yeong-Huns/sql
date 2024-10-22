-- 3. 숫자 함수

-- ABS(number) : 숫자의 절대값을 반환한다.
SELECT ABS(-p.amount) AS 절대값
FROM payment AS p
LIMIT 10;

-- CEIL(number) : 숫자보다 크거나 같은 가장 작은 정수 값을 반환한다(올림)
SELECT CEIL(p.amount) AS CEIL_AMOUNT
FROM payment AS p
LIMIT 10;

-- FLOOR(number) : 숫자 이하의 가장 큰 정수 값을 반환한다.(내림)
SELECT ABS(p.amount) AS 절대값, FLOOR(p.amount) AS FLOOR_AMOUNT
FROM payment AS p
LIMIT 10;

-- ROUND(number, decimals) : 숫자를 특정 소수점 자리수로 반올림 한다.
-- 예) payment 테이블에서 amount 컬럼의 값을 소수점 두 자리로 반올림하여 조회
SELECT ROUND(p.amount, 1) AS 반올림
FROM payment AS p
LIMIT 10;

SELECT ROUND(2.544, 2);

-- SQRT(number) : 숫자의 제곱근을 반환한다.
-- film 테이블에서 length 컬럼의 제곱근을 계산
SELECT f.length AS 원형 ,SQRT(f.length) AS 제곱근
FROM film AS f
LIMIT 10;

SELECT SQRT(4); -- 2는 4의 제곱근

/*
  payment 테이블에서 결제 금액( amount )이 5 이하인 모든 결제에 대해, 절대값을 계산하여 출력해주세요.
 */
SELECT ABS(p.amount) AS 절대값
FROM payment AS p
WHERE p.amount <= 5;

/*
  film 테이블에서 영화 길이( length )가 120분 이상인 모든 영화에 대해, 영화 길이의 제곱근을 계산해주세요.
 */
SELECT SQRT(f.length) AS '영화 길이 제곱근'
FROM film AS f
WHERE f.length >= 120;

/*
 payment 테이블에서 결제 금액( amount )을 소수점 첫 번째 자리에서 반올림하여 출력해주세요.
 */
SELECT ROUND(p.amount, 1)
FROM payment AS p;