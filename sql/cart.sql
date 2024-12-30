-- 장바구니 조회	사용자가 자신의 장바구니를 조회할 수 있다.			
DELIMITER $$

CREATE OR REPLACE PROCEDURE GetUserCart(
	IN p_userId INT
	)
BEGIN
    SELECT * 
    FROM cart
    WHERE userId = p_userId;
END $$

DELIMITER ;

CALL GetUserCart(2);


-- 등록사용자가 신청 마감일이 남아있는 패키지를  장바구니를 등록할 수 있다.
DELIMITER $$

CREATE or replace PROCEDURE AddToCart(IN p_userId INT, IN p_packageId INT)
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM package 
        WHERE id = p_packageId 
          AND deadlineDate >= NOW()
    ) THEN

        INSERT INTO `cart` (`userId`, `packageId`, `createdAt`)
        VALUES (p_userId, p_packageId, NOW());
    ELSE
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = '신청 마감일이 지난 상품은 장바구니에 추가할 수 없습니다.';
    END IF;
END $$

DELIMITER ;

CALL AddTocart(4, 10);
SELECT * FROM cart;
SELECT * FROM package;
-- 장바구니 삭제사용자가 등록된 장바구니 상품을 취소할 수 있다.			
DELIMITER $$

CREATE or replace PROCEDURE RemoveFromCart(IN p_userId INT, IN p_packageId INT)
BEGIN
    DELETE FROM `cart` 
    WHERE `userId` = p_userId AND `packageId` = p_packageId;
END $$

DELIMITER ;

CALL RemoveFromCart(4, 10);


-- 장바구니 삭제 	시스템이 이미 완료된 상품에 대해, 상품을 장바구니 취소 처리할 수 있다.			
DELIMITER $$

CREATE OR REPLACE PROCEDURE RemoveCompletedFromCart()
BEGIN
    DELETE FROM `cart` 
    WHERE `packageId` IN (SELECT `id` FROM `package` WHERE `deadlineDate` < NOW());
END $$

DELIMITER ;





