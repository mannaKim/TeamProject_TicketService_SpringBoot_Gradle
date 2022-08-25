drop table tp_qna CASCADE CONSTRAINTS;
drop table tp_qreply CASCADE CONSTRAINTS;
drop table tp_faq;

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
values(tp_qreply_seq.nextval, 1, '문의 답변', 'one');
insert into tp_qreply (renum, qnanum, content, id) 
values(tp_qreply_seq.nextval, 2, '확인 후 연락 드리겠습니다.', 'somi');

-- faq 추가

drop sequence tp_faq_seq;
create sequence tp_faq_seq start with 1;

select * from tp_faq;

-- 1 전시 2 회원안내 3 관람예약 4 굿즈
-- 4번 정도 하면 굿
insert into tp_faq (faqnum, con_q, con_a, kind) 
values(tp_faq_seq.nextval, '회원 정보는 어디에서 변경할 수 있나요?', '회원 정보 변경은 홈페이지 로그인 후, MY PAGE >
				개인정보 변경에서 변경이 가능합니다.', '2');
insert into tp_faq (faqnum, con_q, con_a, kind) 
values(tp_faq_seq.nextval, '전시 관련 도록을 구입하고 싶습니다.', '전시관람 당일 해당 전시장 판매처에서 구입하실 수
				있습니다. 이미 종료된 전시의 경우에는 해당 전시 주최측에 문의하시면 됩니다. 주최측 연락처는 해당 전시의 상세정보를
				참고해주시기 바랍니다.', '1');
insert into tp_faq (faqnum, con_q, con_a, kind) 
values(tp_faq_seq.nextval, '온라인으로 주문한 굿즈의 배송지를 변경할 수 있나요?', '현재로서는 주문하신 상품의 배송지나 옵션을 변경하는 기능을
				제공하고 있지 않습니다. 번거로우시더라도 주문 건이 결제완료 상태인 경우라면 취소 후 재구매 부탁드리며, 배송준비중
				상태인 경우라면 고객센터로 문의 바랍니다.', '4');
insert into tp_faq (faqnum, con_q, con_a, kind) 
values(tp_faq_seq.nextval, '예매 티켓의 변경∙취소가 가능한가요?', '예매하신 티켓의 변경, 취소는 관람전 일 오후 5시까지만
				가능합니다. 취소 가능 시간 이후의 티켓 취소, 변경 환불은 불가능하니 이점 유의 바랍니다.', '3');
