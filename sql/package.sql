-- 사용자가 상품을 조회할 수 있다.
-- 모든 상품 조회
DELIMITER $$
CREATE OR REPLACE PROCEDURE getAllPackages()
BEGIN
    SELECT p.name, p.price, p.info, p.startDate,
           p.endDate, p.deadlineDate, a.name, cc.name
    FROM package p inner join cultureArea c on p.cultureArea = c.id
                   inner join areaCategory a on c.area = a.no
                   inner join cultureCategory cc on c.cultureCategory = cc.id;
END$$
DELIMITER ;

-- catogory 조회
DELIMITER $$
CREATE OR REPLACE PROCEDURE getPackagesByCategory(
    IN category varchar(10)
)
BEGIN
    SELECT p.name, p.price, p.info, p.startDate,
           p.endDate, p.deadlineDate, a.name, cc.name
    FROM package p inner join cultureArea c on p.cultureArea = c.id
    inner join areaCategory a on c.area = a.no
    inner join cultureCategory cc on c.cultureCategory = cc.id
    where cc.name like category;
END$$
DELIMITER ;

-- 지역 조회
DELIMITER $$
CREATE OR REPLACE PROCEDURE getPackagesByArea(
    IN area varchar(15)
)
BEGIN
    SELECT p.name, p.price, p.info, p.startDate,
           p.endDate, p.deadlineDate, a.name, cc.name
    FROM package p inner join cultureArea c on p.cultureArea = c.id
                   inner join areaCategory a on c.area = a.no
                   inner join cultureCategory cc on c.cultureCategory = cc.id
    where a.name like area;
END$$
DELIMITER ;



-- 판매자가 상품을 등록할 수 있다.
DELIMITER $$
CREATE OR REPLACE PROCEDURE createPackage(
    IN uid int,
    IN newCultureArea INT,
    IN packageName varchar(15),
    IN packagePrice int,
    IN packageInfo text,
    IN newStartDate DATETIME,
    IN newEndDate DATETIME,
    IN newDeadlineDate DATETIME

)
BEGIN
    insert into package(userId, cultureArea, name, 
    price, info, startDate, endDate, deadlineDate)
    values(uid, newCultureArea, packageName, packagePrice, 
    packageInfo, newStartDate, newEndDate, newDeadlineDate);
END$$
DELIMITER ;

-- 판매자가 대기,진행 상태인 상품을 수정할 수 있다.
-- 판매자가 진행, 확정, 만료인 상품을 삭제할 수 없다.
DELIMITER $$

DELIMITER $$

CREATE OR REPLACE PROCEDURE updatePackage(
    IN uid INT,                -- package의 id
    IN newCultureArea INT,     -- 새로운 문화 영역
    IN packageName VARCHAR(15), -- 새로운 패키지 이름
    IN packagePrice INT,       -- 새로운 가격
    IN packageInfo TEXT,       -- 새로운 패키지 정보
    IN newStartDate DATETIME,  -- 새로운 시작 날짜
    IN newEndDate DATETIME,    -- 새로운 종료 날짜
    IN newDeadlineDate DATETIME -- 새로운 마감 날짜
)
BEGIN
    -- BEGIN 블록의 가장 상단에서 변수 선언
    DECLARE sql_query TEXT DEFAULT '';
    DECLARE param_count INT DEFAULT 0;

    -- 기본 SQL 초기화
    SET sql_query = 'UPDATE package SET ';

    -- 조건부로 매개변수 추가
    IF newCultureArea IS NOT NULL THEN
        SET sql_query = CONCAT(sql_query, 'cultureArea = ', newCultureArea);
        SET param_count = param_count + 1;
    END IF;

    IF packageName IS NOT NULL THEN
        IF param_count > 0 THEN
            SET sql_query = CONCAT(sql_query, ', ');
        END IF;
        SET sql_query = CONCAT(sql_query, 'name = "', REPLACE(packageName, '"', '\"'), '"');
        SET param_count = param_count + 1;
    END IF;

    IF packagePrice IS NOT NULL THEN
        IF param_count > 0 THEN
            SET sql_query = CONCAT(sql_query, ', ');
        END IF;
        SET sql_query = CONCAT(sql_query, 'price = ', packagePrice);
        SET param_count = param_count + 1;
    END IF;

    IF packageInfo IS NOT NULL THEN
        IF param_count > 0 THEN
            SET sql_query = CONCAT(sql_query, ', ');
        END IF;
        SET sql_query = CONCAT(sql_query, 'info = "', REPLACE(packageInfo, '"', '\"'), '"');
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

    -- WHERE 조건 추가
    SET sql_query = CONCAT(sql_query, ' WHERE id = ', uid);

    -- 디버깅용 SQL 출력
    SELECT sql_query AS DebugSQL;

    -- 동적 SQL 실행
    PREPARE stmt FROM sql_query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;


-- 판매자가 대기 상태인 상품을 삭제할 수 있다.
DELIMITER $$
CREATE OR REPLACE PROCEDURE deletePackageBySeller(
    IN packageId INT
)
BEGIN
    -- 조건 확인: deadlineDate가 오늘 날짜보다 이전인지 확인
    IF (SELECT COUNT(*) FROM package WHERE id = packageId AND deadlineDate < CURDATE()) > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Cannot update. The deadlineDate is earlier than today.';
    END IF;
    
    delete from package
    where id = packageId;
END$$
DELIMITER ;

-- 부적절한 상품에 대해 관리자가 삭제 처리할 수 있다.
DELIMITER $$
CREATE OR REPLACE PROCEDURE deletePackageByManager(
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
    IN reportReason varchar(200)
)
BEGIN
    insert into report(reportingId, reported_user_id, reason)
    values(myId, otherId, reportReason);
END$$
DELIMITER ;
