-- 사용자가 상품을 조회할 수 있다.
-- 모든 상품 조회
DELIMITER $$
CREATE OR REPLACE PROCEDURE getAllPackages()
BEGIN
    SELECT p.name, p.price, p.info, p.startDate,
           p.endDate, p.deadlineDate, a.name, cc.name
    FROM package p inner join cultureArea c on p.cultureArea = c.id
                   inner join areaCategory a on c.area = a.no
                   inner join cultureCateory cc on c.cultureCategory = cc.id;
END$$
DELIMITER ;

-- catogory 조회
DELIMITER $$
CREATE OR REPLACE PROCEDURE getPackagesByCategory(
    IN category varchar
)
BEGIN
    SELECT p.name, p.price, p.info, p.startDate,
           p.endDate, p.deadlineDate, a.name, cc.name
    FROM package p inner join cultureArea c on p.cultureArea = c.id
    inner join areaCategory a on c.area = a.no
    inner join cultureCateory cc on c.cultureCategory = cc.id
    where cc.name like category;
END$$
DELIMITER ;

-- 지역 조회
DELIMITER $$
CREATE OR REPLACE PROCEDURE getPackagesByArea(
    IN area varchar
)
BEGIN
    SELECT p.name, p.price, p.info, p.startDate,
           p.endDate, p.deadlineDate, a.name, cc.name
    FROM package p inner join cultureArea c on p.cultureArea = c.id
                   inner join areaCategory a on c.area = a.no
                   inner join cultureCateory cc on c.cultureCategory = cc.id
    where a.name like area;
END$$
DELIMITER ;



-- 판매자가 상품을 등록할 수 있다.
DELIMITER $$
CREATE OR REPLACE PROCEDURE createPackage(
    IN uid int,
    IN packageName varchar,
    IN packagePrice int,
    IN packageInfo text
)
BEGIN
    insert into package(userId, name, price, info)
    values(uid, packageName, packagePrice, packageInfo);
END$$
DELIMITER ;

-- 판매자가 대기,진행 상태인 상품을 수정할 수 있다.
-- 판매자가 진행, 확정, 만료인 상품을 삭제할 수 없다.
DELIMITER $$

CREATE OR REPLACE PROCEDURE updatePackage(
    IN packageId INT,
    IN newCultureArea INT DEFAULT NULL,
    IN newName VARCHAR(255) DEFAULT NULL,
    IN newPrice INT DEFAULT NULL,
    IN newInfo TEXT DEFAULT NULL,
    IN newStartDate DATETIME DEFAULT NULL,
    IN newEndDate DATETIME DEFAULT NULL,
    IN newDeadlineDate DATETIME DEFAULT NULL
)
BEGIN
    -- 조건 확인: deadlineDate가 오늘 날짜보다 이전인지 확인
    IF (SELECT COUNT(*) FROM package WHERE id = packageId AND deadlineDate < CURDATE()) > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Cannot update. The deadlineDate is earlier than today.';
        RETURN; -- 조건이 만족하면 프로시저 종료
    END IF;

    -- 동적 SQL 쿼리를 저장할 변수 선언
    DECLARE sql_query TEXT;
    DECLARE param_count INT DEFAULT 0; -- 매개변수 개수를 카운트

    -- 기본 SQL 템플릿
    SET sql_query = 'UPDATE package SET ';

    -- 조건부로 매개변수 추가
    IF newCultureArea IS NOT NULL THEN
        SET sql_query = CONCAT(sql_query, 'cultureArea = ', newCultureArea);
        SET param_count = param_count + 1;
    END IF;

    IF newName IS NOT NULL THEN
        IF param_count > 0 THEN
            SET sql_query = CONCAT(sql_query, ', ');
        END IF;
        SET sql_query = CONCAT(sql_query, 'name = "', newName, '"');
        SET param_count = param_count + 1;
    END IF;

    IF newPrice IS NOT NULL THEN
        IF param_count > 0 THEN
            SET sql_query = CONCAT(sql_query, ', ');
        END IF;
        SET sql_query = CONCAT(sql_query, 'price = ', newPrice);
        SET param_count = param_count + 1;
    END IF;

    IF newInfo IS NOT NULL THEN
        IF param_count > 0 THEN
            SET sql_query = CONCAT(sql_query, ', ');
        END IF;
        SET sql_query = CONCAT(sql_query, 'info = "', newInfo, '"');
        SET param_count = param_count + 1;
    END IF;

    IF newStartDate IS NOT NULL THEN
        IF param_count > 0 THEN
            SET sql_query = CONCAT(sql_query, ', ');
        END IF;
        SET sql_query = CONCAT(sql_query, 'startDate = "', newStartDate, '"');
        SET param_count = param_count + 1;
    END IF;

    IF newEndDate IS NOT NULL THEN
        IF param_count > 0 THEN
            SET sql_query = CONCAT(sql_query, ', ');
        END IF;
        SET sql_query = CONCAT(sql_query, 'endDate = "', newEndDate, '"');
        SET param_count = param_count + 1;
    END IF;

    IF newDeadlineDate IS NOT NULL THEN
        IF param_count > 0 THEN
            SET sql_query = CONCAT(sql_query, ', ');
        END IF;
        SET sql_query = CONCAT(sql_query, 'deadlineDate = "', newDeadlineDate, '"');
        SET param_count = param_count + 1;
    END IF;

    -- WHERE 조건 추가 (packageId는 필수 매개변수)
    SET sql_query = CONCAT(sql_query, ' WHERE id = ', packageId);

    -- 동적 SQL 실행
    PREPARE stmt FROM sql_query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END $$;
DELIMITER ;

-- 판매자가 대기 상태인 상품을 삭제할 수 있다.
DELIMITER $$
CREATE OR REPLACE PROCEDURE deletePackage(
    IN packageId INT
)
BEGIN
    delete from package
    where id = packageId;
END$$
DELIMITER ;

-- 부적절한 상품에 대해 관리자가 삭제 처리할 수 있다.
DELIMITER $$
CREATE OR REPLACE PROCEDURE deletePackage(
    IN packageId INT
)
BEGIN
    delete from package
    where id = packageId;
END$$
DELIMITER ;

-- 사용자가 부적절한 상품에 대해 관리자에게 신고할 수 있다.
DELIMITER $$
CREATE OR REPLACE PROCEDURE createReport(
    IN myId int,
    IN otherId int,
    IN reportReason varchar
)
BEGIN
    insert into report(reportingId, reported_user_id, reason)
    values(myId, otherId, reportReason)
END$$
DELIMITER ;


-- 별도의 속성 없이 startDate, endDate, deadlineDate로 상품의 상태를 결정하므로,
-- 현재 상태에선 불가능함


-- 판매자가  확정된 상품에 대해 조기마감 처리를 할 수 있다.

-- 시스템에 의해 상품이 확정 처리 될 수 있다.


-- 시스템에 의해 상품이 만료 처리 될 수 있다.






