-- 게시판 조회


DELIMITER $$
CREATE OR REPLACE PROCEDURE selectOneBoard(
IN _id INT
)

BEGIN 
    SELECT *
	 FROM board
	 WHERE id = _id;
END$$
DELIMITER ;
CALL selectBoard(1);


-- 게시판 전체 조회
DELIMITER $$
CREATE OR REPLACE PROCEDURE selectBoard()

BEGIN 
    SELECT *
	 FROM board;
	 
END$$
DELIMITER ;

CALL selectBoard();

SELECT * FROM board;

-- 게시판 등록
DELIMITER $$
CREATE OR REPLACE PROCEDURE createBoard(
IN _userId INT,
IN _title VARCHAR(15),
IN _content TEXT
)
BEGIN
		INSERT INTO board(userId, title, content)  
	 	VALUES(_userId, _title, _content);
	 	
END$$
DELIMITER ;

CALL createBoard(1,'제목', '내용df');
SELECT * FROM board;


-- 게시판 수정
DELIMITER $$
CREATE OR REPLACE PROCEDURE updateOneBoardByUser_Id(
IN _id INT,
IN _title VARCHAR(15),
IN _content TEXT

)
BEGIN
	
    UPDATE board
    SET title = _title,
        content = _content
    WHERE id = _id
    ;
    END$$
DELIMITER ;

CALL updateOneBoardByUser_Id(1, '제목1', '내용1');

SELECT * FROM board;
    
-- 사용자가 게시판 삭제
DELIMITER $$
CREATE OR REPLACE PROCEDURE deleteOneBoardByUser_Id(
IN _id INT
)
BEGIN
	 DELETE FROM board
    WHERE id = _id;

END$$
DELIMITER ;

CALL deleteOneBoardByUser_Id(1);
-- 게시판 신고
DELIMITER $$
CREATE OR REPLACE PROCEDURE reportOneBoardByUser_Id(

IN _reportingId INT,
IN _reported_user_id INT,
IN _reason VARCHAR(200),
IN _reportDist VARCHAR(1),
IN _createAt TIMESTAMP
)
BEGIN
	
    INSERT INTO report(reportingId, reported_user_id, reason, reportDist, createAt)  
	 VALUES(_reportingId, _reported_user_id, _reason, _reportDist, _createAt);
END$$
DELIMITER ;

CALL reportOneBoardByUser_Id(1, 2,
-- 관리자가 게시물 삭제
DELIMITER $$

CREATE OR REPLACE PROCEDURE deleteOneBoard(
IN _id INT
)
BEGIN
	 DELETE FROM Board
    WHERE id = _id;

END$$
DELIMITER ;
CALL deleteOneBoard(2);

CALL deleteOneBoard();