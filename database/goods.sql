DROP TABLE tp_goods CASCADE CONSTRAINTS;

CREATE TABLE tp_goods
(
	gseq number(5) NOT NULL,
	name varchar2(100) NOT NULL,
	kind char(1) NOT NULL,
	num_inventory number(4),
	price1 number(7),
	price2 number(7),
	price3 number(7),
	content varchar2(2000),
	image varchar2(255),
	detail_img varchar2(255),
	useyn char(1) DEFAULT 'y',
	bestyn char(1) DEFAULT 'n',
	indate date DEFAULT SYSDATE,
	PRIMARY KEY (gseq)
);


drop sequence goods_seq;
create sequence goods_seq start with 1;

select * from tp_goods;

insert into tp_goods(gseq,name,kind,num_inventory,price1,price2,price3,content,image,detail_img,bestyn)
values(goods_seq.nextVal,'본투리드 볼펜 (유성)','1',100,500,1200,700,
'그립감 좋은 육각형 바디와 부드러운 필기감의 볼펜입니다. 부드러운 필기감의 유성 잉크에 알라딘 자체 제작 몰드로 볼펜 심의 흔들림을 최소화하였습니다.',
'pen_1.jpg','pen_2.jpg','n');

insert into tp_goods(gseq,name,kind,num_inventory,price1,price2,price3,content,image,detail_img,bestyn)
values(goods_seq.nextVal,'본투리드 초저점도 3색 볼펜','1',1000,700,1500,800,
'70여년의 역사를 만들어온 문화연필과 만든 끊김 없이 부드러운 필기감의 초저점도 3색 볼펜 입니다.',
'ballpen_1.jpg','ballpen_2.jpg','n');

insert into tp_goods(gseq,name,kind,num_inventory,price1,price2,price3,content,image,detail_img,bestyn)
values(goods_seq.nextVal,'샤크 샤프 0.5mm','1',200,800,1600,800,
'날렵한 스타일과 부드러운 자연의 컬러 [earth color]로 다채로움을 더한 6가지 컬러 제품입니다.',
'shark_pencil_1.jpg','shark_pencil_2.jpg','n');

insert into tp_goods(gseq,name,kind,num_inventory,price1,price2,price3,content,image,detail_img,bestyn)
values(goods_seq.nextVal,'빈티지 금장 노트','1',300,12000,14000,2000,
'너무 크거나 작지 않아 휴대하기 좋은 크기의 노트',
'note_1.jpg','note_2.jpg','y');

insert into tp_goods(gseq,name,kind,num_inventory,price1,price2,price3,content,image,detail_img,bestyn)
values(goods_seq.nextVal,'스누피 에어팟 프로 케이스','2',50,10000,13800,3800,
'스누피의 카메라 모양으로 디자인한 에어팟 프로 케이스입니다.
에어팟 프로에 밀착되는 사이즈로 일상 스크래치와 충격으로부터 에어팟을 보호해줍니다.',
'airpods_case_1.jpg','airpods_case_2.jpg','n');

insert into tp_goods(gseq,name,kind,num_inventory,price1,price2,price3,content,image,detail_img,bestyn)
values(goods_seq.nextVal,'미니가습기','2',10,12000,15800,3800,
'문학작품을 담은 탁상용 가습기로 쾌적한 시간을 보내세요.',
'humidifier_1.jpg','humidifier_2.jpg','y');

insert into tp_goods(gseq,name,kind,num_inventory,price1,price2,price3,content,image,detail_img,bestyn)
values(goods_seq.nextVal,'버지니아 울프 주트백','3',200,15000,17800,2800,
'황마로 만든 버지니아 울프 주트백.
가볍고 시원해 보여요.',
'bag1_1.jpg','bag1_2.jpg','n');

insert into tp_goods(gseq,name,kind,num_inventory,price1,price2,price3,content,image,detail_img,bestyn)
values(goods_seq.nextVal,'본투리드 보냉백','3',2000,15000,18800,3800,
'무더운 여름 본투리드, 피너츠 캐릭터와 함께하는 시원함 보존의 법칙!
먼 여행을 떠날 수 없다면 시원함을 가득 담은 보냉백을 들고 가까운 곳으로 피서를 떠나보세요.',
'bag2_1.jpg','bag2_2.jpg','y');

insert into tp_goods(gseq,name,kind,num_inventory,price1,price2,price3,content,image,detail_img,bestyn)
values(goods_seq.nextVal,'D.I.Y 유화도구 세트 어쩌다 화가 - 피너츠','4',100,5000,9800,4800,
'누구나 쉽게 그릴 수 있는 피너츠 D.I.Y 유화도구 세트입니다.
아크릴 물감, 물통, 붓, 나사, 고리, 그림을 벽에 걸 때 사용하는 수평계가 함께 들어 있습니다.',
'painting_pnt_1.jpg','painting_pnt_2.jpg','y');

insert into tp_goods(gseq,name,kind,num_inventory,price1,price2,price3,content,image,detail_img,bestyn)
values(goods_seq.nextVal,'D.I.Y 유화도구 세트 어쩌다 화가 - 둘리','4',80,5000,8500,3500,
'누구나 쉽게 그릴 수 있는 둘리 D.I.Y 유화도구 세트입니다.
아크릴 물감, 물통, 붓, 나사, 고리, 그림을 벽에 걸 때 사용하는 수평계가 함께 들어 있습니다.',
'painting_DOOLY_1.jpg','painting_DOOLY_2.jpg','n');

insert into tp_goods(gseq,name,kind,num_inventory,price1,price2,price3,content,image,detail_img,bestyn)
values(goods_seq.nextVal,'휴대가 편한 여행 슬리퍼 (파우치 포함)','5',5,10000,15800,5800,
'휴식이 필요할 때 가볍게 신는 여행 슬리퍼',
'slipper_1.jpg','slipper_2.jpg','n');

insert into tp_goods(gseq,name,kind,num_inventory,price1,price2,price3,content,image,detail_img,bestyn)
values(goods_seq.nextVal,'피너츠 키링','5',200,5000,9800,4800,
'피너츠의 다양한 스토리들을 디자인한 피너츠 키링입니다.
에코백, 파우치, 에어팟 케이스 등 다양한 곳에 포인트 액세서리로 활용할 수 있습니다.',
'peanuts_keyring_1.jpg','peanuts_keyring_2.jpg','n');

insert into tp_goods(gseq,name,kind,num_inventory,price1,price2,price3,content,image,detail_img,bestyn)
values(goods_seq.nextVal,'본투리드 카드지갑','5',1,7000,11800,4800,
'필요한 카드만 간단하게 소지하는 지갑.',
'card_holder_1.jpg','card_holder_2.jpg','y');

-- 신상품 view 생성
create or replace view new_goods_view
as
select * from
(select rownum,gseq,name,price2,image from tp_goods where useyn='y' order by indate desc)
where rownum<=4;

select * from new_goods_view;

-- 베스트 상품 view 생성
create or replace view best_goods_view
as
select * from
(select rownum,gseq,name,price2,image from tp_goods where bestyn='y' order by indate desc)
where rownum<=4;

select * from best_goods_view;