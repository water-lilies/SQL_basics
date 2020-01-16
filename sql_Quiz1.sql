-- SQL 퀴즈
USE employees;
SELECT * FROM employees limit 5;

-- 1. 직원 이름이 빠른 순(A, B, C …) 순으로 리스트를 출력하시오.
SELECT * FROM employees ORDER BY last_name;	


-- 2. 직원 나이가 적은 순으로 출력하시오.
SELECT * FROM employees ORDER BY birth_date DESC;	


-- 3. 직원 중 나이가 가장 많은 사람의 나이는 몇 살 인가?
SELECT MIN(BIRTH_DATE) FROM EMPLOYEES;
SELECT year(curdate()),
	   year(MIN(BIRTH_DATE)),
       year(curdate()) - year(MIN(BIRTH_DATE)) FROM EMPLOYEES;

SELECT TIMESTAMPDIFF(YEAR, MIN(BIRTH_DATE), NOW()) FROM EMPLOYEES;


-- 4. 직원들의 업무(titles)에는 직원별로 업무가 저장되어 있다. 이 회사의 업무 종류 리스트를 구하시오.
SELECT DISTINCT title FROM titles;


-- 5. 이 회사의 업무 종류 개수를 구하시오.
SELECT COUNT(DISTINCT title) FROM titles;

-- 6. 가장 최근에 입사한 사람 100명만 출력하시오
SELECT * FROM employees ORDER BY hire_date DESC LIMIT 100;


-- 7. 급여가 가장 많은 사람 10명을 구하시오.
SELECT * FROM salaries ORDER BY salary DESC LIMIT 10;


-- 8. 급여가 가장 많은 사람 10명을 제외하고 다음 10명을 구하시오.
--   즉, 11등부터 20등 까지…
SELECT * FROM salaries ORDER BY salary DESC LIMIT 10,10;


-- 9. 입사한지 가장 오래된 사람의 이름은 무엇인가?
SELECT first_name, last_name FROM employees ORDER BY hire_date LIMIT 1;


-- 10. 1999년에 입사한 직원 리스트를 구하시오.
SELECT * FROM employees WHERE YEAR(hire_date)=1999;


-- 11. 1999년에 입사한 직원 중 여자 직원(GENDER='F') 리스트를 구하시오.
SELECT * FROM employees WHERE YEAR(hire_date)=1999 and gender='F';


-- 12. 1998년에 입사한 직원 중 남자 직원(M)은 몇 명인가?
SELECT COUNT(*) FROM employees WHERE YEAR(hire_date)=1998 and gender='M';


-- 13. 1998년이나 1999년에 입사한 직원의 수를 구하시오.
SELECT COUNT(*) FROM employees 
	WHERE YEAR(hire_date)=1998 OR YEAR(hire_date)=1999;


-- 14. 1995년부터 1999년까지 입사한 직원의 수를 구하시오.
SELECT COUNT(*) FROM employees 
	WHERE YEAR(hire_date) BETWEEN 1995 AND 1999; 


-- 15. 성(last_name)이 Senzako, Pettis, Henseler인 직원을 출력하시오.
SELECT * FROM employees 
	WHERE last_name IN('Senzako','Pettis','Henseler');
