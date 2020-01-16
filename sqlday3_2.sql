-- 크로스 조인



USE sqldb;

SELECT * FROM buytb1
	CROSS JOIN usertb1
	LIMIT 20;

SELECT COUNT(*) FROM buytb1 CROSS JOIN usertb1; -- 120

-- 셀프 조인(자체 조인)
-- p 278
-- INNER JOIN의 일종. 자기 자신한테 테이블을 조인한다.
-- 조직도등에 이용
-- p 280 예제

USE sqlDB;
DROP TABLE IF EXISTS empTbl;
CREATE TABLE empTbl(emp CHAR(3), manager CHAR(3), empTel VARCHAR(8));

DESC empTbl;

INSERT INTO empTbl VALUES('나사장',NULL,'0000');
INSERT INTO empTbl VALUES('김재무','나사장','2222');
INSERT INTO empTbl VALUES('김재무','김재무','2222-1');
INSERT INTO empTbl VALUES('이부장','김재무','2222-2');
INSERT INTO empTbl VALUES('우대리','이부장','2222-2-1');
INSERT INTO empTbl VALUES('지사원','이부장','2222-2-2');
INSERT INTO empTbl VALUES('이영업','나사장','1111');
INSERT INTO empTbl VALUES('한과장','이영업','1111-1');
INSERT INTO empTbl VALUES('최정보','나사장','3333');
INSERT INTO empTbl VALUES('윤차장','최정보','3333-1');
INSERT INTO empTbl VALUES('이주임','윤차장','3333-1-1');

SELECT * FROM empTbl;
SELECT count(*) FROM empTbl; -- 11

-- 직원(emp), 상관(manager), 구내번호(empTel)

-- 가로로 2번 컬럼이 반복되어 표시
SELECT * 
	FROM empTbl A
		INNER JOIN empTbl B
			-- 중복되는 값의 컬럼명 지정
			ON A.manager = B.emp;

-- 우대리 직원의 상관의 구내번호를 찾아라
SELECT A.emp AS '직원', A.manager AS '상관', B.empTel AS '구내번호'
	FROM empTbl A
		INNER JOIN empTbl B
			-- 중복되는 값의 컬럼명 지정
			ON A.manager = B.emp
		WHERE A.emp = '우대리';

-- UNION / UNION ALL
-- 쿼리의 결과를 합쳐서 보여준다.
-- UNION은 중복 허용
-- UNION ALL은 중복된 부분 삭제

-- SELECT ... -- 쿼리1
-- UNION
-- SELECT ... ;-- 쿼리2
SELECT * FROM clubtbl; -- 동아리정보
SELECT * FROM stdtbl; -- 학생정보

-- 첫번째 쿼리의 컬럼 아래에 두번째 쿼리의 컬럼 내용이 추가된다.
SELECT stdName AS '학생이름 + 동아리이름' FROM stdtbl
UNION
SELECT clubName AS '동아리이름' FROM clubtbl;

-- NOT IN : 첫번째 쿼리의 결과 중 두번째 쿼리에 해당하는 것을 제외
-- IN : 두번째 쿼리의 결과만 조회

-- SELECT 첫번째 쿼리
-- 		WHERE ... [NOT IN / IN] (SELECT 두번쨰쿼리)

-- SELECT * 또는 컬럼명 FROM 테이블1
-- 		WHERE 조건절1 NOJT IN 또는 IN(SELECT * 또는 컬럼명 FROM 테이블명2 WHERE 조건절2);

-- 사용자중 전화가 없는 사람을 제외하고싶다. NOT IN
-- 사용자중 전화가 없는 사람만 조회 IN

-- LEFT OUTER JOIN으로 모두 호출
SELECT U.userID, U.name, B.prodName, B.addr,
		CONCAT(U.mobile1,U.mobile2) AS '연락처'
	FROM userTbl U
		LEFT OUTER JOIN buytb1 
			ON U.userID = B.userID
	ORDER BY U.userID;
    
-- 전화가 없는 사람 제외 : NOT IN
SELECT name, CONCAT(mobile1,mobile2) AS '연락처' FROM usertb1
	WHERE name NOT IN (SELECT name FROM usertb1 WHERE mobile1 IS NULL);
    
-- 전화가 없는 사람만 표시 : IN
 SELECT name, CONCAT(mobile1,mobile2) AS '연락처' FROM usertb1
	WHERE name IN (SELECT name FROM usertb1 WHERE mobile1 IS NULL);










