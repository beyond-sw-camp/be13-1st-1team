
-- 찜 조회	사용자가 자신의 찜을 조회할 수 있다.
DELIMITER $$

CREATE OR REPLACE PROCEDURE GetUserLikes(IN p_userId INT)
BEGIN
    SELECT * 
    FROM `like`
    WHERE userId = p_userId;
END $$

DELIMITER ;

CALL GetUserLikes(1);

	


-- 찜 등록:	사용자가 진행중인 상품에 대해 찜을 등록할 수 있음		
DELIMITER $$

CREATE or replace PROCEDURE AddToLikes(IN p_userId INT, IN p_packageId INT)
BEGIN
    IF EXISTS (
		 	SELECT 1 
	      FROM package 
	      WHERE id = p_packageId AND deadlineDate >= NOW()
			) 
			THEN
		        INSERT INTO `like` (`userId`, `packageId`, `createdAt`)
		        VALUES (p_userId, p_packageId, NOW());
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '진행 및 확정 상태인 상품만 찜할 수 있습니다.';
    END IF;
END $$

DELIMITER ;

SELECT * FROM `like`;

CALL RemoveFromLikes(2, 10);

-- 찜 취소	사용자가 찜에 등록된 상품을 취소할 수 있다.		
DELIMITER $$

CREATE PROCEDURE RemoveFromLikes(IN p_userId INT, IN p_packageId INT)
BEGIN
    DELETE FROM `like` 
    WHERE `userId` = p_userId AND `packageId` = p_packageId;
END $$

DELIMITER ;

