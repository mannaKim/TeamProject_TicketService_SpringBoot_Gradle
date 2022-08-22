-- 생성

CREATE TABLE tp_qna
(
	qseq number(5) NOT NULL,
	subject varchar2(300) NOT NULL,
	content varchar2(2000) NOT NULL,
	reply varchar2(1000),
	rep char(1) DEFAULT '1',
	indate date DEFAULT SYSDATE,
	kind char(1),
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


CREATE TABLE tp_faq
(
	faqnum number(7) NOT NULL,
	indate date DEFAULT sysdate,
	con_q varchar2(2000),
	con_a varchar2(2000),
	kind char(1),
	PRIMARY KEY (faqnum)
);

drop table tp_faq;

------

select * from tp_qna;
select * from tp_qreply;

---------

ALTER TABLE tp_qna
	ADD FOREIGN KEY (id)
	REFERENCES tp_member (id)
;

ALTER TABLE tp_qreply
	ADD FOREIGN KEY (id)
	REFERENCES tp_member (id)
;

ALTER TABLE tp_qreply
	ADD FOREIGN KEY (qnanum)
	REFERENCES tp_qna (qseq)
;

ALTER TABLE tp_faq
	ADD FOREIGN KEY (id)
	REFERENCES tp_member (id)
;

-- Qna 추가

drop sequence tp_qna_seq;
create sequence tp_qna_seq start with 1;

select * from tp_qna;

insert into tp_qna (qseq, kind, subject, content, id) 
values(tp_qna_seq.nextval,'1', '전시 내역 관련 문의입니다', '전시 내역 보내주세요', 'somi');
insert into tp_qna (qseq, kind, subject, content, id) 
values(tp_qna_seq.nextval, '4', '굿즈 환불절차 안내부탁드려요', '환불하고 싶어요', 'somi');
insert into tp_qna (qseq, kind, subject, content, id) 
values(tp_qna_seq.nextval, '4', '굿즈 교환 하고 싶어요', '교환절차 안내부탁드려요', 'somi');
insert into tp_qna (qseq, kind, subject, content, id) 
values(tp_qna_seq.nextval, '2', '비밀번호 변경', '변경 적용이 안됩니다', 'somi');
insert into tp_qna (qseq, kind, subject, content, id) 
values(tp_qna_seq.nextval, '3', '예약 관련', '예약 인원 언제 충원하나요?', 'somi');
insert into tp_qna (qseq, kind, subject, content, id) 
values(tp_qna_seq.nextval, '3', '예약 관련', '예약 인원 언제 충원하나요?', 'one');


-- qreply 추가

drop sequence tp_qreply_seq;
create sequence tp_qreply_seq start with 1;

select * from tp_qreply;
select * from tp_member;

insert into tp_qreply (renum, qnanum, content, id) 
values(qreply_seq.nextval, 1, '문의 답변', 'one');
insert into tp_qreply (renum, qnanum, content, id) 
values(qreply_seq.nextval, 2, '확인 후 연락 드리겠습니다.', 'somi');

-- faq 추가

drop sequence tp_faq_seq;
create sequence tp_faq_seq start with 1;

select * from tp_faq;

insert into tp_faq (faqnum, con_q, con_a, kind) 
values(tp_faq_seq.nextval, '회원 정보는 어디에서 변경할 수 있나요?', '회원 정보 변경은 홈페이지 로그인 후, MY PAGE >
				개인정보 변경에서 변경이 가능합니다.', '1');

