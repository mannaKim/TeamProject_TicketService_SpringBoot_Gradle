drop table tp_ticket_cart CASCADE CONSTRAINTS;
CREATE TABLE tp_ticket_cart
(
	cseq number(7) NOT NULL,
	choisdate date,
	quantity1 number(7),
	quantity2 number(7),
	result char(1),
	indate date DEFAULT SYSDATE,
	id varchar2(20) NOT NULL,
	tpseq number(7) NOT NULL,
	PRIMARY KEY (cseq)
);

drop table tp_ticket_product CASCADE CONSTRAINTS;
CREATE TABLE tp_ticket_product
(
	tpseq number(7) NOT NULL,
	-- 공연관람시간
	showtime varchar2(20) NOT NULL,
	sdate date,
	edate date,
	-- 공연입장시간/날짜 같이표시
	daytime varchar2(100) NOT NULL,
	-- 공연장소
	place varchar2(1000) NOT NULL,
	-- 상세주소
	address varchar2(1000) NOT NULL,
	name varchar2(1000) NOT NULL,
	content varchar2(2000),
	age number(10),
	image varchar2(255),
	price1 number(7),
	price2 number(7),
	price3 number(7),
	bestyn char(1) DEFAULT 'n',
	indate date DEFAULT SYSDATE,
	PRIMARY KEY (tpseq)
);

create or replace view tp_ticket_cart_view
as
select c.cseq, c.id, m.name as mname, c.tpseq, p.name as pname,
	c.choisdate, c.quantity1, c.quantity2, p.price1, p.price2, p.price3, p.daytime, p.edate, p.image,
	c.result, c.indate
from tp_ticket_cart c, tp_ticket_product p, tp_member m
where c.tpseq = p.tpseq and c.id = m.id;

drop sequence tp_ticket_product_tpseq;
create sequence tp_ticket_product_tpseq start with 1;

drop sequence tp_ticket_cart_cseq;
create sequence tp_ticket_cart_cseq start with 1;

delete from tp_ticket_cart;
delete from tp_ticket_product;

insert into tp_ticket_product(tpseq, showtime, sdate, edate, daytime, name, age, image, price1, price2, place, bestyn, address) 
values(tp_ticket_product_tpseq.nextval, '1시간', '2022-07-10', '2022-08-20','1시', '2022 경기전 왕과의 산책', 
   5, '1.jpg', 15000, 10000, '전주한옥마을 경기전',  'n', '전라북도 전주시 완산구 태조로 44');

insert into tp_ticket_product(tpseq, showtime, sdate, edate, daytime, name, age, image, price1, price2, price3, place, bestyn, address) 
values(tp_ticket_product_tpseq.nextval, '1시간20분', '2022-07-12', '2022-09-25','2시', '2022 CJ대한통운 슈퍼레이스 챔피언십 ROUND.4', 
   12, '2.jpg', 15000, 10000, 1000, '영암코리아 인터내셔널서킷 (국제 자동차 경주장)',  'n', '전라남도 영암군 삼호읍 에프원로 2');
   
insert into tp_ticket_product(tpseq, showtime, sdate, edate, daytime, name, age, image, price1, price2, price3, place, bestyn,address) 
values(tp_ticket_product_tpseq.nextval, '총 50분', '2022-07-01', '2022-08-25','2시', 
   'IVEX 스튜디오 X 캐리와 친구들 썸머 스케이팅 페스타', 6, '3.jpg', 10000, 10000, 3000, 'IVEX 스튜디오(광명 AK프라자 5층)','n', '경기도 광명시 양지로 17');
   
insert into tp_ticket_product(tpseq, showtime, sdate, edate, daytime, name, age, image, price1, price2, price3, place, bestyn,address) 
values(tp_ticket_product_tpseq.nextval, '총 50분', '2022-07-29', '2022-09-28','2시', 
   '어린이 가족 페스티벌', 0, 'tk4.jpg', 10000, 10000, 3000, '예술의전당 자유소극장','n', '서울 서초구 남부순환로 2406');
   
insert into tp_ticket_product(tpseq, showtime, sdate, edate, daytime, name, age, image, price1, price2, price3, place, bestyn,address) 
values(tp_ticket_product_tpseq.nextval, '1시간30분', '2022-07-20', '2022-08-20','3시', 
   '지브리 여름음악 대축전', 6, 'tk2.jpg', 60000, 50000, 3000, '예술의전당 콘서트홀','n', '서울 서초구 남부순환로 2406');