-- 변수 생성과 출력
-- p.234
USE sqldb;

-- SET @변수명 = 초기값;
-- SELECT @변수명;

SET @a = 1;
SET @b = 10;
SET @c = 'my SQL';
SET @d = 'sqlLite';

-- 출력
SELECT @a, @b, @c, @d;
SELECT @a, @b, @a+@b,@a*@b;
SELECT @c, @d, @c+@d;

-- 테이블과 변수 함께 사용하기
SELECT * FROM usertb1;

SET @deco = '***';
SELECT @deco;
SELECT userID AS '아이디', @deco AS '', addr AS '지역' FROM usertb1;

/* 퀴즈1
usertb1 테이블에서 키가 180 넘는 레코드만 추출한 후
아래와 같은 형태로 출력하여라

	      이름	키
가수이름 => 김경호   ?  cm
가수이름 => 이승기   ?  cm
*/

SET @singerName = '가수이름 =>';
SET @cm = 'cm';

SELECT @singerName AS '', name AS 이름, height AS'키', @cm AS'' FROM usertb1 WHERE height >= 180;


-- 데이터 형변환 CASTING
-- p 236
/*
CAST ( ... AS 데이타형식 )
CONVERT ( ... AS 데이타형식 )

데이텨 형식 : 
 BINARY, CHAR(), DATE, TIME,
 SIGNED INTEGER, UNSIGNED INTEGER
*/

USE sqldb;
-- 평균구매 개수가 실수 => 정수
SELECT * FROM buytb1;
-- 실수형으로 결과값 리턴
SELECT AVG(amount) AS '평균 구매 개수' FROM buytb1;
-- 양의 정수형으로 결과값 리턴
SELECT CAST(AVG(amount) AS SIGNED INTEGER) AS '평균 구매 개수' FROM buytb1;
-- 또는
SELECT CONVERT(AVG(amount) , SIGNED INTEGER) AS '평균 구매 개수' FROM buytb1;

-- 실수형숫자 => 문자
SELECT CAST( 23.5 AS CHAR(10) );
-- 문자 => 양의 정수 ..... 문자 뒤로는 날라가고 그 앞에 있는 숫자만 찍힘
SELECT CAST( '2nd' AS SIGNED INTEGER );
SELECT CAST( '2nd123' AS SIGNED INTEGER );


-- 날짜 자료형 종류
-- p 232
-- DATE, TIME, DATETIME 

-- 문자열 => 날짜형
SELECT CAST('2020-12-12' AS DATE) AS DATE;
SELECT CAST('2019-12-25 12:12:12' AS DATETIME);
SELECT CAST('12:12:12' AS TIME) AS TIME;

-- 현재 시간과 날짜 출력
-- now() : 내장함수로 현재의 날짜와 시간을 표시
SELECT now(),
	   CAST(now() AS DATE) AS '등록 날짜',
	   CAST(now() AS TIME) AS '등록 시간';

-- 여러 문자열을 하나의 문자열로 표시
-- p 241
-- CONCAT() 함수와 함께 사용
-- CONCAT(EXP...) : 문자열을 함께 출력할 때 사용
-- CONCAT_WS(구분자, 문자열1, 문자열2 ...) : 문자열을 구분자와 함께 표시

SET @userName ='슈가';
SELECT CONCAT('거기 누구 없소...', '--이하이') AS '결과';
SELECT CONCAT('거기 누구 없소...', @userName) AS '결과';
SELECT CONCAT_WS('/','방탄소년단','블랙핑크','레드벨벳') AS '아이돌 그룹';


-- 보기좋은 출력
-- 단가 x 수량 = 입금액


-- 적용전 --
SELECT * FROM buyTb1;

SELECT 
	num, price AS '가격',
	amount AS '수량',
    price*amount AS '구매액' -- 새로 추가된 컬럼명
    FROM buytb1
    LIMIT 5;

-- CONCAT() 이용하여 하나의 컬럼에 2개의 컬럼값 표시
SELECT num,
	CONCAT( CAST(price AS CHAR(7)), 'x',
			CAST(amount AS CHAR(7)), '=') AS '단가 x 수량',
            price * amount AS '구매액'
            FROM buyTb1;


/* 퀴즈2 - CONCAT() 활용
usertb1 테이블에서 키가 175 넘는 레코드만 추출한 후
아래와 같은 형태로 출력하여라

	      이름	키
가수이름 => 김경호   ?  cm
가수이름 => 이승기   ?  cm
*/

SELECT  
		CONCAT( '가수이름 => ', name) AS '이름',
        -- 문자열로 형변환 후 CONCAT() 적용
		CONCAT(CAST(height AS CHAR(5)),' cm') AS '키'
        FROM userTb1 
        WHERE height >= 175;


-- 제어흐름 함수
-- p 239

-- IF (수식, 참, 거짓)
-- 수식1이 NULL 이면 수식2가 반환, 그렇지 않으면 수식 1이 반환
SELECT IF (100>200, '참이다','거짓이다') AS '결과값';

SELECT * FROM usertb1;
-- 지역이 서울인 회원의 키 합계
SELECT 
	 SUM(IF(addr='서울', height, 0)) AS '서울지역 키 합계',
	 AVG(IF(addr='서울', height, 0)) AS '서울지역 키 평균'
     FROM usertb1;

-- p 258 피벗 테이블 스타일 --
-- 피벗이란? 테이블에서 필요한 자료만 추출해서 새로운 테이블로 작성하는 기능
CREATE TABLE pivotTest
	(uName CHAR(3),
     season CHAR(2),
     amount INT);

INSERT INTO pivotTest VALUES
		('김범수', '겨울', 10),	('김범수', '가을', 25),	('김범수', '봄', 3),('김범수', '봄', 37),
	    ('운종신', '겨울', 40),	('운종신', '여름', 15),	('운종신', '여름', 64),('김범수', '여름', 14),	('김범수', '겨울', 22);
	SELECT * FROM pivotTest;

-- IF 문을 이용하여 컬럼 재구성
-- 봄, 여름, 가을, 겨울, 총합계
SELECT uName,
	SUM(IF(season='봄', amount,0)) AS '봄'
	 FROM pivotTest GROUP BY uName;

-- uName, 봄 컬럼의 목록만 추출
SELECT uName,
	SUM(IF(season='봄', amount,0)) AS '봄',
	SUM(IF(season='여름', amount,0)) AS '여름',
	SUM(IF(season='가을', amount,0)) AS '가을',
	SUM(IF(season='겨울', amount,0)) AS '겨울',
	SUM(amount) AS '합계' 
    FROM pivotTest GROUP BY uName;


-- IF NULL(수식1, 수식2)
-- 수식1이 NULL 이면 수식2가 반환, 그렇지않으면 수식1이 반환
-- 결과값 : 널이군요, 100
SELECT IFNULL(NULL, '널이군요'), IFNULL(100,'널이군요');

-- NULL IF(수식1, 수식2)
-- 수식1과 수식2가 같으면 NULL반환, 수식1과 수식2가 같지 않으면 수식1 반환
-- 결과값 : NULL, 200
SELECT NULLIF(100,100), NULLIF(200,100);


-- CASE .. WHEN .. ELSE .. END
-- 다중 분기시 사용
/*
CASE 값:
	WHEN 값1 THEN 결과값1
	WHEN 값2 THEN 결과값2
	..
    ELSE ..
END;
*/

SELECT CASE 10
			WHEN 1  THEN '일'
			WHEN 5  THEN '오'
			WHEN 10 THEN '십'
			ELSE '모름'
		END;


-- 문자열 함수 --
-- p 241
SELECT 
	ELT(2, '하나','둘','셋'), 		 -- 둘 
    FIELD('둘','하나','둘','셋'),	 -- 2 
    Find_in_set('둘','하나,둘.셋'), -- 2 
    INSTR('하나둘셋','둘'),			 -- 3 
    LOCATE('둘','하나둘셋');		 -- 3 
    
/*
-- ELT(위치인덱스, 문자열1, 문자열2...)
	: 위치인덱스에 관련된 문자열 반환
    : 인덱스는 1부터 시작
-- FIELD(찾고자하는문자열, 문자열1, 문자열2 ...)
	: 찾고자하는 문자열과 같은 문자열의 위치 반환
    : 인덱스는 1부터 시작
-- FIND_IN_SET(찾고자하는문자열, 문자열리스트)
	: 문자열 리스트에서 위치 반환, 문자열리스트는 공백없이 콤마로 구분
-- INSTR(문자열그룹, 부분문자열)
-- LOCATE(부분문자열, 문자열그룹)
	: 문자열그룹에서 문자열의 시작위치인덱스값 반환
*/


/*
FORMAT(실수형숫자, 소숫점자리)
	: 실수형숫자에서 소숫점자리수까지 반환
	: 3자리마다 쉼표(,)를 자동으로 표시
*/
SELECT FORMAT(123456.123456, 2) AS 'R1', 
	   FORMAT(123456.123456, 0) AS 'R2';

-- 2진수, 8진수, 16진수 표시
SELECT BIN(31), HEX(31), OCT(31);

/*
INSERT(문자열, 위치, 길이, 대체문자열)
문자열의 위치에서부터 길이만큼 삭제 후 대체문자열로 표시
*/
SELECT INSERT('abcdefghi',3,4,'@@@@'),
	   INSERT('abcdefghi',2,4,'@@@@');

/* 공백 삭제 */
SELECT LTRIM('	이것이'), RTRIM('이것이		');
SELECT TRIM('	이것이	');

/* 문자열 반복 */
SELECT REPEAT('SQL',3);

       
-- 문자열 교체
-- REPLACE(문자열, 찾고자하는문자열, 교체문자열)
SELECT REPLACE('이것이 MySQL이다.','이것이','This is');

-- SPACE(공백숫자) : 공백지정
-- CONCAT() 안에 주로 삽입
SELECT CONCAT('이것이', SPACE(10), 'My SQL이다');


-- **** 수학함수
-- 올림, 내림, 반올림
SELECT ceiling(4.7), floor(4.7), round(4.7);

-- RAND() : 0 ~ 1 사이의 실수값
-- 난수값으 범위 정하기
-- RAND() * (end합수값 -1) + end시작값
SELECT RAND();
SELECT RAND()*(6-1)+1;

-- 1 ~ 6 사이의 주사위 숫자 만들기
-- 난수 실수형 => 정수형
SELECT ceiling(RAND()*6);


-- 날짜와 시간함수
-- 현재 날짜와 시간, 날짜, 시간표시
-- now() 날짜와 시간
-- curdate() 날짜
-- curtime() 시간
SELECT now(), curdate(), curtime();
-- 년도, 월, 일 따로 출력
-- year(curdate()), day(curdate())
SELECT  year(curdate()) AS '년도', 
		month(curdate()) AS '월',
        monthname(curdate()) AS '월',
        day(curdate()) AS '날짜',
        dayname(curdate()) AS '날짜';
-- 시, 분, 초 따로 출력
SELECT  hour(curtime()) AS '시',
		minute(curtime()) AS '분',
        second(curtime()) AS '초';
        
-- 테이블의 데이터로 오늘 날짜 삽입하기
DROP TABLE IF EXISTS bbsTBL;
CREATE TABLE bbsTBL
			(num INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
             userID char(10) NOT NULL, 
             regDate DATETIME,
             title VARCHAR(30) NOT NULL,
             contents TEXT NOT NULL) ;
             
DESC bbsTBL; -- 테이블 구조 확인

INSERT INTO bbsTBL VALUES 
			(NULL,'봉봉', now(), '기생충','아직 모름'),
			(NULL,'자스민', now(), '알라딘','애니매이션'),
			(NULL,'스파이디', now(), '스파이더맨','액션');
            
SELECT * FROM bbsTBL;


-- 퀴즈 풀기
-- db 폴더에서 sql_quiz1.sql 다운로드
-- mySQL 폴더에서 다운로드 받은 파일 열기
-- DB 변경 후 풀기
-- USE employees
        
        
        