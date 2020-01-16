-- 조인이란?
-- 두개이상의 테이블을 서로 묶어서 관리하는 기능

-- 조인의 종류
-- 내부 조인
-- 외부 조인
-- 크로스 조인
-- 셀프 조인

USE sqldb;
-- 테이블 구조 확인
-- 외래키(foreign key) 확인
-- buytb1에서 외래키가 userID인지 확인
-- 외래키는 Key값이 MUL로 표시
DESC buytb1; 
DESC usertb1;


-- INNER JOIN 1 --
-- SELECT * 또는 컬럼명
--  	FROM 테이블1
-- 		  INNER JOIN 테이블2
-- 			ON 조인될조건-테이블1.컬럼명 = 테이블2.컬럼명 이용
-- 			(서로 공통된 관계의 컬럼 이용)
-- 		[WHERE 조건절];

-- 구매 이력이 있는 모든 레코드가 출력
-- 구매 이력이 없는 레코드는 표시되지 않는다. => 아우터조인으로 해결 가능
-- userID 컬럼명이 2번 표시
SELECT * 
 	FROM buytb1
	  INNER JOIN usertb1
		ON buytb1.userID = usertb1.userID;
-- JYP 회원의 레코드 정보만 출력
SELECT * 
 	FROM buytb1
	  INNER JOIN usertb1
		ON buytb1.userID = usertb1.userID
   WHERE buytb1.userID = 'JYP';

-- 명확하게 컬럼명 표시하기
-- 테이블명.컬럼명으로 나열
-- userID, prodName, amount, addr, name
SELECT 
	buytb1.userID AS '아이디', buytb1.prodName AS '상품명', 
    buytb1.amount AS '수량', usertb1.addr AS '지역', usertb1.name AS '이름'
 	FROM buytb1
	  INNER JOIN usertb1
		ON buytb1.userID = usertb1.userID;

-- 테이블명에 별칭
-- SELECT 별칭.컬럼명
--  	FROM 테이블1 [별칭1]
-- 		  INNER JOIN 테이블2 [별칭2]
-- 			ON 조인될조건-별칭1.컬럼명 = 별칭2.컬럼명 이용
-- 			(서로 공통된 관계의 컬럼 이용)
-- 		[WHERE 조건절];
SELECT 
	B.userID AS '아이디', B.prodName AS '상품명', 
    B.amount AS '수량', U.addr AS '지역', U.name AS '이름'
 	FROM buytb1 B
	  INNER JOIN usertb1 U
		ON B.userID = U.userID;

-- 퀴즈
-- 2개의 테이블을 조인하여 아래와 같이 표시되게 만들어보세요.
/*
구매금액 = 수량 * 가격
아이디 이름 지역 상품명 수량 가격 구매금액 
 ?	  ?   ?   ?   ?   ?    ?
*/
SELECT 
	B.userID AS '아이디', U.name AS '이름', U.addr AS '지역', 
    B.prodName AS '상품명', B.amount AS '수량', B.price AS '가격',
    FORMAT(B.amount * B.price,0) AS '구매금액'
 	FROM buytb1 B
	  INNER JOIN usertb1 U
		ON B.userID = U.userID;

-- 3개의 테이블 조인하기 p 270
-- 학생(stdTbl), 학생동아리(stdclubTbl), 동아리(clubTbl)
USE sqlDB;

-- 학생(stdTbl) 테이블 생성
DROP TABLE IF EXISTS sdtTbl;
CREATE TABLE stdTbl
	( stdName VARCHAR(10) NOT NULL PRIMARY KEY,
	  addr		CHAR(4) NOT NULL
);

DESC stdTbl;

-- 동아리(clubTbl) 테이블 생성
DROP TABLE IF EXISTS clubTbl;
CREATE TABLE clubTbl
	( clubName VARCHAR(10) NOT NULL PRIMARY KEY,
	  roomNo	CHAR(4) NOT NULL
);

DESC clubTbl;

-- 학생동아리(stdclubTbl) 테이블생성
-- 외래키 설정
-- FOREIGN KEY(컬럼명) REFERENCES 외부테이블명(컬럼명)
DROP TABLE IF EXISTS stdclubTbl;
CREATE TABLE stdclubTbl
	( num INT AUTO_INCREMENT PRIMARY KEY,
	  stdName VARCHAR(10) NOT NULL,
      clubName VARCHAR(10) NOT NULL,
FOREIGN KEY(stdName) REFERENCES stdTbl(stdName),
FOREIGN KEY(clubName) REFERENCES clubTbl(clubName)
);

DESC stdclubTbl;

-- INSERT IGNORE INTO : 
INSERT INTO stdTbl 
		VALUES ('김범수','경남'),('성시경','서울'),('조용필','경기'),
				('은지원','경북'),('바비킴','서울');
INSERT INTO clubTbl 
		VALUES ('수영','101호'),('바둑','102호'),('축구','103호'),('봉사','104호');
INSERT INTO stdclubTbl 
		VALUES (NULL,'김범수','바둑'),(NULL,'김범수','축구'),(NULL,'조용필','축구'),
				(NULL,'은지원','축구'),(NULL,'은지원','봉사'),(NULL,'바비킴','봉사');

SELECT count(*) FROM stdTbl ;
SELECT count(*) FROM clubTbl ;
SELECT count(*) FROM stdclubTbl ;

-- 3개의 INNER JOIN
-- 학생(stdTble)과 학생동아리(stdclubTbl) 테이블에서
-- 학생동아리(stdclubTbl)와 동아리(clubTbl) 테이블에서
-- 학생을 기준으로 학생이름/지역/가입동아리/동아리 이름 출력
SELECT S.stdName, S.addr, C.clubName, C.roomNo
	FROM stdTbl S
		INNER JOIN stdclubTbl SC
			ON S.stdName = SC.stdName
		INNER JOIN clubTbl C
			ON SC.clubName = C.clubName
	ORDER BY S.stdName;

-- 퀴즈
-- 위의 3개의 테이블을 아래와 같은 포맷으로 출력하여라
/*
학생이름 | 동아리(방호수)
김범수	바둑 - 102호
*/
-- CONCAT(문자열1, 문자열2 ...) : 여러개의 문자열 한번에 표시
-- SELECT CONCAT(문자열자료형인컬럼1,문자열자료형인컬럼2)
SELECT SC.stdName AS '학생이름', 
		CONCAT(C.clubName,'-', C.roomNo) AS '동아리(방호수)'
	FROM clubTbl C
		INNER JOIN stdclubTbl SC
			ON SC.clubName = C.clubName
		ORDER BY SC.stdName;

-- p 273
-- 아우터조인(OUTER JOIN) 
-- 이너조인과 차이점
-- 	: 조인의 조건에 만족되지 않는 행까지도 포함하여 레코드 표시
-- LEFT OUTER JOIN
-- RIGHT OUTER JOIN
-- UNION

-- SELECT * 또는 컬럼명(테이블명.컬럼명 또는 별칭.컬럼명 ...)
--  	FROM 테이블1 [별칭1]
-- 			<LEFT 또는 RIGHT> OUTER JOIN 테이블명2 [별칭2]
-- 				ON 조인될 조건 (테이블명1.컬럼명 = 테이블명2.컬럼명)
-- 		[WHERE 절]

-- 회원테이블과 구매테이블 OUTER JOIN으로 모두 표시
-- 구매 이력이 없는 회원 레코드도 함께 표시
SELECT *
	FROM userTb1 U
		LEFT OUTER JOIN buyTb1 B
			ON U.userID = B.userID
		ORDER BY U.userID;

SELECT 
	U.userID AS '아이디', U.name AS '이름', B.prodName AS '제품명', U.addr AS '지역',
    CONCAT(U.mobile1, U.mobile2) AS '연락처'
	FROM userTb1 U
		LEFT OUTER JOIN buyTb1 B
			ON U.userID = B.userID
		ORDER BY U.userID;

-- 구매경험이 없는 회원 목록만 출력하기
-- WHERE B.prodNAme IS NULL
SELECT 
	U.userID AS '아이디', U.name AS '이름', B.prodName AS '제품명', U.addr AS '지역',
    CONCAT(U.mobile1, U.mobile2) AS '연락처'
	FROM userTb1 U
		LEFT OUTER JOIN buyTb1 B
			ON U.userID = B.userID
		WHERE B.prodName IS NULL
        ORDER BY U.userID;
-- 구매이력이 없는 회원수?
SELECT 
	count(*) AS '구매이력이 없는 회원 수'
	FROM userTb1 U
		LEFT OUTER JOIN buyTb1 B
			ON U.userID = B.userID
		WHERE B.prodName IS NULL
        ORDER BY U.userID;

-- 구매이력이 있는 회원수의 레코드개수?
SELECT 
	count(*) AS '구매이력이 있는 회원 수'
	FROM userTb1 U
		LEFT OUTER JOIN buyTb1 B
			ON U.userID = B.userID
		WHERE B.prodName IS NOT NULL
        ORDER BY U.userID;

-- 3개의 OUTER JOIN
-- 학생(stdTbl)과 학생동아리(stdclubTbl) 테이블에서 LEFT OUTER JOIN
-- 학생동아리와 동아리(clubTbl) 테이블에서 LEFT OUTER JOIN
-- 학생을 기준으로 학생이름/지역/가입동아리/동아리이름 출력
SELECT S.stdName AS '학생이름', S.addr AS '지역', SC.clubName AS '가입동아리'
	FROM stdTbl S
		LEFT OUTER JOIN stdclubTbl SC
			ON S.stdName = SC.stdName
		LEFT OUTER JOIN clubTbl C
			ON SC.clubName = C.clubName;

-- 동아리에 가입하지않은 학생 목록과 학생수를 출력하여라
SELECT  S.stdName AS '동아리에 가입하지 않은 회원명',
		count(S.stdName) AS '동아리에 가입하지않은 학생 목록과 학생수'
	FROM stdTbl S
		LEFT OUTER JOIN stdclubTbl SC
			ON S.stdName = SC.stdName
		LEFT OUTER JOIN clubTbl C
			ON SC.clubName = C.clubName
	WHERE SC.clubName IS NULL;

-- UNION 명령으로 2개의 OUTER JOIN 합하기

SELECT S.stdName AS '학생이름', S.addr AS '지역', SC.clubName AS '가입동아리', C.roomNo AS '호수'
	FROM stdTbl S
		LEFT OUTER JOIN stdclubTbl SC
			ON S.stdName = SC.stdName
		LEFT OUTER JOIN clubTbl C
			ON SC.clubName = C.clubName
UNION
SELECT S.stdName AS '학생이름', S.addr AS '지역', SC.clubName AS '가입동아리', C.roomNo AS '호수'
	FROM stdTbl S
		LEFT OUTER JOIN stdclubTbl SC
			ON S.stdName = SC.stdName
		RIGHT OUTER JOIN clubTbl C
			ON SC.clubName = C.clubName;














