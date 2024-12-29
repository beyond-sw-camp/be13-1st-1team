-- C
-- 회원가입
-- CALL insertUser(user_id, `name`, email, passwd, nickName, phoneNum, birthAt, national);
-- 모두 NOT NULL, 입력 필수
DELIMITER $$
CREATE OR REPLACE PROCEDURE insertUser(
    IN _user_id VARCHAR(15),
       `_name` VARCHAR(15),
       _email VARCHAR(40),
       _passwd VARCHAR(40),
       _nickname VARCHAR(15),
       _phoneNum VARCHAR(15),
       _birthAt DATE,
       _national VARCHAR(15),
       )
    BEGIN

        -- 회원 아이디 중복 방지 조건문
        IF((SELECT user_id FROM user WHERE user_id = _user_id) IS NULL) THEN
        (
            INSERT INTO user (
                user_id,
                `name`,
                email,
                passwd,
                nickName,
                phoneNum,
                birthAt,
                national,
                updatedAt
                )
            VALUES (
                _user_id,
                `_name`,
                _email,
                _passwd,
                _nickname,
                _phoneNum,
                _birthAt,
                _national,
                NULL
                )
            ;
        )
        ELSE
            (
                SELECT '이미 존재하는 회원 아이디입니다.';
            )
        END IF;

    END $$
DELIMITER ;

-- 회원 경고 생성
-- CALL insertCaution(user_id, reason);
DELIMITER $$
CREATE OR REPLACE PROCEDURE insertCaution(
    IN _user_id VARCHAR(15),
       _reason VARCHAR(200)
    )
BEGIN

    INSERT INTO caution (
        user_id,
        reason,
        updatedAt
        ) 
    VALUES (
        _user_id,
        _reason,
        NULL
        )
    ;

END $$
DELIMITER ;

-- R
-- 모든 회원 조회
-- CALL selectUser();
DELIMITER $$
CREATE OR REPLACE PROCEDURE selectUser()
BEGIN

    SELECT id AS '아이디',
           user_id AS '회원_아이디',
           grade_id AS '등급_아이디',
           role_id AS '역할_아이디',
           `name` AS '이름',
           email AS '이메일',
           nickName AS '닉네임',
           phoneNum AS '전화번호',
           birthAt AS '생년월일',
           national AS '국적',
           createdAt AS '생성일',
           updatedAt AS '수정일',
           expDist AS '제적여부',
           business_id AS '사업자정보_아이디'
    FROM user
    ;

END $$
DELIMITER ;

-- 회원 정보 조회
-- CALL selectOneUserByUser_id(user_id);
DELIMITER $$
CREATE OR REPLACE PROCEDURE selectOneUserByUser_id(
    IN _user_id VARCHAR(15)
    )
BEGIN

    SELECT id AS '아이디',
           user_id AS '회원_아이디',
           grade_id AS '등급_아이디',
           role_id AS '역할_아이디',
           `name` AS '이름',
           email AS '이메일',
           nickName AS '닉네임',
           phoneNum AS '전화번호',
           birthAt AS '생년월일',
           national AS '국적',
           createdAt AS '생성일',
           updatedAt AS '수정일',
           expDist AS '제적여부',
           business_id AS '사업자정보_아이디'
    FROM user
    WHERE user_id = _user_id
    ;

END $$
DELIMITER ;

-- 로그인
-- CALL loginByUser_id_passwd(user_id, passwd);
-- 모두 입력 필수
DELIMITER $$
CREATE OR REPLACE PROCEDURE loginByUser_id_passwd(
    IN _user_id VARCHAR(15),
       _passwd VARCHAR(40)
    )
BEGIN

    SELECT IF(user_id IS NULL, '로그인 실패', '로그인 성공') AS '로그인 결과'
    FROM user
    WHERE (user_id = _user_id
      AND passwd = _passwd
      )
    ;

END $$
DELIMITER ;

-- 아이디 찾기
-- CALL selectOneUserByEmail_phoneNum(email, phoneNum);
-- 모두 입력 필수
DELIMITER $$
CREATE OR REPLACE PROCEDURE selectOneUserByEmail_phoneNum(
    IN _email VARCHAR(40),
       _phoneNum VARCHAR(15)
    )
BEGIN

    SELECT IFNULL(user_id, '등록된 아이디가 없습니다') AS '회원 아이디'
    FROM user
    WHERE (email = _email
      AND phoneNum = _phoneNum
      )
    ;

END $$
DELIMITER ;

-- U
-- 비밀번호 변경
-- CALL updateOneUserByUser_id(user_id, passwd, updatePasswd);
-- 모두 입력 필수
-- updatePasswd 는 변경하려는 비밀번호
DELIMITER $$
CREATE OR REPLACE PROCEDURE updateOneUserByUser_id(
    IN _user_id VARCHAR(15),
       _passwd VARCHAR(40),
       _updatePasswd VARCHAR(40)
    )
BEGIN

    UPDATE user 
    SET passwd = _updatePasswd
    WHERE (user_id = _user_id
      AND passwd = _passwd
      )
    ;

END $$
DELIMITER ;

-- 정보 수정
-- CALL updateOneUserByUser_id_passwd(user_id, passwd, `name`, email, nickName, phoneNum, birthAt, national);
-- 지정하지 않는 정보는 기존 정보 그대로 저장
DELIMITER $$
CREATE OR REPLACE PROCEDURE updateOneUserByUser_id_passwd(
    IN _user_id VARCHAR(15),
       _passwd VARCHAR(40),
       `_name` VARCHAR(40),
       _email VARCHAR(40),
       _nickName VARCHAR(15),
       _phoneNum VARCHAR(15),
       _birthAt DATE,
       _national VARCHAR(15)
    )
BEGIN

    UPDATE user
    SET(
        `name` = IFNULL(_name, `name`),
        email = IFNULL(_email, email),
        nickName = IFNULL(_nickName, nickName),
        phoneNum = IFNULL(_phoneNum, phoneNum),
        birthAt = IFNULL(_birthAt, birthAt),
        national = IFNULL(_national, national)
        )
    WHERE (user_id = _user_id
      AND passwd = _passwd
      )
    ;

END $$
DELIMITER ;

-- 회원 경고 사유 수정
-- CALL updateOneCautionById(id, reason);
DELIMITER $$
CREATE OR REPLACE PROCEDURE updateOneCautionById(
    IN _id INT,
       _reason VARCHAR()
    )
BEGIN

    UPDATE caution
    SET (
        reason = _reason
        )
    WHERE id = _id
    ;

END $$
DELIMITER ;

-- 회원 제적
-- CALL updateOneUser_expDistByUser_id(user_id, expDist, report_id);
-- report_id 지정하지 않을 시 NULL
DELIMITER $$
CREATE OR REPLACE PROCEDURE updateOneUser_expDistByUser_id(
    IN _user_id VARCHAR(15),
       _expDist VARCHAR(1),
       _report_id INT
    )
BEGIN

    UPDATE user
    SET (
        expDist = _expDist,
        report_id = IFNULL(_report_id, NULL)
    )
    WHERE user_id = _user_id
END $$
DELIMITER ;

-- D
-- 회원 탈퇴
-- CALL deleteOneUserByUser_id(user_id, passwd);
DELIMITER $$
CREATE OR REPLACE PROCEDURE deleteOneUserByUser_id(
    IN _user_id VARCHAR(15),
       _passwd VARCHAR(40)
    )
BEGIN

    DELETE FROM user
    WHERE (user_id = _user_id
      AND passwd = _passwd
      )
    ;

END $$
DELIMITER ;

-- 회원 경고 삭제
-- CALL deleteOneCautionById(id);
DELIMITER $$
CREATE OR REPLACE PROCEDURE deleteOneCautionById(
    IN _id INT
    )
BEGIN

    DELETE FROM caution
    WHERE id = _id
    ;

END $$
DELIMITER ;