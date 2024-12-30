-- 판매자 리뷰 조회

DELIMITER $$
CREATE OR REPLACE PROCEDURE selectSellerReview()
BEGIN 
    SELECT * 
	 FROM sellerReview;
END$$
DELIMITER ;

-- 판매자 리뷰 등록
/**/
DELIMITER $$
CREATE OR REPLACE PROCEDURE createSellerReview(
IN _id INT,
IN _id2 INT,
IN _content TEXT,
IN _createAt TIMESTAMP CURDATE()
)
BEGIN
	 DECLARE _id INT;
	 DECLARE _id2 INT;
	 
	 SELECT user_id INTO _id FROM `order`;
	 SELECT order_id INTO _id2 FROM `user`;
	 		  
    INSERT INTO productReview(user_id, order_id, content, createAt)  
	 VALUES(_id, _id2, _content, _createAt);
END$$
DELIMITER ;


-- 판매자 리뷰 수정
DELIMITER $$
CREATE OR REPLACE PROCEDURE updateOneSellerReviewByUser_Id_Order_Id(
IN _id INT,
IN _content TEXT,
IN _updatedAt TIMESTAMP CURDATE()
)
BEGIN
	 DECLARE _id INT;
	 DECLARE _id2 INT;
	 
	 SELECT user_id INTO _id FROM `order`;
	 SELECT order_id INTO _id2 FROM `user`;
	 
    UPDATE sellerReview
    SET(
        _content = IFNULL(_content, content),
        _updatedAt = IFNULL(_updatedAt, updatedAt)
        )
    WHERE (user_id = _id AND order_id = _id2)
    ;
END $$
DELIMITER ;

-- 사용자가 판매자 리뷰 삭제
DELIMITER $$

CREATE OR REPLACE PROCEDURE deleteOneSellerReviewByUser_Id_Order_Id(
IN _user_id INT
IN _order_id INT
)
BEGIN
	 DELETE FROM sellerReview
    WHERE (user_id = _user_id AND order_id = _order_id)

END$$
DELIMITER ;

-- 관리자가 판매자 리뷰 삭제
DELIMITER $$

CREATE OR REPLACE PROCEDURE deleteOneSellerReview(
IN _id INT
)
BEGIN
	 DELETE FROM sellerReview
    WHERE id = _id

END$$
DELIMITER ;
