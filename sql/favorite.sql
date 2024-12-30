

-- 즐겨찾기 조회

DELIMITER $$
CREATE OR REPLACE PROCEDURE selectFavorite(
IN _user_id INT
)
BEGIN 
    SELECT *
	 FROM favorite
	 WHERE userId = `_user_id`;
END$$
DELIMITER ;
call selectFavorite(2);



-- 즐겨찾기 등록        
DELIMITER $$

CREATE OR REPLACE PROCEDURE createFavorite(
    IN _userId INT
)
BEGIN
    -- 'user' 테이블에서 _userId 존재 여부 확인
    IF EXISTS(
        SELECT 1
        FROM `user` u
        JOIN favorite f ON u.id = f.userId
        WHERE u.`id` = _userId AND usertype = 3
    ) THEN
        -- 존재하면 favorite 테이블에 데이터 삽입
        INSERT INTO favorite(userid, createdAt)
        VALUES (_userId, NOW());
    ELSE
        -- 존재하지 않으면 오류 발생
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User not found';
    END IF;
END $$

DELIMITER ;


CALL createFavorite(2);
SELECT * FROM favorite ;

SELECT * FROM user;


-- 즐겨찾기 삭제
DELIMITER $$
CREATE OR REPLACE PROCEDURE deleteOneFavoriteByUser_Id(
IN _user_id INT
)
BEGIN
	 DELETE FROM favorite
    WHERE userId = _user_id;

END$$
DELIMITER ;
SELECT * FROM favorite;
CALL deleteOneFavoriteByUser_Id(3);