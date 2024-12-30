-- User 생성
insert into user(
    userId, gradeId, userType, name, email, passwd, nickName,
    phoneNum, birthAt, national
) 
values ('ABC', 3, 3, 'BC', 'a@c.c', '1q2w', 
'nick', '01022233344', '1992-05-05', 'Korea');

-- 상품 생성
CALL createPackage(
    1, 1,'Kazua!' , 5000, 'Lets go house',
    '2025-01-05', '2025-01-05', '2025-01-03'
);

CALL getAllPackages;

-- category 조회
CALL getPackagesByCategory('문화');

-- 지역 조회
CALL getPackagesByArea('서울');


-- createPackage ~ getPackageArea 테스트 완료

CALL updatePackage(1, NULL, 'Changed Packge', NULL, 
NULL, NULL, '2025-01-05', '2025-01-10');

-- deletePackageBySeller
CALL createPackage(
    1, 1,'Invalid-Package' , 5000, 'Lets go house',
    '2025-01-05', '2025-01-05', '2025-01-03'
);

CALL createPackage(
    1, 1,'Ended Package' , 5000, 'Lets go house',
    '2024-12-05', '2024-12-10', '2024-12-20'
);

CALL createPackage(
    1, 1,'InvalPackage2' , 5000, 'Lets go house',
    '2025-01-05', '2025-01-05', '2025-01-03'
);

-- 삭제 성공 case
CALL deletePackageBySeller(2);

-- 삭제 실패 case
CALL deletePackageBySeller(3);

-- 삭제 성공(by manager) 
CALL deletePackageByManager(4);

call insertUser(
    'KKK', 'KUK', 'v@v.c', '1q1q1q', 'King', 
    '01099994444', '1880-09-09', 'Japan'
);


CALL createReport(
    2, 1, 'GGU'
);