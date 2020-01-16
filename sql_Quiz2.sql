-- 퇴사 관련 필드가 정의된 것은 없지만, 종료일자가 있는 테이블의 데이터를 살펴보면 '9999-01-01'인 데이터가 있다. 
-- 의미상 현재 근무 중인 직원은 급여나 현재 근무 부서, 업무의 종료일자가 없을 것이다. 
-- 종료일자가 없다는 의미를 '9999-01-01'로 사용한 것 같다.

SELECT COUNT(*) FROM SALARIES WHERE TO_DATE='9999-01-01';
SELECT COUNT(*) FROM TITLES WHERE TO_DATE='9999-01-01';
SELECT COUNT(*) FROM DEPT_EMP WHERE TO_DATE='9999-01-01';

-- 1. 현재 근무중인 직원들의 업무별 직원수를 구하시오.
SELECT title, COUNT(*) FROM titles
		WHERE to_date='9999-01-01' GROUP BY title ORDER BY title;



-- 2. 현재 근무중인 직원들의 평균 급여를 구하시오.
SELECT AVG(salary) FROM salaries WHERE to_date='9999-01-01';


-- 3. 부서별 현재 인원수를 구하시오.
SELECT dept_no, COUNT(*) 
	FROM dept_emp
	WHERE to_date='9999-01-01'
    GROUP BY dept_no;



-- 4. 부서별 현재 인원수를 인원수가 많은 부서부터 출력하시오
SELECT dept_no, COUNT(*) 
	FROM dept_emp
	WHERE to_date='9999-01-01'
    GROUP BY dept_no
    ORDER BY COUNT(*) DESC;



-- 5. 부서 이동이 많은 직원순으로 리스트를 출력하시오 (퇴직자 포함)




-- 6. 부서별 현재 인원수가 15,000명 이상인 부서를 구하시오.




-- 7. 부서별 현재 인원수가 가장 많은 상위 5개 부서를 구하시오


