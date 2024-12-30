-- 판매자 리뷰 조회 테스트
call selectSellerReview;

-- 판매자 리뷰 등록 테스트
call createSellerReview(2,1,'I love you');

-- 판매자 리뷰 수정 테스트트
call updateOneSellerReviewByUser_Id_Order_Id(2,1, 'I love you so much');



call createSellerReview(2,1,'GGU');
--관리자의 판매자 리뷰 삭제
call deleteOneSellerReview(1);

-- 사용자의 판매자 리뷰 삭제
call deleteOneSellerReviewByUser_Id_Order_Id(2,1);