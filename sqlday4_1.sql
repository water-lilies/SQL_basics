-- p 339
-- 뷰(View)란?
-- 테이블 자료의 일부만 보여주고자 할 때 사용하는 기능
-- 원본 데이터중에서 보는 사람에게 필요한 데이터만을 보여준다.
-- 장점
-- 	: 보안, 복잡한 쿼리의 단순화 등

-- 뷰의 생성
/*
DROP VIEW IF EXISTS 뷰이름;
CREATE VIEW 뷰이름
AS
	SELECT 구문
*/

-- 뷰 호출
-- 테이블처럼 호출
-- 뷰를 테이블이라고 생각해도 무방
/*
SELECT * FROM 뷰이름;
*/

-- 뷰 삭제
/*
DROP VIEW IF EXISTS 뷰이름;
*/

-- 뷰 구조 확인
-- DESC 뷰이름;
-- 워크벤치의 [Navigator] - [Schemas] 탭에서 데이타베이스 목록 아래에 [View] 클릭한 후 목록 확인

-- 뷰안에 데이타 삽입
-- 주의사항 : 

-- 데이타베이스 변경
USE tableDB;

-- tableDB 초기화
/*
tabledb.sql
*/

-- 


-- 뷰 삭제 후 새로 생성
DROP VIEW IF EXISTS v_userTbl;
CREATE VIEW v_userTbl
AS
	SELECT userID, name, addr, birthYear
		FROM usertbl;
-- 뷰 구조 확인
DESC v_userTbl;

-- 뷰 출력
SELECT * FROM v_userTbl;
SELECT userID, name FROM v_userTbl;

-- 뷰 생성2 - 컬럼명을 AS로 새롭게 지정하면 별칭으로 지정된 컬럼명을 사용한다.
DROP VIEW IF EXISTS v_userTbl2;
CREATE VIEW v_userTbl2
AS
	SELECT userID AS id, name AS n, addr, birthYear
		FROM usertbl;

DESC v_userTbl2;

SELECT id, n FROM v_userTbl2;


-- 뷰에 데이터 추가
-- 주의사항 : 뷰에 등록한 컬럼의 데이터만 삽입 가능
/*
INSERT INTO 뷰이름(컬럼명1, 컬럼명2 ...) VALUES (값1, 값2 ...);
INSERT INTO VALUES (값1, 값2 ...);
*/
DROP VIEW IF EXISTS v_userTbl3;
CREATE VIEW v_userTbl3
AS
	SELECT 
		-- 원본의 필수 항목을 모두 잡지 않으면 오류 발생
        userID, name, addr, birthYear
		FROM usertbl;

DESC v_userTbl3;

-- 뷰에 데이터 삽입
INSERT INTO v_userTbl3 VALUES ('MBC', '이순신','전남',2002);

SELECT * FROM v_userTbl3;
SELECT * FROM userTbl;

-- 뷰 데이터 수정
-- 뷰안에 데이터 수정
-- 주의사항 : 뷰에서 등록한 컬럼의 데이터만 수정가능
/*UPDATE 뷰이름 SET 컬럼명 = 값 WHERE 절 */
UPDATE v_userTbl3 SET addr ='강원' WHERE name = '이순신';

SELECT * FROM v_userTbl3;
SELECT * FROM userTbl;

-- 뷰 데이터 삭제 
/* DROP FROM 뷰이름 [WHERE 절]; */
DELETE FROM v_usertbl3 WHERE name = '이순신';
SELECT * FROM v_userTbl3;
SELECT * FROM userTbl;

-- 뷰 + WHERE 절, 집계함수로 호출하기
DROP VIEW IF EXISTS v_buyTbl;
CREATE VIEW v_buyTbl
	AS
		SELECT
			userID, prodName, amount, price
            FROM buyTbl;
SELECT * FROM v_buyTbl; 
SELECT * FROM v_buyTbl WHERE prodName ='운동화';
SELECT count(*) AS '전체 레코드 수' FROM v_buyTbl;

-- INNER JOIN 을 뷰로 등록
-- 회원의 구매 목록을 표시하는 뷰
USE sqldb;
SELECT * FROM userTb1;
SELECT * FROM buyTb1;

SELECT U.userID, U.name, B.prodName, B.price, B.amount
	FROM userTb1 U
		INNER JOIN buyTb1 B ON U.userID = B.userID;


-- 이너조인을 뷰로 등록
DROP VIEW IF EXISTS v_userbuyTbl;
CREATE VIEW v_userbuyTbl
	AS
		SELECT U.userID, U.name, B.prodName, U.addr,
				CONCAT(U.mobile1,' - ',U.mobile2) AS '연락처'
		FROM userTb1 U
			INNER JOIN buyTb1 B ON U.userID = B.userID;

SELECT * FROM v_userbuyTbl;

-- 뷰로 등록되어 있어서 WHERE 절만 추가하여 구매 목록 확인
SELECT * FROM v_userBuyTbl WHERE name ='김범수';
SELECT * FROM v_userBuyTbl WHERE name ='은지원';

-- SELF JOIN을 뷰로 등록하여 확인하기
SELECT * FROM empTbl;

-- 부하직원, 직속상관, 구내번호의 모든 레코드 표시
SELECT A.emp, B.emp, B.empTel
	FROM empTbl A
    INNER JOIN empTbl B
    ON A.manager = B.emp;


-- 뷰 v_empTbl로 등록하고 뷰를 호출하면 아래와 같이 나오게 한다.
/*
SELECT * FROM 뷰이름 WHERE name = 사원이름명;

name  manager  phone
최정보   나사장	   00000
*/
DROP VIEW IF EXISTS v_empTbl;
CREATE VIEW v_empTbl
	AS
		SELECT  A.emp AS 'name',
				B.emp AS 'manager',
                B.empTel AS 'phone'
			FROM empTbl A
				INNER JOIN empTbl B
					ON A.manager = B.emp;

SELECT * FROM v_empTbl WHERE name = '우대리';
SELECT * FROM v_empTbl WHERE name = '최정보';
















