
/* Drop Tables */

DROP TABLE address CASCADE CONSTRAINTS;
DROP TABLE reply CASCADE CONSTRAINTS;
DROP TABLE event CASCADE CONSTRAINTS;
DROP TABLE goods_cart CASCADE CONSTRAINTS;
DROP TABLE goods_review CASCADE CONSTRAINTS;
DROP TABLE order_detail CASCADE CONSTRAINTS;
DROP TABLE goods CASCADE CONSTRAINTS;
DROP TABLE introduce CASCADE CONSTRAINTS;
DROP TABLE notice CASCADE CONSTRAINTS;
DROP TABLE orders CASCADE CONSTRAINTS;
DROP TABLE qreply CASCADE CONSTRAINTS;
DROP TABLE qna CASCADE CONSTRAINTS;
DROP TABLE ticket_cart CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;
DROP TABLE ticket_product CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE address
(
	zip_num varchar2(7) NOT NULL,
	sido varchar2(30) NOT NULL,
	gugun varchar2(30) NOT NULL,
	dong varchar2(100) NOT NULL,
	zip_code varchar2(30),
	bunji varchar2(30)
);


CREATE TABLE event
(
	-- 이벤트넘버
	evnum number(10) NOT NULL,
	-- 이벤트이미지
	eimage varchar2(255) NOT NULL,
	eimage2 varchar2(255) NOT NULL,
	-- 이벤트제목
	title varchar2(50) NOT NULL,
	-- 이벤트기간
	evdate varchar2(20),
	-- 당첨자발표날짜
	evperson varchar2(20),
	-- 게시글 삭제 비밀번호
	pass varchar2(30),
	readcount number(10) DEFAULT 0,
	-- 업로드날짜
	indate date DEFAULT SYSDATE,
	id varchar2(20) NOT NULL,
	PRIMARY KEY (evnum)
);


CREATE TABLE goods
(
	gseq number(5) NOT NULL,
	name varchar2(100) NOT NULL,
	-- 카테고리
	kind char(1) NOT NULL,
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


CREATE TABLE goods_review
(
	grseq number(5) NOT NULL,
	subject varchar2(300) NOT NULL,
	content varchar2(2000) NOT NULL,
	indate date DEFAULT sysdate,
	image varchar2(255),
	id varchar2(20) NOT NULL,
	gseq number(5) NOT NULL,
	PRIMARY KEY (grseq)
);


CREATE TABLE introduce
(
	-- 제목
	title varchar2(50),
	-- 내용
	content varchar2(1000),
	-- 게시판생성날짜
	indate date DEFAULT SYSDATE,
	pass varchar2(30),
	image varchar2(255),
	id varchar2(20) NOT NULL
);


CREATE TABLE member
(
	id varchar2(20) NOT NULL,
	pwd varchar2(20) NOT NULL,
	name varchar2(20) NOT NULL,
	email varchar2(40) NOT NULL,
	zip_num varchar2(10),
	address1 varchar2(200),
	address2 varchar2(200),
	phone varchar2(20) NOT NULL,
	indate date DEFAULT SYSDATE,
	admin number(1) DEFAULT 0 NOT NULL,
	PRIMARY KEY (id)
);


CREATE TABLE notice
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
	pass varchar2(30),
	id varchar2(20) NOT NULL,
	PRIMARY KEY (ntnum)
);


CREATE TABLE orders
(
	oseq number(10) NOT NULL,
	indate date DEFAULT SYSDATE,
	id varchar2(20) NOT NULL,
	PRIMARY KEY (oseq)
);


CREATE TABLE order_detail
(
	odseq number(10) NOT NULL,
	quantity number(5) DEFAULT 1,
	result char(1) DEFAULT '1',
	oseq number(10) NOT NULL,
	gseq number(5) NOT NULL,
	PRIMARY KEY (odseq)
);


CREATE TABLE qna
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


CREATE TABLE qreply
(
	renum number(7) NOT NULL,
	indate date DEFAULT sysdate,
	content varchar2(2000),
	id varchar2(20) NOT NULL,
	qnanum number(5) NOT NULL,
	PRIMARY KEY (renum)
);


CREATE TABLE reply
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


CREATE TABLE ticket_cart
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


CREATE TABLE ticket_product
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



/* Create Foreign Keys */

ALTER TABLE reply
	ADD FOREIGN KEY (evnum)
	REFERENCES event (evnum)
;


ALTER TABLE goods_cart
	ADD FOREIGN KEY (gseq)
	REFERENCES goods (gseq)
;


ALTER TABLE goods_review
	ADD FOREIGN KEY (gseq)
	REFERENCES goods (gseq)
;


ALTER TABLE order_detail
	ADD FOREIGN KEY (gseq)
	REFERENCES goods (gseq)
;


ALTER TABLE event
	ADD FOREIGN KEY (id)
	REFERENCES member (id)
;


ALTER TABLE goods_cart
	ADD FOREIGN KEY (id)
	REFERENCES member (id)
;


ALTER TABLE goods_review
	ADD FOREIGN KEY (id)
	REFERENCES member (id)
;


ALTER TABLE introduce
	ADD FOREIGN KEY (id)
	REFERENCES member (id)
;


ALTER TABLE notice
	ADD FOREIGN KEY (id)
	REFERENCES member (id)
;


ALTER TABLE orders
	ADD FOREIGN KEY (id)
	REFERENCES member (id)
;


ALTER TABLE qna
	ADD FOREIGN KEY (id)
	REFERENCES member (id)
;


ALTER TABLE qreply
	ADD FOREIGN KEY (id)
	REFERENCES member (id)
;


ALTER TABLE reply
	ADD FOREIGN KEY (id)
	REFERENCES member (id)
;


ALTER TABLE ticket_cart
	ADD FOREIGN KEY (id)
	REFERENCES member (id)
;


ALTER TABLE order_detail
	ADD FOREIGN KEY (oseq)
	REFERENCES orders (oseq)
;


ALTER TABLE qreply
	ADD FOREIGN KEY (qnanum)
	REFERENCES qna (qseq)
;


ALTER TABLE ticket_cart
	ADD FOREIGN KEY (tpseq)
	REFERENCES ticket_product (tpseq)
;



