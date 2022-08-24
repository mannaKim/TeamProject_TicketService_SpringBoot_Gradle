DROP TABLE goods_orders CASCADE CONSTRAINTS;
CREATE TABLE goods_orders
(
	goseq number(10) NOT NULL,
	indate date DEFAULT SYSDATE,
	id varchar2(20) NOT NULL,
	payment varchar2(20) NOT NULL,
	PRIMARY KEY (goseq)
);

DROP TABLE goods_order_detail CASCADE CONSTRAINTS;
CREATE TABLE goods_order_detail
(
	godseq number(10) NOT NULL,
	quantity number(5) DEFAULT 1,
	result char(1) DEFAULT '1',
	goseq number(10) NOT NULL,
	gseq number(5) NOT NULL,
	name varchar2(20) NOT NULL,
	zip_num varchar2(30) NOT NULL,
	address1 varchar2(100) NOT NULL,
	address2 varchar2(100) NOT NULL,
	address3 varchar2(100) NOT NULL,
	phone varchar2(20) NOT NULL,
	PRIMARY KEY (godseq)
);

-- goods_orders 테이블
drop sequence goods_orders_seq;
create sequence goods_orders_seq start with 1;
delete from goods_orders;
select * from goods_orders;

-- goods_order_detail 테이블
drop sequence goods_order_detail_seq;
create sequence goods_order_detail_seq start with 1;
delete from goods_order_detail;
select * from goods_order_detail;

-- order_datail에 orders,member,goods가 join된 view 생성
create or replace view goods_order_view
as
select d.godseq, d.quantity, d.result, d.name, d.phone,
	d.zip_num, d.address1, d.address2, d.address3, 
	o.goseq, o.indate, o.payment,
	m.id, m.name as mname,
	g.gseq, g.name as gname, g.price2 as price, g.image
from goods_orders o, goods_order_detail d, tp_member m, tp_goods g
where o.goseq=d.goseq and o.id=m.id and d.gseq=g.gseq;

select * from goods_order_view;

select distinct goseq
from GOODS_ORDER_VIEW;