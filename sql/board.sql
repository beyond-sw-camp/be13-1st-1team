-- 게시판 조회

DELIMITER $$
CREATE OR REPLACE PROCEDURE selectBoard()
BEGIN 
    SELECT id AS '게시물 번호',
	 		  title AS '제목', 
	 		  content AS '내용',
			  createAt AS '생성일'
	 FROM board;
END$$
DELIMITER ;

-- 게시판 등록

DELIMITER $$
CREATE OR REPLACE PROCEDURE createBoard(
IN _id INT,
IN _title VARCHAR(15),
IN _content TEXT,
IN _tmpDist VARCHAR(1),
IN _createAt TIMESTAMP CURDATE()
)
BEGIN
	 DECLARE _id INT;

	 SELECT user_id INTO _id FROM `user`;
    INSERT INTO board(user_id, title, content, tmpDist, createAt)  
	 VALUES(_id, _title, _content, _tmpDist, _createAt);
END$$
DELIMITER ;

-- 게시판 임시 등록
DELIMITER $$
CREATE OR REPLACE PROCEDURE createBoard(
IN _id INT,
IN _title VARCHAR(15),
IN _content TEXT,
IN _tmpDist VARCHAR(1),
IN _createAt TIMESTAMP CURDATE()
)
BEGIN
	 DECLARE _id INT;
	 DECLARE _tmpDist VARCHAR(1);
	 
	 IF _tmpDist = 'N' THEN
	 	SELECT user_id INTO _id FROM `user`;
    	INSERT INTO board(user_id, title, content, tmpDist, createAt)  
	 	VALUES(_id, _title, _content, _tmpDist, _createAt);
	 
	 ELSE
		SELECT '임시 등록 합니다';
END$$
DELIMITER ;

-- 게시판 수정
DELIMITER $$
CREATE OR REPLACE PROCEDURE updateOneBoardByUser_Id(
IN _id INT,
IN _title VARCHAR(15),
IN _content TEXT,
IN _updatedAt TIMESTAMP CURDATE()
)
BEGIN
	 DECLARE _id INT;
	 SELECT user_id INTO _id FROM `user`;
	 
    UPDATE board
    SET(
    	  _title = IFNULL(_title, title)
        _content = IFNULL(_content, content),
        _updatedAt = IFNULL(_updatedAt, updatedAt)
        )
    WHERE user_id = _id
    ;
    
-- 사용자가 게시판 삭제
DELIMITER $$
CREATE OR REPLACE PROCEDURE deleteOneBoardByUser_Id(
IN _user_id INT
)
BEGIN
	 DELETE FROM board
    WHERE user_id = _user_id

END$$
DELIMITER ;

-- 게시판 신고
DELIMITER $$
CREATE OR REPLACE PROCEDURE reportOneBoardByUser_Id(

IN _reportingId INT,
IN _reported_user_id INT,
IN _reason VARCHAR(200),
IN _reportDist VARCHAR(1),
IN _createAt TIMESTAMP CURDATE()
)
BEGIN
	 DECLARE _reportingId INT;
	 DECLARE _reported_user_id INT;

	 SELECT user_id INTO _reportingId FROM `user`;
	 SELECT user_id INTO _reported_user_id FROM `user`;
	 
	
    INSERT INTO report(reportingId, reported_user_id, reason, reportDist, createAt)  
	 VALUES(_reportingId, _reported_user_id, _reason, _reportDist, _createAt);
END$$
DELIMITER ;


-- 관리자가 게시물 삭제
DELIMITER $$

CREATE OR REPLACE PROCEDURE deleteOneBoard(
IN _id INT
)
BEGIN
	 DELETE FROM Board
    WHERE id = _id

END$$
DELIMITER ;