-- 상품 리뷰 조회

DELIMITER $$
CREATE OR REPLACE PROCEDURE selectProductReview()
BEGIN 
    SELECT * 
	 FROM productReview;
END$$
DELIMITER ;

-- 상품 리뷰 등록

DELIMITER $$
CREATE OR REPLACE PROCEDURE createProductReview(
IN _id INT,
IN _content TEXT,
IN _createAt TIMESTAMP CURDATE()
)
BEGIN
	 DECLARE _id INT;
	 SELECT order_id INTO _id FROM `order`;
    INSERT INTO productReview(order_id, content, createAt)  
	 VALUES(_id,_content, _createAt);
END$$
DELIMITER ;

-- 상품 리뷰 수정
DELIMITER $$
CREATE OR REPLACE PROCEDURE updateOneProductReviewByOrder_Id(
IN _id INT,
IN _content TEXT,
IN _updatedAt TIMESTAMP CURDATE()
)
BEGIN
	 DECLARE _id INT;
	 
	 SELECT order_id INTO _id FROM `user`;
	 
    UPDATE productReview
    SET(
        _content = IFNULL(_content, content),
        _updatedAt = IFNULL(_updatedAt, updatedAt)
        )
    WHERE order_id = _id
	 ;
END $$
DELIMITER ;


-- 사용자가 상품 리뷰 삭제
DELIMITER $$

CREATE OR REPLACE PROCEDURE deleteOneProductReviewByUser_Id(
IN _user_id INT
)
BEGIN
	 DELETE FROM productreview
    WHERE user_id = _user_id

END$$
DELIMITER ;


-- 관리자가 상품 리뷰 삭제
DELIMITER $$

CREATE OR REPLACE PROCEDURE deleteOneProductReview(
IN _id INT
)
BEGIN
	 DELETE FROM productReview
    WHERE id = _id

END$$
DELIMITER ;

