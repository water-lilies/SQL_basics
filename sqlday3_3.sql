/*
GUI 모드에서 
1) DB 생성
-- 데이터 베이스 생성
CREATE DATABASE tableDB;

2) DB 사용 변경

3) [SCHEMAS] 탭을 이용한 테이블 생성
[Talbes] 마우스 우측 버튼 클릭 후
	[Crate Table]...

4) [SCHEMAS] 탭을 이용하여 테이블 데이타 삽입하기
생성된 테이블 목록을 마우스 우측 버튼 클릭 후 
[SELECT ROWS]

5) 테이블 삭제
[DROP TABLE] : 테이블 구조까지 모두 삭제
[TRUMCATE] : 구조는 남겨두고 데이텨만 삭제 
*/
-- 데이터베이스 생성
CREATE DATABASE tableDB;
USE tableDB;

DESC bbsTbl;
SELECT * FROM bbsTbl;

-- *** 테이블 수정 ***
-- p 328
USE sqldb;
SELECT * FROM userTB1;

-- 기존 테이블에서 새로운 컬럼 추가 

-- ALTER TABLE 테이블명
-- 	ADD 컬럼명 데이터형( CHAR(), INT, VARCHAR(), DATE, DATETIME ... )
-- 		[DEFAULT 디폴트값] -- 기본값 설정 
-- 		[NULL/NOT NULL]; -- Null 허용함

-- 새로운 컬럼 추가 1
ALTER TABLE userTb1
	ADD homepage VARCHAR(30)  -- 열추가
		DEFAULT 'http://google.com' -- 디폴트값
		NULL; -- Null 허용함
        
SELECT * FROM userTB1;
        
-- 새로운 컬럼 추가 2        
ALTER TABLE userTb1
	ADD age INT(3) -- 열추가
		NULL; -- Null 허용함        

SELECT * FROM userTB1;

-- 기존 컬럼 삭제 1 - 키가 없는 경우 
-- ALTER TABLE 테이블명
-- 	DROP COLUMN 컬럼명;

ALTER TABLE userTB1
	DROP COLUMN age;
    
SELECT * FROM userTB1;

-- 기존 컬럼 삭제 2 - 키가 있는 경우 
-- 주의사항 : 외래키 -> 기본키 순으로 먼저 삭제한 후 컬럼 삭제 진행 

-- STEP1 : 키삭제 
-- ALTER TABLE 테이블명
-- DROP PRIMARY KEY 또는 FOREIGN KEY 테이블명_ibfk_1; 

-- STEP2 : 컬럼 삭제 
--  ALTER TABLE 테이블명
-- 	DROP COLUMN 컬럼명;

DESC userTb1;
DESC buyTb1;

-- userTbl 테이블에 PRIMARY KEY 삭제 
-- 오류 발생 : FOREIGN KEY가 설정되어 있어 오류 발생 

-- ALTER TABLE userTbl
-- 	DROP PRIMARY KEY; 

DESC buyTb1;

-- 외래키 삭제  buyTbl
ALTER TABLE buyTb1 DROP FOREIGN KEY buytb1_ibfk_1;
    
DESC buyTb1;  
SELECT * FROM buyTb1; 

-- PRIMARY KEY 삭제 userTbl
ALTER TABLE userTb1	DROP PRIMARY KEY; 
    
DESC userTb1;  
SELECT * FROM userTb1;     

-- 컬럼 삭제 mobile1, mobile2
ALTER TABLE userTbl	DROP COLUMN  mobile1;
    
ALTER TABLE userTbl	DROP COLUMN mobile2;
    
DESC userTbl;  
SELECT * FROM userTbl; 

-- 컬럼 수정 
-- 컬럼명1을 컬럼명2로 수정 
-- ALTER TABLE 테이블명 
-- 	CHANGE COLUMN 컬럼명1 컬럼명2 데이타형 [NULL 또는 NOT NULL] ;
    
ALTER TABLE userTbl	CHANGE COLUMN name uName VARCHAR(20) NULL ;
    
DESC userTbl;  
SELECT * FROM userTbl; 







-- 테이블 구조 변경 퀴즈
-- 1) employees 테이블에서 10개의 레코드를 복사하여 새로운 테이블 생성
-- emp_no, first_name, late_name, gender
/*
	CREATE TABLE 테이블명1 ( SELECT 컬럼명1 ... FROM 테이블명2);
*/
-- 2) 새로운 컬럼 추가
-- 	State 컬럼 추가 - 디폴트 값으로 ?

-- 3) 기존 컬럼 삭제
-- 		gender

-- 4) 컬럼 수정
-- last_name => family name 으로 컬럼명 수정




