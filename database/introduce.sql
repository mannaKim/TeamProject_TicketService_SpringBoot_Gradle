drop table tp_event CASCADE CONSTRAINTS;
-- 이벤트
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

drop sequence evnum_seq;
create sequence evnum_seq start with 1;

select * from tp_event;


drop table tp_introduce CASCADE CONSTRAINTS;
-- 소개
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

drop sequence itnum_seq;
create sequence itnum_seq start with 1;

select * from tp_introduce;


drop table tp_notice CASCADE CONSTRAINTS;
-- 공지사항
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

drop sequence ntnum_seq;
create sequence ntnum_seq start with 1;

select * from tp_notice;


drop table tp_reply CASCADE CONSTRAINTS;
-- 이벤트 댓글
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
drop sequence reply_seq;
create sequence reply_seq start with 1 increment by 1;

select * from tp_reply;


-- 회사 소개
insert into tp_introduce(itnum, title, content, image, id) 
values(ntnum_seq.nextVal, '회사소개 입니다.', '회사소개 내용입니다.', 'intro.jpg', 'somi');



-- 공지사항
insert into tp_notice(ntnum, title, content, id)
values(ntnum_seq.nextVal, '공지사항 1번', '공지사항 1번의 내용', 'somi');
insert into tp_notice(ntnum, title, content, id)
values(ntnum_seq.nextVal, '공지사항 2번', '공지사항 2번의 내용', 'somi');
insert into tp_notice(ntnum, title, content, id)
values(ntnum_seq.nextVal, '공지사항 3번', '공지사항 3번의 내용', 'somi');
insert into tp_notice(ntnum, title, content, id)
values(ntnum_seq.nextVal, '공지사항 4번', '공지사항 4번의 내용', 'somi');
insert into tp_notice(ntnum, title, content, id)
values(ntnum_seq.nextVal, '공지사항 5번', '공지사항 5번의 내용', 'somi');




-- 이벤트
insert into tp_event(evnum, eimage, eimage2, title, evdate, evperson, id)
values(evnum_seq.nextVal, 'event1.jpg', 'mainevent1.png', '이벤트1', '22-08-20 ~ 22-09-28', '22-10-30', 'somi');
insert into tp_event(evnum, eimage, eimage2, title, evdate, evperson, id)
values(evnum_seq.nextVal, 'event2.jpg', 'mainevent2.png', '이벤트2', '22-08-20 ~ 22-10-05', '22-10-15', 'somi');
insert into tp_event(evnum, eimage, eimage2, title, evdate, evperson, id)
values(evnum_seq.nextVal, 'event3.jpg', 'mainevent3.png', '이벤트3', '22-08-02 ~ 22-09-30', '22-10-10', 'somi');




-- 댓글
insert into tp_reply (replynum, evnum, content, rate, id)
values(reply_seq.nextVal, 2, '첫번째 댓글입니다.', 3 , 'one');
insert into tp_reply (replynum, evnum, content, rate, id)
values(reply_seq.nextVal, 2, '두번쨰 댓글입니다.', 4 , 'two');
insert into tp_reply (replynum, evnum, content, rate, id)
values(reply_seq.nextVal, 2, '댓글테스트', 2 , 'somi');