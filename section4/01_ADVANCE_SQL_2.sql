-- 2. 날짜 시간 함수

-- NOW() : 현재 날짜와 시간을 반환한다.
SELECT NOW();
-- 2024-10-21 13:12:41

-- CURDATE() : 현재 날짜를 반환한다.
SELECT CURDATE();
-- 2024-10-21

-- CURTIME() : 현재 시간을 조회한다.
SELECT CURTIME();
-- 13:13:32

-- DATE_ADD(date, INTERVAL unit) : 날짜에 간격을 추가한다.
/*
  예: rental 테이블에서 각 대여 시작 날짜(rental_date)에 7일을 추가한다.
  년: YEAR, 달: MONTH, 일: DAY, 시간: HOUR, 분: MINUTE, 초: SECOND
 */
SELECT r.rental_date, DATE_ADD(r.rental_date, INTERVAL 7 DAY) AS '날짜 추가 후'
FROM rental as r
LIMIT 10;

-- EXTRACT(field FROM source) : SQL 의 EXTRACT 함수는 날짜 필드에서 특정 부분(예: 년, 월, 일 등)을 추출할 때 사용된다.
-- EXTRACT 는 다음과 같은 구문을 가진다.
/*
 EXTRACT(field FROM source)

 * field: 추출할 날짜의 부분(YEAR, MONTH, DAY, HOUR, MINUTE 등)
 * source: 날짜 값이 저장된 컬럼 또는 날짜 리터럴
 * Sakilla 데이터베이스 예제
    * Sakilla 데이터베이스의 payment 테이블 기반 / payment_date 날짜/시간 컬럼
 */
SELECT p.payment_date, EXTRACT(YEAR FROM p.payment_date)
FROM payment as p; -- 년도만 추출

SELECT payment.payment_date, EXTRACT(MONTH FROM payment.payment_date)
FROM payment;

SELECT p.payment_date
FROM payment AS p
WHERE EXTRACT(YEAR FROM p.payment_date) = 2005;

SELECT p.payment_date
FROM payment AS p
WHERE EXTRACT(MONTH FROM p.payment_date) = 5;

SELECT p.payment_date
FROM payment as p
WHERE EXTRACT(DAY FROM p.payment_date) = 27;

-- 각 월별 결제 횟수 세기
SELECT EXTRACT(MONTH FROM p.payment_date) AS 월별렌탈지불, COUNT(*)
FROM payment as p
GROUP BY 월별렌탈지불;

SELECT EXTRACT(MONTH FROM p.payment_date) AS 월별렌탈지불, COUNT(*)
FROM payment as p
WHERE EXTRACT(MONTH FROM p.payment_date) = 5
GROUP BY 월별렌탈지불;

-- DAYOFWEEK() : 요일별 렌탈 횟수
-- 일: 1 , 월: 2, 화: 3, ... 토: 7
SELECT DAYOFWEEK(p.payment_date) AS 요일, COUNT(*)
FROM payment as p
GROUP BY 요일;

-- TIMESTAMPDIFF(unit, start_datetime, end_datetime) : 두 날짜 또는 시간 값 사이의 차이를 계산한다.
/*
 unit: 반환할 시간 단위
    * SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, YEAR 등등
 예) rental 테이블 rental_date, return_date 비교
 */
SELECT TIMESTAMPDIFF(DAY, r.rental_date, r.return_date) AS 렌탈기간
FROM rental as r
LIMIT 10;

-- DATE_FORMAT(date, format) : 날짜 또는 시간 데이터를 틀정 형식의 문자열로 변환하는 함수
/**
  date: 형식을 변경할 날짜 또는 시간 컬럼 또는 값
  format: 변환할 형식을 지정하는 문자열

  ** 형식 문자열에서 자주 사용되는 지시자
  %Y : 4자리 연도를 표시합니다 (예: 2024).
  %y : 연도의 마지막 두 자리를 표시합니다 (예: 24).
  %M : 영문 월 이름을 표시합니다 (예: January).
  %m : 월을 두 자리 숫자로 표시합니다 (01부터 12까지).
  %c : 월을 한 자리 숫자로 표시합니다 (1부터 12까지, 필요에 따라 한 자리 또는 두 자리로 표시).
  %D : 일을 2자리 숫자와 영문 접미사로 표시합니다 (예: 1st, 21st).
  %d : 일을 두 자리 숫자로 표시합니다 (01부터 31까지).
  %H : 시간을 24시간 형식의 두 자리 숫자로 표시합니다 (00부터 23까지).
  %h : 시간을 12시간 형식의 두 자리 숫자로 표시합니다 (01부터 12까지).
  %l : 시간을 12시간 형식의 한 자리 또는 두 자리 숫자로 표시합니다 (1부터 12까지, 필요에 따라 한 자리 또는 두 자
  리로 표시).
  %i : 분을 두 자리 숫자로 표시합니다 (00부터 59까지).
  %s : 초를 두 자리 숫자로 표시합니다 (00부터 59까지).
 */

/*
 예시) rental 테이블의 rental_date (날짜_시간 컬럼)에 DATE_FORMAT() 적용해보기
 */
SELECT r.rental_id, DATE_FORMAT(r.return_date, '%Y-%m-%d')
FROM rental as r
LIMIT 10;

-- 복습
SELECT f.title
FROM film AS f
WHERE LENGTH(f.title) = 15;

SELECT UPPER(CONCAT(a.first_name, ' ', a.last_name))
FROM actor as a
WHERE a.first_name = 'john';

SELECT f.title, f.description
FROM film AS f
WHERE SUBSTRING(f.description, 3, 6) = 'Action';

SELECT DATE_ADD(r.rental_date, INTERVAL 5 DAY) AS '예상 반납 날짜'
FROM rental AS r
WHERE r.rental_date >= '2006-01-01';

SELECT r.rental_date, DATE_ADD(r.rental_date, INTERVAL 5 DAY) AS '예상 반납일'
FROM rental AS r
WHERE EXTRACT(YEAR FROM r.rental_date);