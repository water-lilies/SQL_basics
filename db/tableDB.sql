-- SQL을 이용한 테이블 생성 
USE tableDB;

-- 외래키로 연결되어 있어서 함께 삭제해야함 
DROP TABLE IF EXISTS buyTbl, userTbl;

CREATE TABLE userTbl 
( userID  char(8) NOT NULL PRIMARY KEY, 
  name    varchar(10) NOT NULL, 
  birthYear   int NOT NULL,  
  addr	  char(2) NOT NULL,
  mobile1	char(3) NULL, 
  mobile2   char(8) NULL, 
  height    smallint NULL, 
  mDate    date NULL 
);
DESC usertbl;


CREATE TABLE buyTbl 
(  num int AUTO_INCREMENT NOT NULL PRIMARY KEY , 
   userid  char(8) NOT NULL, 	
   prodName char(6) NOT NULL,
   groupName char(4) NULL , 
   price     int  NOT NULL,
   amount    smallint  NOT NULL 
  , FOREIGN KEY(userid) REFERENCES userTbl(userID)
);
DESC buyTbl;

-- 데이타 삽입 userTbl
INSERT INTO userTbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO userTbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO userTbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
SELECT * FROM userTbl;

-- 데이타 삽입 buyTbl
INSERT INTO buyTbl VALUES(NULL, 'KBS', '운동화', NULL, 30, 2);
INSERT INTO buyTbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);

SELECT * FROM userTbl;
SELECT * FROM buyTbl;
