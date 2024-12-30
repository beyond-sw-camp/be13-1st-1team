-- 상품 리뷰 조회

DELIMITER $$
CREATE OR REPLACE PROCEDURE selectPackageReview()
BEGIN 
    SELECT * 
	 FROM packageReview;
END$$
DELIMITER ;

-- 상품 리뷰 등록

DELIMITER $$
CREATE OR REPLACE PROCEDURE createPackageReview(
IN _id INT,
IN _content TEXT
)
BEGIN
    INSERT INTO packageReview(orderId, content)  
	 VALUES(_id,_content);
END$$
DELIMITER ;

-- 상품 리뷰 수정
DELIMITER $$
CREATE OR REPLACE PROCEDURE updateOnePackageReviewByOrder_Id(
IN _id INT,
IN _content TEXT
)
BEGIN
	UPDATE packageReview
    SET content = _content
    WHERE orderId = _id
	 ;
END $$
DELIMITER ;


-- 사용자가 상품 리뷰 삭제
DELIMITER $$

-- 주문 아이디
CREATE OR REPLACE PROCEDURE deleteOnePackageReviewByUser_Id(
    IN reviewOrderId INT
)
BEGIN
	 DELETE FROM packageReview WHERE orderId = reviewOrderId;

END$$
DELIMITER ;


-- 관리자가 상품 리뷰 삭제
DELIMITER $$

CREATE OR REPLACE PROCEDURE deleteOnePackageReview(
    IN reviewId INT
)
BEGIN
	 DELETE FROM packageReview WHERE id = reviewId;

END$$
DELIMITER ;

