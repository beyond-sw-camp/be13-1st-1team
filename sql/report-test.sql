
-- 신고 조회
call getNewReport;

CALL createReport(
    2, 1, 'Jinsang'
);

-- 신고 처리 -> 경고 누적
CALL createNewCaution(
    1, 1, 'You are Bad', 'You are bad'
);

-- 신고 기각
CALL rejectReport(
    2, 'Pass'
);


