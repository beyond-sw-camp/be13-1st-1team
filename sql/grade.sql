-- TRIGGER
-- 등급 부여
-- TRIGGER insertOneGradeBySystem
DELIMITER $$
CREATE OR REPLACE TRIGGER insertOneGradeBySystem
AFTER UPDATE ON business
FOR EACH ROW
BEGIN

    DECLARE _userId VARCHAR(15);
    SET _userId = (SELECT userId FROM user WHERE businessId = NEW.id);

    IF(NEW.certDist = 'Y'
    )THEN
        UPDATE user
        SET gradeId = 3
        WHERE (
            userId = _userId);
    END IF;

END $$
DELIMITER ;

-- 등급 수정
-- TRIGGER updateOneGradeBySystem
DELIMITER $$
CREATE OR REPLACE TRIGGER updateOneGradeBySystem
AFTER INSERT ON package
FOR EACH ROW
BEGIN

    DECLARE _cnt INT;
    SET _cnt = (SELECT COUNT(*)
                FROM package
                WHERE userId = NEW.userId);

    IF( _cnt >= 50) -- 골드
    THEN
        UPDATE user
        SET gradeId = 1
        WHERE id = NEW.userId;
    ELSEIF(_cnt >= 20) -- 실버
    THEN 
        UPDATE user
        SET gradeId = 2
        WHERE id = NEW.userId;
    ELSEIF(_cnt >= 5) -- 브론즈
    THEN
        UPDATE user
        SET gradeId = 3
        WHERE id = NEW.userId;
    END IF;
    
END $$
DELIMITER ;

-- C

-- R
-- 등급 조회
-- CALL selectOneUser_GradeByUserId(userId)
DELIMITER $$
CREATE OR REPLACE PROCEDURE selectOneUser_GradeByUserId(
    IN _userId VARCHAR(15)
    )
BEGIN

    DECLARE _cnt INT;
	SET _cnt = (SELECT COUNT(*) 
                FROM user 
                WHERE userId = _userId);

    IF (
        _cnt >= 1 
    )THEN
        SELECT A.userId AS '회원 아이디',
            IFNULL(B.`name`, '등급 없음') AS '등급명'
        FROM user A
        LEFT OUTER JOIN grade B
                    ON A.gradeId = B.id
        WHERE userId = _userId
        ;
    ELSE
        SELECT '아이디를 확인해주세요' AS '조회 오류';
    END IF;

END $$
DELIMITER ;


-- U
-- 관리자에 의한 회원 등급 수정 처리
-- CALL updateOneUser_gradeIdByUserId(userId, gradeId);
DELIMITER $$
CREATE OR REPLACE PROCEDURE updateOneUser_gradeIdByUserId(
    IN _userId VARCHAR(15),
       _gradeId INT
    )
BEGIN

   DECLARE _cnt INT;
	SET _cnt = (SELECT COUNT(*) 
                FROM user 
                WHERE userId = _userId);

    IF (
        _cnt >= 1 
    )THEN
        UPDATE user
        SET gradeId = _gradeId
        WHERE userId = _userId;
   ELSE
   	SELECT '아이디를 확인해주세요' AS '조회 오류';
   END IF;
    
END $$
DELIMITER ;

-- D