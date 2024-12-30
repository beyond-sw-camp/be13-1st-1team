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
	IN _content TEXT
)
BEGIN 
	--  SELECT orderId INTO _id FROM `order`;
	--  SELECT userId INTO _id2 FROM `user`;
	 		  
    INSERT INTO sellerReview(userId, orderId, content)  
	 VALUES(_id, _id2, _content);
END$$
DELIMITER ;


-- 판매자 리뷰 수정
DELIMITER $$
CREATE OR REPLACE PROCEDURE updateOneSellerReviewByUser_Id_Order_Id(
	IN _id INT,
	IN _id2 INT,
	IN _content TEXT
)
BEGIN

	--  SELECT user_id INTO _id FROM `order`;
	--  SELECT order_id INTO _id2 FROM `user`;
	 
    UPDATE sellerReview
	set content = _content
    WHERE (userId = _id AND orderId = _id2);
END $$
DELIMITER ;

-- 사용자가 판매자 리뷰 삭제
DELIMITER $$

CREATE OR REPLACE PROCEDURE deleteOneSellerReviewByUser_Id_Order_Id(
	IN _user_id INT,
	IN _order_id INT
)
BEGIN
	DELETE FROM sellerReview
    WHERE userId = _user_id AND orderId = _order_id;

END$$
DELIMITER ;

-- 관리자가 판매자 리뷰 삭제
DELIMITER $$

CREATE OR REPLACE PROCEDURE deleteOneSellerReview(
	IN _id INT
)
BEGIN
	 DELETE FROM sellerReview
    WHERE id = _id;

END$$
DELIMITER ;
