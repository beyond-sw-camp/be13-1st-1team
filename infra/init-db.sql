-- 데이터베이스 생성
CREATE DATABASE test_db;

-- 데이터베이스 선택
USE test_db;

-- 실습 테이블 및 데이터 삽입
DROP TABLE IF EXISTS userTbl;
DROP TABLE IF EXISTS buyTbl;

-- 교재 실습 테이블 및 테스트 데이터 삽입
-- 회원 테이블
CREATE TABLE userTbl ( 
    userID  	CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
    name    	VARCHAR(10) NOT NULL, -- 이름
    birthYear   	INT NOT NULL,  -- 출생년도
    addr	  	CHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
    mobile1	CHAR(3), -- 휴대폰의 국번(011, 016, 017, 018, 019, 010 등)
    mobile2	CHAR(8), -- 휴대폰의 나머지 전화번호(하이픈제외)
    height    	SMALLINT,  -- 키
    mDate    	DATE  -- 회원 가입일    
);

-- 회원 구매 테이블
CREATE TABLE buyTbl (  
    num 		INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
    userID  	CHAR(8) NOT NULL, -- 아이디(FK)
    prodName 	CHAR(6) NOT NULL, --  물품명
    groupName 	CHAR(4)  , -- 분류
    price     	INT  NOT NULL, -- 단가
    amount    	SMALLINT  NOT NULL, -- 수량
    FOREIGN KEY (userID) REFERENCES userTbl(userID) -- 외래키 지정
);

-- 회원 데이터, 구매 데이터 삽입
INSERT INTO userTbl VALUES('LSG', N'이승기', 1987, N'서울', '011', '11111111', 182, '2008-8-8');
INSERT INTO userTbl VALUES('KBS', N'김범수', 1979, N'경남', '011', '22222222', 173, '2012-4-4');
INSERT INTO userTbl VALUES('KKH', N'김경호', 1971, N'전남', '019', '33333333', 177, '2007-7-7');
INSERT INTO userTbl VALUES('JYP', N'조용필', 1950, N'경기', '011', '44444444', 166, '2009-4-4');
INSERT INTO userTbl VALUES('SSK', N'성시경', 1979, N'서울', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO userTbl VALUES('LJB', N'임재범', 1963, N'서울', '016', '66666666', 182, '2009-9-9');
INSERT INTO userTbl VALUES('YJS', N'윤종신', 1969, N'경남', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO userTbl VALUES('EJW', N'은지원', 1972, N'경북', '011', '88888888', 174, '2014-3-3');
INSERT INTO userTbl VALUES('JKW', N'조관우', 1965, N'경기', '018', '99999999', 172, '2010-10-10');
INSERT INTO userTbl VALUES('BBK', N'바비킴', 1973, N'서울', '010', '00000000', 176, '2013-5-5');
INSERT INTO buyTbl VALUES(NULL, 'KBS', N'운동화', NULL   , 30,   2);
INSERT INTO buyTbl VALUES(NULL, 'KBS', N'노트북', N'전자', 1000, 1);
INSERT INTO buyTbl VALUES(NULL, 'JYP', N'모니터', N'전자', 200,  1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', N'모니터', N'전자', 200,  5);
INSERT INTO buyTbl VALUES(NULL, 'KBS', N'청바지', N'의류', 50,   3);
INSERT INTO buyTbl VALUES(NULL, 'BBK', N'메모리', N'전자', 80,  10);
INSERT INTO buyTbl VALUES(NULL, 'SSK', N'책'    , N'서적', 15,   5);
INSERT INTO buyTbl VALUES(NULL, 'EJW', N'책'    , N'서적', 15,   2);
INSERT INTO buyTbl VALUES(NULL, 'EJW', N'청바지', N'의류', 50,   1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', N'운동화', NULL   , 30,   2);
INSERT INTO buyTbl VALUES(NULL, 'EJW', N'책'    , N'서적', 15,   1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', N'운동화', NULL   , 30,   2);

-- 데이터베이스 생성
CREATE DATABASE employees_db;

-- 데이터베이스 선택
USE employees_db;

-- 실습 테이블 및 데이터 삽입
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS job;
DROP TABLE IF EXISTS location;
DROP TABLE IF EXISTS national;
DROP TABLE IF EXISTS sal_grade;

--  DDL for Table DEPARTMENT
CREATE TABLE department (	
   dept_id CHAR(2) PRIMARY KEY, 
   dept_title VARCHAR(35) NOT NULL,
   location_id CHAR(2)
);

INSERT INTO department VALUES ('D1','인사관리부', 'L1');
INSERT INTO department VALUES ('D2','회계관리부', 'L1');
INSERT INTO department VALUES ('D3','마케팅부', 'L1');
INSERT INTO department VALUES ('D4','국내영업부', 'L1');
INSERT INTO department VALUES ('D5','해외영업1부', 'L2');
INSERT INTO department VALUES ('D6','해외영업2부', 'L3');
INSERT INTO department VALUES ('D7','해외영업3부', 'L4');
INSERT INTO department VALUES ('D8','기술지원부', 'L5');
INSERT INTO department VALUES ('D9','총무부', 'L1');

--  DDL for Table JOB
CREATE TABLE job (	
   job_code CHAR(2) PRIMARY KEY, 
	job_name VARCHAR(35) NOT NULL
);

INSERT INTO job(job_code,job_name) VALUES ('J1','대표');
INSERT INTO job(job_code,job_name) VALUES ('J2','부사장');
INSERT INTO job(job_code,job_name) VALUES ('J3','부장');
INSERT INTO job(job_code,job_name) VALUES ('J4','차장');
INSERT INTO job(job_code,job_name) VALUES ('J5','과장');
INSERT INTO job(job_code,job_name) VALUES ('J6','대리');
INSERT INTO job(job_code,job_name) VALUES ('J7','사원');

--  DDL for Table EMPLOYEE
CREATE TABLE employee (	
    emp_id CHAR(3) PRIMARY KEY, 
	emp_name VARCHAR(20) NOT NULL, 
	emp_no CHAR(14) NOT NULL, 
	email VARCHAR(25), 
	phone VARCHAR(12), 
	dept_code CHAR(2), 
	job_code CHAR(2), 
	salary INT, 
	bonus DOUBLE, 
	manager_id VARCHAR(3), 
	hire_date DATE, 
	ent_date DATE, 
	ent_yn CHAR(1) DEFAULT 'N'
) ;

INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('200','선동일','621235-1985634','sun_di@kh.or.kr','01099546325','D9','J1',8000000,0.3,null,'90/02/06',null,'N');
INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('201','송종기','631156-1548654','song_jk@kh.or.kr','01045686656','D9','J2',6000000,null,'200','01/09/01',null,'N');
INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('202','노옹철','861015-1356452','no_hc@kh.or.kr','01066656263','D9','J2',3700000,null,'201','01/01/01',null,'N');
INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('203','송은희','631010-2653546','song_eh@kh.or.kr','01077607879','D6','J4',2800000,null,'204','96/05/03',null,'N');
INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('204','유재식','660508-1342154','yoo_js@kh.or.kr','01099999129','D6','J3',3400000,0.2,'200','00/12/29',null,'N');
INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('205','정중하','770102-1357951','jung_jh@kh.or.kr','01036654875','D6','J3',3900000,null,'204','99/09/09',null,'N');
INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('206','박나라','630709-2054321','pack_nr@kh.or.kr','01096935222','D5','J7',1800000,null,'207','08/04/02',null,'N');
INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('207','하이유','690402-2040612','ha_iy@kh.or.kr','01036654488','D5','J5',2200000,0.1,'200','94/07/07',null,'N');
INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('208','김해술','870927-1313564','kim_hs@kh.or.kr','01078634444','D5','J5',2500000,null,'207','04/04/30',null,'N');
INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('209','심봉선','750206-1325546','sim_bs@kh.or.kr','0113654485','D5','J3',3500000,0.15,'207','11/11/11',null,'N');
INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('210','윤은해','650505-2356985','youn_eh@kh.or.kr','0179964233','D5','J7',2000000,null,'207','01/02/03',null,'N');
INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('211','전형돈','830807-1121321','jun_hd@kh.or.kr','01044432222','D8','J6',2000000,null,'200','12/12/12',null,'N');
INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('212','장쯔위','780923-2234542','jang_zw@kh.or.kr','01066682224','D8','J6',2550000,0.25,'211','15/06/17',null,'N');
INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('213','하동운','621111-1785463','ha_dh@kh.or.kr','01158456632',null,'J6',2320000,0.1,null,'99/12/31',null,'N');
INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('214','방명수','856795-1313513','bang_ms@kh.or.kr','01074127545','D1','J7',1380000,null,'200','10/04/04',null,'N');
INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('215','대북혼','881130-1050911','dae_bh@kh.or.kr','01088808584','D5','J5',3760000,null,null,'17/06/19',null,'N');
INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('216','차태연','770808-1364897','cha_ty@kh.or.kr','01064643212','D1','J6',2780000,0.2,'214','13/03/01',null,'N');
INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('217','전지연','770808-2665412','jun_jy@kh.or.kr','01033624442','D1','J6',3660000,0.3,'214','07/03/20',null,'N');
INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('218','이오리','870427-2232123','loo_or@kh.or.kr','01022306545',null,'J7',2890000,null,null,'16/11/28',null,'N');
INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('219','임시환','660712-1212123','im_sw@kh.or.kr',null,'D2','J4',1550000,null,null,'99/09/09',null,'N');
INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('220','이중석','770823-1113111','lee_js@kh.or.kr',null,'D2','J4',2490000,null,null,'14/09/18',null,'N');
INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('221','유하진','800808-1123341','yoo_hj@kh.or.kr',null,'D2','J4',2480000,null,null,'94/01/20',null,'N');
INSERT INTO employee(emp_id,emp_name,emp_no,email,phone,dept_code,job_code,salary,bonus,manager_id,hire_date,ent_date,ent_yn) VALUES ('222','이태림','760918-2854697','lee_tr@kh.or.kr','01033000002','D8','J6',2436240,0.35,'100','97/09/12','17/09/12','Y');

--  DDL for Table location
CREATE TABLE location (
	local_code CHAR(2) PRIMARY KEY,
	national_code CHAR(2),
	local_name VARCHAR(40) NOT NULL
);

INSERT INTO location VALUES 
('L1', 'KO', 'ASIA1'),
('L2', 'JP', 'ASIA2'),
('L3', 'CH', 'ASIA3'),
('L4', 'US', 'AMERICA'),
('L5', 'RU', 'EU');

--  DDL for Table national
CREATE TABLE `national` (
	`national_code` CHAR(2) PRIMARY KEY,
	`national_name` VARCHAR(35) NOT NULL
);

INSERT INTO `national` VALUES 
('KO', '한국'),
('JP', '일본'),
('CH', '중국'),
('US', '미국'),
('RU', '러시아');

--  DDL for Table sal_grade
CREATE TABLE sal_grade (
	sal_level CHAR(2) PRIMARY KEY,
	min_sal INT,
	max_sal INT
);

INSERT INTO sal_grade VALUES
('S1', 6000000, 10000000),
('S2', 5000000, 5999999),
('S3', 4000000, 4999999),
('S4', 3000000, 3999999),
('S5', 2000000, 2999999),
('S6', 1000000, 1999999);
