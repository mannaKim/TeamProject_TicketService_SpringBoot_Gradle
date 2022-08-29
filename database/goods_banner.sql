drop table goods_banner;

CREATE TABLE goods_banner(
	gbseq number(5) primary key,
	name varchar2(100),
	order_seq number(1),
	image varchar(50),
	link varchar(100),
	useyn char(1) default 'y',
	mobile char(1) default 'n',
	indate date default sysdate
);

drop sequence goods_banner_seq;
CREATE sequence goods_banner_seq start with 1;

select * from goods_banner;