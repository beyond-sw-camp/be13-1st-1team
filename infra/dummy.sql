use kppong;

-- role
insert into userType values(1, '관리자');
insert into grade values(2, '일반 회원');
insert into grade values(3, '사업자 회원');

-- grade 골드 실버 브론즈
insert into grade values(1, '골드');
insert into grade values(2, '실버');
insert into grade values(3, '브론즈');

-- area
insert into areaCategory(name) values('서울');
insert into areaCategory(name) values('경기');
insert into areaCategory(name) values('강원');
insert into areaCategory(name) values('충북');
insert into areaCategory(name) values('충남');
insert into areaCategory(name) values('전북');
insert into areaCategory(name) values('전남');
insert into areaCategory(name) values('경북');
insert into areaCategory(name) values('경남');
insert into areaCategory(name) values('제주');

-- culture
insert into cultureCategory(name) values('오락');
insert into cultureCategory(name) values('문화');
insert into cultureCategory(name) values('쇼핑');
insert into cultureCategory(name) values('여가');

-- culture area
insert into cultureArea(name, cultureCategory, area)
values('경복궁', 
(select id from cultureCategory where name = '문화'),
(select id from areaCategory where name = '서울')
);

insert into cultureArea(name, cultureCategory, area)
values('창경궁', 
(select id from cultureCategory where name = '문화'),
(select id from areaCategory where name = '서울')
);

insert into cultureArea(name, cultureCategory, area)
values('국립중앙박물관', 
(select id from cultureCategory where name = '문화'),
(select id from areaCategory where name = '서울')
);

insert into cultureArea(name, cultureCategory, area)
values('롯데월드', 
(select id from cultureCategory where name = '오락'),
(select id from areaCategory where name = '서울')
);

insert into cultureArea(name, cultureCategory, area)
values('서울숲', 
(select id from cultureCategory where name = '여가'),
(select id from areaCategory where name = '서울')
);

insert into cultureArea(name, cultureCategory, area)
values('보라매공원', 
(select id from cultureCategory where name = '여가'),
(select id from areaCategory where name = '서울')
);

insert into cultureArea(name, cultureCategory, area)
values('하늘공원', 
(select id from cultureCategory where name = '여가'),
(select id from areaCategory where name = '서울')
);

insert into cultureArea(name, cultureCategory, area)
values('여의도공원', 
(select id from cultureCategory where name = '여가'),
(select id from areaCategory where name = '서울')
);

insert into cultureArea(name, cultureCategory, area)
values('더현대서울', 
(select id from cultureCategory where name = '쇼핑'),
(select id from areaCategory where name = '서울')
);

insert into cultureArea(name, cultureCategory, area)
values('스타필드하남', 
(select id from cultureCategory where name = '쇼핑'),
(select id from areaCategory where name = '경기')
);

insert into cultureArea(name, cultureCategory, area)
values('에버랜드', 
(select id from cultureCategory where name = '여가'),
(select id from areaCategory where name = '경기')
);

insert into cultureArea(name, cultureCategory, area)
values('광교호수공원', 
(select id from cultureCategory where name = '여가'),
(select id from areaCategory where name = '경기')
);

insert into cultureArea(name, cultureCategory, area)
values('수원화성', 
(select id from cultureCategory where name = '문화'),
(select id from areaCategory where name = '경기')
);


insert into cultureArea(name, cultureCategory, area)
values('방화수류정', 
(select id from cultureCategory where name = '문화'),
(select id from areaCategory where name = '경기')
);

insert into cultureArea(name, cultureCategory, area)
values('남한산성', 
(select id from cultureCategory where name = '문화'),
(select id from areaCategory where name = '경기')
);

