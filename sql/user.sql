-- C
-- 회원가입
-- CALL insertUser(userId, `name`, email, passwd, nickName, phoneNum, birthAt, national);
-- 모두 NOT NULL, 입력 필수
DELIMITER $$
CREATE OR REPLACE PROCEDURE insertUser(
    IN _userId VARCHAR(15),
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
        IF NOT EXISTS(SELECT userId 
                      FROM user 
                      WHERE userId = _userId 
                         OR email = _email
                         OR phoneNum = _phoneNum) THEN
        (
            INSERT INTO user (
                userId,
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
                _userId,
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
-- CALL insertCaution(userId, reason);
DELIMITER $$
CREATE OR REPLACE PROCEDURE insertCaution(
    IN _userId VARCHAR(15),
       _reason VARCHAR(200)
    )
BEGIN

    IF NOT EXISTS(
        SELECT * FROM user WHERE userId = _userId;
    )THEN(
        SELECT "아이디를 확인하세요" AS '인증 오류'
    )
    ELSE
    (
        INSERT INTO caution (
            userId,
            reason,
            updatedAt
            ) 
        VALUES (
            _userId,
            _reason,
            NULL
            )
        ;
    );

END $$
DELIMITER ;

-- 사업자 인증 신청
-- CALL insertBusiness(businessNum, name, userId)
DELIMITER $$
CRETAE OR REPLACE PROCEDURE insertBusiness(
    IN _businessNum VARCHAR(15),
       `_name` VARCHAR(15),
       _userId VARCHAR(15)
)
BEGIN

    INSERT INTO business (
        businessNum,
        `name`,
        updatedAt
    )
    VALUES(
        _businessNum,
        `_name`,
        NULL
    );

    DECLARE _businessId INT;
    SET _businessId = (SELECT id FROM business WHERE businessNum = _businessNum AND `name` = `_name`);

    UPDATE user
    SET (
        businessId = _businessId
    )
    WHERE userId = _userId;
        
END $$
DELIMITER ;


-- R
-- 모든 회원 조회
-- CALL selectUser();
DELIMITER $$
CREATE OR REPLACE PROCEDURE selectUser()
BEGIN

    SELECT id AS '아이디',
           userId AS '회원_아이디',
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
-- CALL selectOneUserByUserId(userId);
DELIMITER $$
CREATE OR REPLACE PROCEDURE selectOneUserByUserId(
    IN _userId VARCHAR(15)
    )
BEGIN

    SELECT id AS '아이디',
           userId AS '회원_아이디',
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
    WHERE userId = _userId
    ;

END $$
DELIMITER ;

-- 회원 정보 조회(전화번호)
-- CALL selectOneUserByPhoneNum(userId);
DELIMITER $$
CREATE OR REPLACE PROCEDURE selectOneUserByPhoneNum(
    IN _phonNum VARCHAR(15)
    )
BEGIN

    SELECT id AS '아이디',
           userId AS '회원_아이디',
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
    WHERE phoneNum = _phoneNum
    ;

END $$
DELIMITER ;

-- 로그인
-- CALL loginByUserId_passwd(userId, passwd);
-- 모두 입력 필수
DELIMITER $$
CREATE OR REPLACE PROCEDURE loginByUserId_passwd(
    IN _userId VARCHAR(15),
       _passwd VARCHAR(40)
    )
BEGIN

    SELECT IF(userId IS NULL, '로그인 실패', '로그인 성공') AS '로그인 결과'
    FROM user
    WHERE (userId = _userId
      AND passwd = _passwd
      )
    ;

END $$
DELIMITER ;

-- 아이디 찾기(이메일)
-- CALL selectOneUser_userIdByEmail(email);
-- 모두 입력 필수
DELIMITER $$
CREATE OR REPLACE PROCEDURE selectOneUser_userIdByEmail(
    IN _email VARCHAR(40)
    )
BEGIN

    SELECT IFNULL(userId, '등록된 아이디가 없습니다') AS '회원 아이디'
    FROM user
    WHERE (email = _email
      )
    ;

END $$
DELIMITER ;

-- 아이디 찾기(전화번호)
-- CALL selectOneUser_userIdByPhoneNum(phoneNum);
-- 모두 입력 필수
DELIMITER $$
CREATE OR REPLACE PROCEDURE selectOneUser_userIdByPhoneNum(
    IN _email VARCHAR(40),
       _phoneNum VARCHAR(15)
    )
BEGIN

    SELECT IFNULL(userId, '등록된 아이디가 없습니다') AS '회원 아이디'
    FROM user
    WHERE (phoneNum = _phoneNum
      )
    ;

END $$
DELIMITER ;

-- U
-- 비밀번호 변경
-- CALL updateOneUser_passwdByUserId(userId, passwd, updatePasswd);
-- 모두 입력 필수
-- updatePasswd 는 변경하려는 비밀번호
DELIMITER $$
CREATE OR REPLACE PROCEDURE updateOneUser_passwdByUserId(
    IN _userId VARCHAR(15),
       _passwd VARCHAR(40),
       _updatePasswd VARCHAR(40)
    )
BEGIN
    IF NOT EXISTS(
        SELECT * FROM user WHERE userId = _userId AND passwd = _passwd;
    )THEN(
        SELECT "아이디 또는 비밀번호를 확인하세요" AS '인증 오류'
    )
    ELSE
    (
        UPDATE user 
        SET passwd = _updatePasswd
        WHERE (userId = _userId
        AND passwd = _passwd
        )
    )
    ;

END $$
DELIMITER ;


-- 사업자 인증 권한 수정
-- CALL updateBusinessByBusinessNum(businessNum, certDist)
DELIMITER $$
CREATE OR REPLACE PROCEDURE updateBusinessByBusinessNum(
    IN _businessNum VARCHAR(15),
       _certDist VARCHAR(1)

)
BEGIN

    UPDATE business
    SET (
        certDist = _certDist,
        certedAt = CURDATE(),
        updatedAt = CURDATE())
    WHERE (businessNum = _businessNum);

END $$
DELIMITER ;


-- 개인정보 수정
-- CALL updateOneUserByUserId_passwd(userId, passwd, `name`, email, nickName, phoneNum, birthAt, national);
-- 지정하지 않는 정보는 기존 정보 그대로 저장
DELIMITER $$
CREATE OR REPLACE PROCEDURE updateOneUserByUserId_passwd(
    IN _userId VARCHAR(15),
       _passwd VARCHAR(40),
       `_name` VARCHAR(40),
       _email VARCHAR(40),
       _nickName VARCHAR(15),
       _phoneNum VARCHAR(15),
       _birthAt DATE,
       _national VARCHAR(15)
    )
BEGIN
    IF NOT EXISTS(
        SELECT * FROM user WHERE userId = _userId AND passwd = _passwd;
    )THEN(
        "아이디 또는 비밀번호를 확인하세요" AS '인증 오류'
    )ELSE(
        UPDATE user
    SET(
        `name` = IFNULL(_name, `name`),
        email = IFNULL(_email, email),
        nickName = IFNULL(_nickName, nickName),
        phoneNum = IFNULL(_phoneNum, phoneNum),
        birthAt = IFNULL(_birthAt, birthAt),
        national = IFNULL(_national, national)
        )
    WHERE (userId = _userId
      AND passwd = _passwd
      )
    ;
    )
    END IF;

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
-- CALL updateOneUser_expDistByUserId(userId, expDist, report_id);
-- report_id 지정하지 않을 시 NULL
DELIMITER $$
CREATE OR REPLACE PROCEDURE updateOneUser_expDistByUserId(
    IN _userId VARCHAR(15),
       _expDist VARCHAR(1),
       _report_id INT
    )
BEGIN

    UPDATE user
    SET (
        expDist = _expDist,
        report_id = IFNULL(_report_id, NULL)
    )
    WHERE userId = _userId
END $$
DELIMITER ;

-- D
-- 회원 탈퇴
-- CALL deleteOneUserByUserId(userId, passwd);
DELIMITER $$
CREATE OR REPLACE PROCEDURE deleteOneUserByUserId(
    IN _userId VARCHAR(15),
       _passwd VARCHAR(40)
    )
BEGIN
    IF NOT EXISTS(
        SELECT * FROM user WHERE userId = _userId AND passwd = _passwd;
    )THEN(
        "아이디 또는 비밀번호를 확인하세요" AS '인증 오류'
    )ELSE(
        DELETE FROM user
        WHERE (userId = _userId
        AND passwd = _passwd
        )
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

-- 회원 제적
-- TRIGGER updateOneUser_isExpelledBySystem
DELIMITER $$
CREATE OR REPLACE TRIGGER updateOneUser_isExpelledBySystem
AFTER INSERT ON caution
FOR EACH ROW
BEGIN

    DECLARE _userId INT;
    SET _userId = (SELECT userId FROM caution ORDER BY createdAt DESC LIMIT 1);

    IF(SELECT COUNT(*)
        FROM caution 
        WHERE userId = _userId >= 3)
    THEN(
        UPDATE user
        SET isExpelled = 'Y'
        WHERE userId = _userId;
    )

END $$
DELIMITER ;