-- 주문 조회 사용자가 자신의 주문을 조회할 수 있다.		
DELIMITER $$

CREATE PROCEDURE GetUserOrders(IN p_userId INT)
BEGIN
    SELECT * 
    FROM `order`
    WHERE `userId` = p_userId;
END $$

DELIMITER ;

-- 주문 소비자가 주문을 진행 상태로 등록할 수 있다.	
DELIMITER $$

CREATE PROCEDURE CreateOrder(IN p_userId INT, IN p_packageId INT)
BEGIN
    INSERT INTO `order` (`userId`, `packageId`, `status`, `createdAt`)
    VALUES (p_userId, p_packageId, 1, NOW()); -- 상태 1은 '진행'
END $$

DELIMITER ;



-- 수정 주문자가 진행 상태인 주문을 수정할 수 있다.			
DELIMITER $$

CREATE PROCEDURE UpdateOrderStatusToInProgress(IN p_orderId INT, IN p_userId INT)
BEGIN
    IF EXISTS (SELECT 1 FROM `order` WHERE `id` = p_orderId AND `userId` = p_userId AND `status` = 1) THEN
        UPDATE `order` 
        SET `status` = 1, `updatedAt` = NOW() 
        WHERE `id` = p_orderId;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '주문 상태가 진행이 아닙니다.';
    END IF;
END $$

DELIMITER ;


--  주문자가 확정, 취소중이면 주문을 수정할 수 없다.			
DELIMITER $$

CREATE PROCEDURE UpdateOrderStatusToConfirmed(IN p_orderId INT, IN p_userId INT)
BEGIN
    IF EXISTS (SELECT 1 FROM `order` WHERE `id` = p_orderId AND `userId` = p_userId AND `status` = 2) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '확정 상태의 주문은 수정할 수 없습니다.';
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '주문 상태가 확정이 아닙니다.';
    END IF;
END $$

DELIMITER ;




-- 주문자가 진행중 주문을 결제하면 확정			
DELIMITER $$

CREATE PROCEDURE ConfirmOrder(IN p_orderId INT, IN p_userId INT)
BEGIN
    IF EXISTS (SELECT 1 FROM `order` WHERE `id` = p_orderId AND `userId` = p_userId AND `status` = 1 AND isPay = 'Y') THEN
        UPDATE `order` 
        SET `status` = 2, `updatedAt` = NOW() 
        WHERE `id` = p_orderId;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '주문 상태가 진행이 아닙니다.';
    END IF;
END $$

DELIMITER ;


-- 주문자가 진행중인 주문을 삭제할 수 있다.			
DELIMITER $$

CREATE PROCEDURE DeleteOrder(IN p_orderId INT, IN p_userId INT)
BEGIN
    IF EXISTS (SELECT 1 FROM `order` WHERE `id` = p_orderId AND `userId` = p_userId AND `status` = 1) THEN
        DELETE FROM `order` WHERE `id` = p_orderId;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '주문 상태가 대기가 아닙니다.';
    END IF;
END $$

DELIMITER ;


