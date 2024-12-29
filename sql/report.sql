-- 관리자가 접수된 신고를 조회할 수 있다.
-- 처리가 안된 신고만 볼 수 있도록 프로시저 생성
DELIMITER $$
CREATE OR REPLACE PROCEDURE getNewReport()
BEGIN
    SELECT *
    FROM report
    WHERE reportDist = 'N';
END$$
DELIMITER ;

-- 관리자가 신고를 접수한 유저에게 메신저로 결과를 알릴 수 있다.
-- 메신저 테이블이 음슴 ㅠ


-- 관리자가 신고된 내용에 따라 합당한 처분을 내릴 수 있다.
-- 신고 테이블 수정(신고 사유) -> 경고 테이블 추가
DELIMITER $$
CREATE OR REPLACE PROCEDURE createNewCaution(
    IN reportId int, -- 신고 id
    IN userId int, -- 사용자 id
    IN result TEXT, -- 신고 처리 결과
    IN cautionReason varchar -- 경고 사유
)
BEGIN
    -- 신고 처리 결과 수정
    update report
    set reportResult = result
    where id = reportId;

    -- 경고 테이블 추가(user_id, reason)
    insert into caution(user_id, reason)
    values (userId, cautionReason);

END$$
DELIMITER ;

-- 신고 테이블 수정(기각)
DELIMITER $$
CREATE OR REPLACE PROCEDURE rejectReport(
    IN reportId int, -- 신고 id
    IN result TEXT -- 신고 처리 결과
)
BEGIN
    -- 신고 처리 결과 수정
    update report
    set reportResult = result
    where id = reportId;
END$$
DELIMITER ;

-- 관리자는 시스템에 의해 신고 내역을 삭제할 수 없다.
-- 프로시저보단 트리거, 유저의 접근 권한으로 제어 하는 것이 적절하다고 생각함
DELIMITER //

CREATE TRIGGER prevent_report_delete
    BEFORE DELETE ON report
    FOR EACH ROW
BEGIN
    -- 현재 테이블의 전체 행 수를 계산
    IF (SELECT COUNT(*) FROM report) > 1 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Partial deletion is not allowed. Only full table deletion is permitted.';
    END IF;
END;
//

DELIMITER ;

