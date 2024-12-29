-- C
-- 등급 생성
-- CALL insertOneGrade(name);
DELIMITER $$
CREATE OR REPLACE PROCEDURE insertOneGrade(
    IN `_name` VARCHAR(3)
    )
BEGIN

    INSERT INTO grade (
        `name`
        )
    VALUES (
        _name
    )

END $$
DELIMITER ;

-- R
-- 등급 조회
-- CALL selectOneUser_gradeByUser_id(user_id);
DELIMITER $$
CREATE OR REPLACE PROCEDURE selectOneUser_gradeByUser_id(
    IN _user_id VARCHAR(15)
    )
BEGIN

    SELECT A.user_id AS '회원 아이디',
           B.`name` AS '등급명'
    FROM user A
    LEFT OUTER JOIN grade B
                 ON A.grade_id = B.id
    WHERE user_id = _user_id
    ;

END $$
DELIMITER ;


-- U
-- 관리자에 의한 회원 등급 수정 처리
-- CALL updateOneUser_grade_idByUser_id(user_id, grade_id);
DELIMITER $$
CREATE OR REPLACE PROCEDURE updateOneUser_grade_idByUser_id(
    IN _user_id VARCHAR(15),
       _grade_id INT
    )
BEGIN

    UPDATE user
    SET ( 
        grade_id = _grade_id
    )
    WHERE user_id = _user_id
    ;
    
END $$
DELIMITER ;

-- D