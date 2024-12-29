
-- 장바구니 조회	사용자가 자신의 장바구니를 조회할 수 있다.			
DELIMITER $$

CREATE PROCEDURE GetUserCart(IN p_userId INT)
BEGIN
    SELECT * 
    FROM `cart`
    WHERE `userId` = p_userId;
END $$

DELIMITER ;

-- 장바구니 등록사용자가 진행 상태인 상품에 대해 장바구니를 등록할 수 있다.
DELIMITER $$

CREATE PROCEDURE AddToCart(IN p_userId INT, IN p_packageId INT)
BEGIN
    IF EXISTS (SELECT 1 FROM `order` WHERE `packageId` = p_packageId AND `status` = 1) THEN
        INSERT INTO `cart` (`userId`, `packageId`, `createdAt`)
        VALUES (p_userId, p_packageId, NOW());
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '진행 상태인 상품만 장바구니에 추가할 수 있습니다.';
    END IF;
END $$

DELIMITER ;
			
-- 장바구니 삭제사용자가 등록된 장바구니 상품을 취소할 수 있다.			
ELIMITER $$

CREATE PROCEDURE RemoveFromCart(IN p_userId INT, IN p_packageId INT)
BEGIN
    DELETE FROM `cart` 
    WHERE `userId` = p_userId AND `packageId` = p_packageId;
END $$

DELIMITER ;

-- 장바구니 삭제 	시스템이 이미 완료된 상품에 대해, 상품을 장바구니 취소 처리할 수 있다.			
DELIMITER $$

CREATE PROCEDURE RemoveCompletedFromCart()
BEGIN
    DELETE FROM `cart` 
    WHERE `packageId` IN (SELECT `id` FROM `package` WHERE `endDate` <= NOW());
END $$

DELIMITER ;



