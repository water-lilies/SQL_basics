-- sqlDB.sql 

-- 초기화 
DROP DATABASE IF EXISTS sqlDB; 

-- 데이타베이스 생성 
CREATE DATABASE sqlDB;

-- sqlDB로 변경 
USE sqlDB;

-- 회원 테이블
CREATE TABLE userTbl 
( userID  	CHAR(8) NOT NULL PRIMARY KEY, -- 아이디(PK)
  name    	VARCHAR(10) NOT NULL, -- 이름
  birthYear   INT NOT NULL,  -- 출생년도
  addr	  	CHAR(2) NOT NULL, -- 지역
  mobile1	CHAR(3), -- 휴대폰의 국번
  mobile2	CHAR(8), -- 휴대폰의 나머지 전화번호(하이픈제외)
  height    SMALLINT,  -- 키
  mDate    	DATE  -- 회원 가입일
);
-- 테이블 구조 확인 
DESC usertbl;

-- 회원 구매 테이블
CREATE TABLE buyTbl 
(  num 		INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
   userID  	CHAR(8) NOT NULL, -- 아이디(FK)
   prodName 	CHAR(6) NOT NULL, --  물품명
   groupName 	CHAR(4)  , -- 분류
   price     	INT  NOT NULL, -- 단가
   amount    	SMALLINT  NOT NULL, -- 수량
   -- usrTbl의 userID를 참조. 외래키로 정의 
   FOREIGN KEY (userID) REFERENCES userTbl(userID)
);
-- 테이블 구조 확인 
DESC buyTbl;

-- 데이타 삽입 
INSERT INTO userTbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO userTbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO userTbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO userTbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');
INSERT INTO userTbl VALUES('SSK', '성시경', 1979, '서울', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO userTbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
INSERT INTO userTbl VALUES('YJS', '윤종신', 1969, '경남', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO userTbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3');
INSERT INTO userTbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO userTbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');

-- 테이블 조회 
SELECT * FROM usertbl;

-- 첫번째 컬럼명이 NULL인 이유: 자동숫자증감 AUTO_INCREMENT
INSERT INTO buyTbl VALUES(NULL, 'KBS', '운동화', NULL   , 30,   2);
INSERT INTO buyTbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buyTbl VALUES(NULL, 'JYP', '모니터', '전자', 200,  1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '모니터', '전자', 200,  5);
INSERT INTO buyTbl VALUES(NULL, 'KBS', '청바지', '의류', 50,   3);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '메모리', '전자', 80,  10);
INSERT INTO buyTbl VALUES(NULL, 'SSK', '책'    , '서적', 15,   5);
INSERT INTO buyTbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   2);
INSERT INTO buyTbl VALUES(NULL, 'EJW', '청바지', '의류', 50,   1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);
INSERT INTO buyTbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);

-- 테이블 조회 
-- 데이타 각각 10개씩 잘 들어갔는지 확인 
SELECT * FROM usertbl;
SELECT * FROM buytbl; -- 순차적으로 번호 들어갔는지 확인 

-- where 절로 조건에 맞는 레코드 출력하기 
-- SELECT 컬러명1, 컬럼명2.. 또는 * FROM 테이블명 WHERE 조건절
-- WHERE 조건절 : 비교연산자(>,<,=, >=, <=) 논리연산자(AND, OR, NOT)

-- userTbl 테이블에서 김경호만 출력하기 
SELECT * FROM userTbl WHERE name = '이승기';
SELECT name, addr, userID FROM userTbl WHERE name = '이승기';


-- userTbl 테이블에서 birthYear 이 1970 보다 크거나 같고 height 이 182보다 크다 
-- WHERE 조건1 AND 조건2 : 조건 모두 만족  
SELECT * FROM userTbl WHERE birthYear >= 1970 AND height >= 182;

-- userTbl 테이블에서 birthYear 이 1970 보다 이상이거나  
-- height 이 182보다 큰 레코드에서 
-- userID, Name 컬럼의 레코드 출력 
-- WHERE 조건1 OR 조건2 : 조건1이 만족하거나 조건2가 만족하는 레코드 
SELECT userID, Name FROM userTbl 
	WHERE birthYear >= 1970 OR height >= 182;

-- userTbl 테이블에서 height이 182미만인 레코드 
SELECT userID, height FROM userTbl WHERE NOT  height>=182;   

-- 범위를 지정할 때 사용 
-- WHERE 컬럼명 BETWEEN 값1 AND 값2
-- userTbl 테이블에서 height이 180~183 인 레코드에서 
-- userID, Name 컬럼의 레코드 표시 
SELECT * FROM userTbl 
	WHERE height >= 180 AND height <= 183;
    
SELECT * FROM userTbl WHERE height BETWEEN 180 AND 183;

-- 비연속적인 조건 
-- 특정값 만족 
-- WHERE 컬럼명 IN (값1, 값2 ...)

SELECT * FROM usertbl WHERE addr = '서울' OR addr = '경남';

SELECT * FROM usertbl WHERE addr IN('서울','경남');

-- 특정글자로 끝나는가? 특정 글자로 시작하는가? %
-- 글자수 _(언더바)
-- 컬럼명안의 글자가 김으로 시작하는가?
-- WHERE 컬럼명 LIKE '김%' 
-- 컬럼명안의 글자가 김으로 시작하고 나머지는 2글자 
-- WHERE 컬럼명 LIKE '김__'

SELECT * FROM usertbl WHERE name LIKE '김%';
SELECT * FROM usertbl WHERE name LIKE '__기';
SELECT * FROM usertbl WHERE name LIKE '_기';

-- 레코드 정렬 
-- SELECT 문 ORDER BY 컬럼명;
-- SELECT 문 ORDER BY 컬럼명 DESC;
SELECT * FROM usertbl ORDER BY name; -- 가나다순 
SELECT * FROM usertbl ORDER BY name DESC; -- 가나다 역순 

-- LIMIT는 마지막에 지정 
SELECT * FROM usertbl LIMIT 5 ORDER BY name;

-- 가나다순으로 5개 출력 
SELECT * FROM usertbl ORDER BY name LIMIT 5 ;

-- WHERE 절은 ORDER BY 앞으로 이동
SELECT * FROM usertbl ORDER BY name WHERE height > 170;
SELECT * FROM usertbl WHERE height > 170 ORDER BY name ;

-- 주의사항 : 순서에 주의 
-- SELECT .. FROM .. WHERE 절 ORDER BY .. LIMIT .. ;

-- 서브 쿼리(Sub Query)란?
-- 쿼리문안에 쿼리문이 들어가는 것 
-- SELECT .. FROM.. WHERE 조건절1 
--		(SELECT .. FROM.. WHERE 조건절2 )
-- 주의사항 : 서브쿼리의 레코드 결과값은 1개로 유일해야한다. 

-- 김경호보다 키가 크거나 같은 사람의 이름과 키를 출력하여라 
-- 김경호의 키?

-- 김경호의 키값을 안다. 
-- userTbl 테이블에서 height 컬럼값이 177 이상인 레코드 
SELECT * FROM userTBL WHERE height  >= 177;

-- 김경호의 키값을 모른다. 
-- 김경호의 키를 알수 있는 쿼리문 제작 - step1 
SELECT height FROM userTbl WHERE Name = '김경호';
-- step2 : 메인 쿼리에 서브 쿼리를 삽입 
/* SELECT * FROM userTBL 
	WHERE height  > 김경호의키값 */
SELECT * FROM userTBL 
	WHERE height  > (SELECT height FROM userTbl WHERE Name = '김경호');

-- 서브쿼리가 에러가 나는 경우 
SELECT * FROM userTbl WHERE addr = '서울';

-- 주소지가 서울인 회원보다 키가 큰 사람 
-- 에러 발생 : 서브쿼리의 결과가 2개이상 
SELECT * FROM userTBL 
	WHERE height  > (SELECT height FROM userTbl WHERE addr = '서울');

-- 서브쿼리의 결과가 2개이상인 경우에는 서브쿼리()앞에 ANY 키워드 삽입     
SELECT * FROM userTBL 
	WHERE height  > ANY(SELECT height FROM userTbl WHERE addr = '서울');    
    
-- 중복제거 : 레코드의 중복 제거 
-- 컬럼명에서 중복제거한 후 표시 
-- SELECT DISTINCT 컬럼명 FROM 테이블명;
SELECT * FROM userTBL;
-- userTBL 테이블에서 거주지 목록만 확인하기 (중복제거)
SELECT DISTINCT addr FROM userTBL;
-- userTBL 테이블에서 모바일 국번의 목록만 확인하기 (중복제거)
SELECT DISTINCT mobile1 FROM userTBL;






