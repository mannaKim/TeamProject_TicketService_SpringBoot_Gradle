DROP TABLE goods_cart CASCADE CONSTRAINTS;

CREATE TABLE goods_cart
(
	gcseq number(10) NOT NULL,
	quantity number(5) DEFAULT 1,
	result char(1) DEFAULT '1',
	indate date DEFAULT SYSDATE,
	id varchar2(20) NOT NULL,
	gseq number(5) NOT NULL,
	PRIMARY KEY (gcseq)
);

drop sequence goods_cart_seq;
create sequence goods_cart_seq start with 1;

select * from goods_cart;

-- 굿즈 정보, 회원 정보까지 보여주는 카트 뷰 생성
create or replace view goods_cart_view
as
select c.gcseq, c.id, c.gseq, c.quantity, c.result, c.indate,
m.name as mname, g.name as gname, g.price2 as price, g.image
from goods_cart c, tp_goods g, tp_member m
where c.gseq=g.gseq and c.id=m.id;

select * from goods_cart_view;