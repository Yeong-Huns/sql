-- 1. 문자열 함수

-- sakila -> DVD 렌탈 서비스

use sakila;

select * from actor LIMIT 10;

-- select * from actor : 데이터 조회하는데 너무 오래걸려서 거의 LIMIT 을 사용한다.

select * from actor LIMIT 100;

/*
 SQL 함수
 값을 반환하는 내장 메소드 / 대부분의 SQL 함수는 데이터베이스 서버에 내장되어있음
 */

-- 1. 문자열 함수

-- LENGTH(string) 문자열의 길이를 반환
SELECT title, LENGTH(title) AS 타이틀_길이
FROM film
LIMIT 10;

-- UPPER(string) 문자열을 대문자로 변환
SELECT UPPER(title) AS 대문자_변환
FROM film
LIMIT 10;

-- LOWER(string) 문자열을 소문자로 변환
SELECT LOWER(title) AS 소문자_변환
FROM film
LIMIT 10;

-- test
SELECT UPPER(f.title), LOWER(f.title)
FROM film as f
LIMIT 10;

-- CONCAT(string1, string2) : 두 개 이상의 문자열을 하나로 연결
-- ex) actor 의 first_name 과 last_name 을 하나로 연결
SELECT CONCAT(a.first_name, ' ', a.last_name) AS full_name
FROM actor as a
LIMIT 10;

-- SUBSTRING(string, start, length) : 문자열에서 부분 문자열을 추출한다.
-- ex) film 테이블의 description 컬럼에서 첫 10글자를 추출한다.
SELECT f.description, SUBSTRING(f.description, 2, 10)
FROM film as f
LIMIT 10;

/*
  연습문제 1.
  film 테이블에서 영화제목(title) 의 길이가 15자인 영화들 찾기
 */
SELECT f.title AS 정답
FROM film as f
WHERE LENGTH(f.title) = 15;

/*
연습문제 2.
actor 테이블에서 첫 번째 이름(first_name)이 소문자로 'john' 인 배우들의 전체 이름을 대문자로 출력해주세요.
 */
SELECT UPPER(CONCAT(a.first_name, ' ', a.last_name)) AS 풀_네임
FROM actor AS a
WHERE LOWER(a.first_name) = 'john';

/*
연습문제 3.
film 테이블에서 description 의 3번째 글자부터 6글자가 'Action' 인 영화의 제목을 찾아주세요
 */
SELECT f.title
FROM film AS f
WHERE SUBSTRING(f.description, 3, 6) = 'Action';

/*
연습문제 4.
rental 테이블에서 대여 시작 날짜 (rental_data) 가
2006년 1월 1일 이후인 모든 대여에 대해, 예상 반납 날짜를 대여 날짜로 부터 5일 뒤로 설정하여,
출력해주세요.
 */