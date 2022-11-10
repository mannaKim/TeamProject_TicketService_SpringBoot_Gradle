
/* Drop Tables */

DROP TABLE goods_banner CASCADE CONSTRAINTS;
DROP TABLE goods_cart CASCADE CONSTRAINTS;
DROP TABLE goods_order_detail CASCADE CONSTRAINTS;
DROP TABLE goods_orders CASCADE CONSTRAINTS;
DROP TABLE tp_reply CASCADE CONSTRAINTS;
DROP TABLE tp_event CASCADE CONSTRAINTS;
DROP TABLE tp_faq CASCADE CONSTRAINTS;
DROP TABLE tp_goods CASCADE CONSTRAINTS;
DROP TABLE tp_introduce CASCADE CONSTRAINTS;
DROP TABLE tp_notice CASCADE CONSTRAINTS;
DROP TABLE tp_qreply CASCADE CONSTRAINTS;
DROP TABLE tp_qna CASCADE CONSTRAINTS;
DROP TABLE tp_ticket_cart CASCADE CONSTRAINTS;
DROP TABLE tp_member CASCADE CONSTRAINTS;
DROP TABLE tp_ticket_product CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE goods_banner
(
	gbseq number(5) NOT NULL,
	name varchar2(100),
	order_seq number(1),
	image varchar2(255),
	link varchar2(100),
	useyn char(1) DEFAULT 'y',
	mobile char(1) DEFAULT 'n',
	indate date DEFAULT sysdate,
	PRIMARY KEY (gbseq)
);


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


CREATE TABLE goods_orders
(
	goseq number(10) NOT NULL,
	indate date DEFAULT SYSDATE,
	payment varchar2(20),
	totalprice2 number(30) DEFAULT 0 NOT NULL,
	id varchar2(20) NOT NULL,
	PRIMARY KEY (goseq)
);


CREATE TABLE goods_order_detail
(
	godseq number(10) NOT NULL,
	quantity number(5) DEFAULT 1,
	result char(1) DEFAULT '1',
	name varchar2(20) NOT NULL,
	zip_num varchar2(30) NOT NULL,
	address1 varchar2(100) NOT NULL,
	address2 varchar2(100) NOT NULL,
	address3 varchar2(100) NOT NULL,
	phone varchar2(20) NOT NULL,
	goseq number(10) NOT NULL,
	gseq number(5) NOT NULL,
	PRIMARY KEY (godseq)
);


CREATE TABLE tp_event
(
	-- 이벤트넘버
	evnum number(10) NOT NULL,
	-- 이벤트이미지
	eimage varchar2(255) NOT NULL,
	eimage2 varchar2(255) NOT NULL,
	-- 이벤트제목
	title varchar2(50) NOT NULL,
	-- 이벤트기간
	evdate varchar2(50),
	-- 당첨자발표날짜
	evperson varchar2(50),
	readcount number(10) DEFAULT 0,
	-- 업로드날짜
	indate date DEFAULT SYSDATE,
	id varchar2(20) NOT NULL,
	PRIMARY KEY (evnum)
);


CREATE TABLE tp_faq
(
	faqnum number(7) NOT NULL,
	indate date DEFAULT SYSDATE,
	con_q varchar2(2000),
	con_a varchar2(2000),
	kind char(1),
	PRIMARY KEY (faqnum)
);


CREATE TABLE tp_goods
(
	gseq number(5) NOT NULL,
	name varchar2(100) NOT NULL,
	-- 카테고리
	kind char(1) NOT NULL,
	num_inventory number(4),
	-- 원가
	price1 number(7),
	-- 판매가
	price2 number(7),
	-- 마진
	price3 number(7),
	content varchar2(2000),
	image varchar2(255),
	detail_img varchar2(255),
	-- 상품 판매 유효 여부
	useyn char(1) DEFAULT 'y',
	bestyn char(1) DEFAULT 'n',
	-- 상품등록일
	indate date DEFAULT SYSDATE,
	PRIMARY KEY (gseq)
);


CREATE TABLE tp_introduce
(
	itnum number(10) NOT NULL,
	-- 제목
	title varchar2(50),
	-- 내용
	content varchar2(1000),
	-- 게시판생성날짜
	indate date DEFAULT SYSDATE,
	image varchar2(255),
	id varchar2(20) NOT NULL,
	PRIMARY KEY (itnum)
);


CREATE TABLE tp_member
(
	id varchar2(20) NOT NULL,
	pwd varchar2(20) NOT NULL,
	name varchar2(20) NOT NULL,
	email varchar2(40) NOT NULL,
	zip_num varchar2(30),
	address1 varchar2(100),
	address2 varchar2(100),
	address3 varchar2(100),
	phone varchar2(20) NOT NULL,
	mpoint varchar2(20) DEFAULT '0',
	useyn char(1) DEFAULT 'y',
	indate date DEFAULT SYSDATE,
	admin number(1) DEFAULT 0 NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE tp_notice
(
	-- 공지게시판 번호
	ntnum number(30) NOT NULL,
	-- 제목
	title varchar2(50) NOT NULL,
	-- 업로드날짜
	indate date DEFAULT SYSDATE NOT NULL,
	-- 내용
	content varchar2(1000),
	readcount number(10) DEFAULT 0,
	id varchar2(20) NOT NULL,
	PRIMARY KEY (ntnum)
);


CREATE TABLE tp_qna
(
	qseq number(5) NOT NULL,
	subject varchar2(300) NOT NULL,
	content varchar2(2000) NOT NULL,
	reply varchar2(1000),
	rep char(1) DEFAULT '1',
	indate date DEFAULT SYSDATE,
	kind char(1) NOT NULL,
	replycnt number(5),
	id varchar2(20) NOT NULL,
	PRIMARY KEY (qseq)
);


CREATE TABLE tp_qreply
(
	renum number(7) NOT NULL,
	indate date DEFAULT sysdate,
	content varchar2(2000),
	id varchar2(20) NOT NULL,
	qnanum number(5) NOT NULL,
	PRIMARY KEY (renum)
);


CREATE TABLE tp_reply
(
	-- 댓글순번
	replynum number(7) NOT NULL,
	-- 댓글 작성일
	writedate date DEFAULT SYSDATE,
	-- 작성내용
	content varchar2(1000),
	rate number(10),
	-- 이벤트넘버
	evnum number(10) NOT NULL,
	id varchar2(20) NOT NULL,
	PRIMARY KEY (replynum)
);


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
	address varchar2(1000) NOT NULL,
	name varchar2(1000) NOT NULL,
	content varchar2(2000),
	order_seq number(1),
	age number(10),
	image varchar2(255),
	price1 number(7),
	price2 number(7),
	price3 number(7),
	bestyn char(1) DEFAULT 'n',
	indate date DEFAULT SYSDATE,
	PRIMARY KEY (tpseq)
);



/* Create Foreign Keys */

ALTER TABLE goods_order_detail
	ADD FOREIGN KEY (goseq)
	REFERENCES goods_orders (goseq)
;


ALTER TABLE tp_reply
	ADD FOREIGN KEY (evnum)
	REFERENCES tp_event (evnum)
;


ALTER TABLE goods_cart
	ADD FOREIGN KEY (gseq)
	REFERENCES tp_goods (gseq)
;


ALTER TABLE goods_order_detail
	ADD FOREIGN KEY (gseq)
	REFERENCES tp_goods (gseq)
;


ALTER TABLE goods_cart
	ADD FOREIGN KEY (id)
	REFERENCES tp_member (id)
;


ALTER TABLE goods_orders
	ADD FOREIGN KEY (id)
	REFERENCES tp_member (id)
;


ALTER TABLE tp_event
	ADD FOREIGN KEY (id)
	REFERENCES tp_member (id)
;


ALTER TABLE tp_introduce
	ADD FOREIGN KEY (id)
	REFERENCES tp_member (id)
;


ALTER TABLE tp_notice
	ADD FOREIGN KEY (id)
	REFERENCES tp_member (id)
;


ALTER TABLE tp_qna
	ADD FOREIGN KEY (id)
	REFERENCES tp_member (id)
;


ALTER TABLE tp_qreply
	ADD FOREIGN KEY (id)
	REFERENCES tp_member (id)
;


ALTER TABLE tp_reply
	ADD FOREIGN KEY (id)
	REFERENCES tp_member (id)
;


ALTER TABLE tp_ticket_cart
	ADD FOREIGN KEY (id)
	REFERENCES tp_member (id)
;


ALTER TABLE tp_qreply
	ADD FOREIGN KEY (qnanum)
	REFERENCES tp_qna (qseq)
;


ALTER TABLE tp_ticket_cart
	ADD FOREIGN KEY (tpseq)
	REFERENCES tp_ticket_product (tpseq)
;



