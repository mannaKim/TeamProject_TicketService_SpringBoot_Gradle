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
delete from goods_banner;

insert into GOODS_BANNER(gbseq, name, order_seq, image, link, mobile)
values(goods_banner_seq.nextVal, '모바일배너1', 1, 'mobile_wide_1.png', 'm_goodsMain', 'y');
insert into GOODS_BANNER(gbseq, name, order_seq, image, link, mobile)
values(goods_banner_seq.nextVal, '모바일배너2', 2, 'mobile_wide_2.jpg', 'm_goodsDetail?gseq=1', 'y');
insert into GOODS_BANNER(gbseq, name, order_seq, image, link, mobile)
values(goods_banner_seq.nextVal, '모바일배너3', 3, 'mobile_wide_3.png', 'm_goodsSearch?page=1&key=피너츠', 'y');
insert into GOODS_BANNER(gbseq, name, order_seq, image, link, mobile)
values(goods_banner_seq.nextVal, '모바일배너4', 4, 'mobile_wide_4.jpg', 'm_goodsDetail?gseq=2', 'y');
insert into GOODS_BANNER(gbseq, name, order_seq, image, link, mobile)
values(goods_banner_seq.nextVal, '배너1', 1, 'welcome_wide_1.png', 'goodsMain', 'n');
insert into GOODS_BANNER(gbseq, name, order_seq, image, link, mobile)
values(goods_banner_seq.nextVal, '배너2', 2, 'welcome_wide_2.jpg', 'goodsDetail?gseq=1', 'n');
insert into GOODS_BANNER(gbseq, name, order_seq, image, link, mobile)
values(goods_banner_seq.nextVal, '배너3', 3, 'welcome_wide_3.png', 'goodsSearch?page=1&key=피너츠', 'n');
insert into GOODS_BANNER(gbseq, name, order_seq, image, link, mobile)
values(goods_banner_seq.nextVal, '배너4', 4, 'welcome_wide_4.jpg', 'goodsDetail?gseq=2', 'n');