-- 즐겨찾기 조회

DELIMITER $$
CREATE OR REPLACE PROCEDURE selectFavorite()
BEGIN 
    SELECT id AS '즐겨찾기',
   		  createAt AS '생성일'
	 FROM favorite;
END$$
DELIMITER ;

-- 즐겨찾기 등록

DELIMITER $$
CREATE OR REPLACE PROCEDURE createFavorite(
IN _id INT,
IN _createAt TIMESTAMP CURDATE()
)
BEGIN
	 DECLARE _id INT;
	 SELECT user_id INTO _id FROM `user`;
    INSERT INTO favorite(user_id, createAt)  
	 VALUES(_id, _createAt);
END$$
DELIMITER ;

-- 즐겨찾기 삭제
DELIMITER $$
CREATE OR REPLACE PROCEDURE deleteOneFavoriteByUser_Id(
IN _user_id INT
)
BEGIN
	 DELETE FROM favorite
    WHERE user_id = _user_id

END$$
DELIMITER ;