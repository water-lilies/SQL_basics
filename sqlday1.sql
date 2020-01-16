-- 초기화
DROP DATABASE IF EXISTS sqlDB;

-- 데이터베이스 생성
CREATE DATABASE sqlDB;

-- sqlDB로 변경
USE sqlDB;
CREATE TABLE userTb1
( userID	CHAR(8) NOT NULL PRIMARY KEY,
  name		VARCHAR(10) NOT NULL,
  birthYear INT NOT NULL,
  addr		CHAR(2) NOT NULL,
  mobile1	CHAR(3),
  mobile2	CHAR(8),
  height	SMALLINT,
  mDate		DATE
);
CREATE TABLE buyTb1
( num	    INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  userID    CHAR(8) NOT NULL,
  prodName  CHAR(6) NOT NULL,
  groupName CHAR(4),
  price		INT NOT NULL,
  amount	SMALLINT NOT NULL,
  FOREIGN KEY (userID) REFERENCES userTb1(userID)
  );
  
  INSERT INTO userTb1 VALUES('LSG','이승기',1987,'서울','010','11111111',182,'2008-8-8');
  INSERT INTO userTb1 VALUES('KBS','김범수',1979,'경남','010','22222222',173,'2012-4-4');
  INSERT INTO userTb1 VALUES('KKH','김경호',1971,'전남','010','33333333',177,'2007-7-7');
  INSERT INTO userTb1 VALUES('JYP','조용필',1950,'경기','010','44444444',166,'2009-4-4');
  INSERT INTO userTb1 VALUES('SSK','성시경',1979,'서울',NULL, NULL,186,'2013-12-12');
  INSERT INTO userTb1 VALUES('LJB','임재범',1963,'서울','010','66666666',182,'2009-9-9');
  INSERT INTO userTb1 VALUES('YJS','윤종신',1969,'경남',NULL, NULL,170,'2005-5-5');
  INSERT INTO userTb1 VALUES('EJW','은지원',1972,'경북','010','88888888',174,'2014-3-3');
  INSERT INTO userTb1 VALUES('JKW','조관우',1965,'경기','010','99999999',172,'2010-10-10');
  INSERT INTO userTb1 VALUES('BBK','바비킴',1973,'서울','010','00000000',176,'2013-5-5');
  INSERT INTO buyTb1 VALUES(NULL, 'KBS', '운동화',NULL,30,   2);
  INSERT INTO buyTb1 VALUES(NULL, 'KBS', '노트북','전자',1000,1);
  INSERT INTO buyTb1 VALUES(NULL, 'JYP', '모니터','전자',200, 1);
  INSERT INTO buyTb1 VALUES(NULL, 'BBK', '모니터','전자',200, 5);
  INSERT INTO buyTb1 VALUES(NULL, 'KBS', '청바지','의류',50,  3);
  INSERT INTO buyTb1 VALUES(NULL, 'BBK', '메모리','전자',80,  10);
  INSERT INTO buyTb1 VALUES(NULL, 'SSK', '책'   ,'서적',15,  10);
  INSERT INTO buyTb1 VALUES(NULL, 'EJW', '책'   ,'서적',15,  5);
  INSERT INTO buyTb1 VALUES(NULL, 'EJW', '청바지','의류',50,  1);
  INSERT INTO buyTb1 VALUES(NULL, 'BBK', '운동화',NULL,30,   2);
  INSERT INTO buyTb1 VALUES(NULL, 'EJW', '책'   ,'서적',15,  1);
  INSERT INTO buyTb1 VALUES(NULL, 'BBK', '운동화',NULL,30,  2);
  
  
  
  -- 테이블 조회
  -- 데이타 각각 10개씩 잘 들어갔는지 확인
  SELECT * FROM usertb1;
  SELECT * FROM byutb1;
  
  -- where 절로 조건에 맞는 레코드 출력하기
  -- SELECT 컬럼명1, 컬럼명2.. 또는 * fROM 테이블명 WHERE 조건절
  -- WHERE 조건절 : 비교연산자(>,<,=,>=,<=) 논리연산자(AND, OR, NOT)
  
  -- userTb1 테이블에서 김경호만 출력하기
  SELECT * FROM userTb1 WHERE name = '이승기';
  SELECT name, addr, userID FROM userTb1 WHERE name = '이승기';
  
  
  -- userTb1 테이블에서 birthYear 이 1970 보다 크거나 같고 hight 이 182 보다 크다
  -- WHERE 조건1 AND 조건2
  SELECT * FROM userTb1 WHERE birthYear >= 1970 AND height >= 182;
  
  -- userTb1 테이블에서 birthYear 이 1970 보다 이상이거나
  -- heghit 이 182보다 큰 레코드에서
  -- userID, Name 컬럼의 레코드 출력
  -- WHERE 조건1 OR 조건2 : 조건1이 만족하거나 조건2가 만족하는 레코드
  SELECT userID, Name FROM userTb1 WHERE birthYear >= 1970 OR height >= 182;
        
-- userTb1 테이블에서 height이 182미만인 레코드
SELECT userID, height FROM userTb1 WHERE NOT height>=182;

-- 범위를 지정할 때 사용 
-- WHERE 컬럼명 BETWEEN 값1 IN 값2
-- userTb1 테이블에서 height이 180~183 인 레코드에서 userID, Name 컬럼의 레코드 표시
SELECT * FROM userTb1 WHERE height >= 180 AND height <=183;

SELECT * FROM userTb1 WHERE height BETWEEN 180 AND 183;

-- 비연속적인 조건
-- 특정값 만족
-- WHERE 컬럼명 IN (값1, 값2 ...)  
SELECT * FROM usertb1 WHERE addr = '서울' OR addr = '경남';

SELECT * FROM usertb1 WHERE addr IN('서울','경남');

-- 특정글자로 끝나는가? 특정 글자로 시작하는가? %
-- 글자수 _(언더바)
-- 컬럼명안의 글자가 김으로 시작하는가?
-- WHERE 컬럼명 LIKE '김%'
-- 컬럼명안의 글자가 김으로 시작하고 나머지는 2글자
-- WHERE 컬럼명 LIKE '김__'

SELECT * FROM usertb1 WHERE name LIKE '임%';
SELECT * FROM usertb1 WHERE name LIKE '__기';
SELECT * FROM usertb1 WHERE name LIKE '_기';



-- 레코드 정렬
-- SELECT 문 ORDER BY 컬럼명;
-- SELECT 문 ORDER BY 컬럼명 DESC;
SELECT * FROM usertb1 ORDER BY name;	  -- 가나다순
SELECT * FROM usertb1 ORDER BY name DESC; -- 가나다 역순

-- LIMIT는 마지막에 지정
-- 가나다순으로 5개 출력
SELECT * FROM usertb1 ORDER BY name LIMIT 5;

-- WHERE 절은 ORDER BY 앞으로 
SELECT * FROM usertb1 WHERE height > 170 ORDER BY name; 

-- 주의사항! 키워드 순서 주의
-- SELECT .. FROM .. WHERE 절 ORDER BY .. LIMIT ..;


-- 서브 쿼리(Sub Query)란?
-- 쿼리문안에 쿼리문이 들어가는 것
-- SELECT.. FROM .. WHERE 조건절1
--		(SELECT .. FROM .. WHERE 조건절2)
-- 주의사항 : 서브쿼리의 레코드 결과값은 1개로 유일해야한다.

-- 김경호보다 키가 크거나 같은 사람의 이름과 키를 추출하여라.
-- 김경호의 키?

-- 김경호의 키값을 안다.
-- userTb1 테이블에서 height 컬럼값이 177이상인 레코드
SELECT * FROM userTBL WHERE height >= 177;

-- 김경호의 키값을 모른다.
-- step1 : 김경호의 키를 알 수 있는 쿼리 제작
SELECT height FROM userTb1 WHERE Name = '김경호';

-- step2 : 메인쿼리에 서브쿼리를 삽입
/* SELECT * FROM user TBL
	WHERE height > 김경호의 키값 */
SELECT * FROM usertb1
	WHERE height > (SELECT height FROM userTb1 WHERE Name = '김경호');

-- 서브쿼리가 에러가 나는 경우
SELECT * FROM usertb1 WHERE addr = '서울';

-- 주소지가 서울인 회원보다 키가 큰 사람
-- 에러 발생 : 서브쿼리의 결과가 2개 이상
SELECT * FROM usertb1
	WHERE height > (SELECT height FROM userTb1 WHERE addr ='서울');

-- 서브쿼리의 결과가 2개이상인 경우에는 서브쿼리()앞에 ANY 키워드 삽입
SELECT * FROM usertb1
	WHERE height > ANY(SELECT height FROM userTb1 WHERE addr ='서울');
    
-- 중복제거 : 레코드의 중복 제거
-- 컬럼명에서 중복제거한 후 표시
-- SELECT DISTINCT 컬럼명 FROM 테이블명;

SELECT * FROM usertb1;
-- userTBL 테이블에서 거주지 목록만 확인하기 (중복제거)
SELECT DISTINCT addr FROM userTb1;


/* 퀴즈
1) buyTb1 테이블에서 userID가 'KBS'인 레코드 출력하기
2) buyTb1 테이블에서 groupName이 NULL인 레코드 출력하기
3) buyTb1 테이블에서 amount가 5보다 큰 레코드 출력하기
4) buyTb1 테이블에서 prodName이 '청바지' 이거나 '운동화'인 레코드 출력하기
5) buyTb1 테이블에서 userID에 'K'로 시작하는 레코드 출력하기
6) buyTb1 테이블에서 prodName이 ??화로 끝나는 레코드 출력하기
7) buyTb1 테이블에서 가격이 50이상 항목 중 분류가 전자인 레코드 출력하기*/
-- 1)
 SELECT * FROM buyTb1 WHERE userID = 'KBS';
 -- 2) 
 SELECT * FROM buyTb1 WHERE groupName = NULL;
 -- 3)
  SELECT * FROM buyTb1 WHERE amount > 5 ;
  -- 4)
  SELECT * FROM buyTb1 WHERE prodName IN('청바지','운동화');
  -- 5)
  SELECT * FROM buytb1 WHERE userID LIKE 'K%';
  -- 6)
  SELECT * FROM buytb1 WHERE prodName LIKE '__화';
  -- 7)
  SELECT * FROM buytb1 WHERE price >= 50 AND groupName ='전자';
