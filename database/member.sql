drop table tp_member CASCADE CONSTRAINTS;

create table tp_member
(
	id varchar2(20) not null,
	pwd varchar2(20) not null,
	name varchar2(20) not null,
	email varchar2(40) not null,
	zip_num varchar2(30) null,
	address1 varchar2(100) not null,
	address2 varchar2(100) null,
	address3 varchar2(100) null,
	phone varchar2(20) not null,
	mpoint number(20) default 0,
	useyn char(1) default 'y',   -- 휴면 계정 여부
	indate date DEFAULT SYSDATE,
	admin number(1) default 0 not null,   -- 0:일반 사용자, 1:관리자
	primary key(id)
);

select * from tp_member;

insert into tp_member(id, pwd, name, zip_num, address1, address2, address3, phone, email, admin) values
('somi','1111','소미','133-110','서울시 성동수 성수동1가','은하빌딩 1층','202호','017-777-7777','abc@abc.com', 1);

insert into tp_member(id, pwd, name, zip_num, address1, address2, address3, phone, email) values
('one','1111','김나리','133-110','서울시 성동수 성수동1가','은하빌딩 1층','202호','017-777-7777','abc@abc.com');

insert into tp_member(id, pwd, name, zip_num, address1, address2, address3, phone, email) values
('two','2222','박나리','133-110','서울시 서초구','빌딩','303호','010-2222-3333','two@abc.com');