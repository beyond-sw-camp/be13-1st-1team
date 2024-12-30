-- 상품 리뷰 조회 테스트
call selectPackageReview;

-- 상품 리뷰 생성 테스트
CALL CreateOrder (1,1);
call createPackageReview(1, 'Good!');
call createPackageReview(1, 'Great!');

-- 상품 리뷰 수정
call updateOnePackageReviewByOrder_Id(1, 'Very Good');

-- 리뷰 삭제 테스트(관리자) -> 리뷰id
call deleteOnePackageReview(1);

-- 리뷰 삭제 테스트 (사용자) -> 주문id
call deleteOnePackageReviewByUser_Id(1);
