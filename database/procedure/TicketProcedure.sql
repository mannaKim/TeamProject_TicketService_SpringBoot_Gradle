-- 메인 화면 전시 이미지
create or replace procedure getTicketMain(
    p_ticur OUT SYS_REFCURSOR
)
is
begin
    open p_ticur for
    select * from tp_ticket_product order by tpseq desc;
end;


-- 이벤트 조회수
create or replace procedure eventReadCount(
    p_evnum in tp_event.evnum%TYPE
)
is
begin
    update tp_event set readcount = readcount + 1 where evnum=p_evnum;
    commit;
end;


-- 이벤트 목록
create or replace procedure getEventView(
    p_evnum in tp_event.evnum%type,
    p_eview OUT SYS_REFCURSOR,
    p_erep OUT SYS_REFCURSOR
    
)
is
begin
    OPEN p_eview for
    select * from tp_event where evnum=p_evnum;
    
    OPEN p_erep for
    select * from tp_reply where evnum=p_evnum order by replynum desc;
end;

-- 관리자페이징카운트(공지사항, 키값)
create or replace procedure adminIntroAllCount(
    p_introName number,
    p_key in tp_notice.title%TYPE,
    p_cnt OUT NUMBER
)
is
    v_cnt number;
begin
     IF p_introName = 1 THEN
        SELECT COUNT(*) INTO v_cnt FROM tp_notice where title like '%'||p_key||'%';
    END IF;
    p_cnt := v_cnt;
end;

-- 관리자 페이징카운트(이벤트, 페이징만)
create or replace procedure adminEventAllCount(
    p_tableName number,
    p_cnt OUT NUMBER
)
is
    v_cnt number;
begin
    IF p_tableName = 1 THEN
        SELECT COUNT(*) INTO v_cnt FROM tp_event;
    elsif p_tableName = 2 then
        select count(*) into v_cnt from tp_member;
    END IF;
    p_cnt := v_cnt;
end;

-- 관리자 공지사항 페이징
create or replace procedure getAdminNotice(
    p_startNum IN NUMBER,
    p_endNum IN NUMBER,
    p_key IN tp_notice.title%TYPE,
    p_wpcur OUT SYS_REFCURSOR
)
is
begin
    OPEN p_wpcur for
    select * from(select * from(select rownum as rn, p.* from((select * from tp_notice where title like '%'||p_key||'%' order by ntnum desc) p))where rn>=p_startNum) where rn<=p_endNum;
end;


-- 관리자 공지사항 뷰
create or replace procedure getAdminNoticeView(
    p_ntnum in tp_notice.ntnum%TYPE,
    p_cur OUT SYS_REFCURSOR
)
is
begin
    OPEN p_cur for
    select * from tp_notice where ntnum=p_ntnum;
end;


-- 관리자 공지사항 등록
create or replace procedure insertAdminNotice(
    p_ntnum in tp_notice.ntnum%type,
    p_title in tp_notice.title%type,
    p_content in tp_notice.content%type,
    p_id in tp_notice.id%type
)
is
begin
    insert into tp_notice(ntnum, title, content, id)
    values(ntnum_seq.nextVal, p_title, p_content, p_id);
    commit;
end;


-- 관리자 공지사항 삭제
create or replace procedure deleteNotice(
    p_ntnum in tp_notice.ntnum%type
)
is
begin
    delete from tp_notice where ntnum=p_ntnum;
end;


-- 관리자 공지사항 수정
create or replace procedure adminUpdateNotice(
    p_ntnum in tp_notice.ntnum%type,
    p_title in tp_notice.title%type,
    p_content in tp_notice.content%type,
    p_id in tp_notice.id%type

)
is
begin
    update tp_notice set title=p_title, content=p_content where ntnum=p_ntnum;
end;


-- 관리자 유저페이지
create or replace procedure getAdminUser(
    p_startNum IN NUMBER,
    p_endNum IN NUMBER,
    p_cur OUT SYS_REFCURSOR
)
is
begin
    OPEN p_cur for
    select * from(select * from(select rownum as rn, m.* from((select * from tp_member order by indate desc) m)) where rn>=p_startNum) where rn<=p_endNum;
end;


-- 관리자 이벤트 페이지
create or replace procedure getEventList(
    p_startNum IN NUMBER,
    p_endNum IN NUMBER,
    p_evcur OUT SYS_REFCURSOR
)
is
begin
    OPEN p_evcur for
    select * from(select * from(select rownum as rn, e.* from((select * from tp_event order by evnum desc) e)) where rn>=p_startNum) where rn<=p_endNum;
end;

-- 관리자 이벤트 추가
create or replace procedure insertEvent(
    p_evnum in tp_event.evnum%type,
    p_id in tp_event.id%type,
    p_title in tp_event.title%type,
    p_evdate in tp_event.evdate%type,
    p_evperson in tp_event.evperson%type,
    p_eimage1 in tp_event.eimage%type,
    p_eimage2 in tp_event.eimage2%type
)
is
begin
    insert into tp_event (evnum, id, title, evdate, evperson, eimage, eimage2)
    values(evnum_seq.nextVal, p_id, p_title, p_evdate, p_evperson, p_eimage1, p_eimage2);
end;

-- 관리자 이벤트 뷰
create or replace procedure getAdminEventView(
    p_evnum in tp_event.evnum%type,
    p_aecur OUT SYS_REFCURSOR
)
is
begin
    open p_aecur for
    select * from tp_event where evnum=p_evnum;
end;

-- 관리자 이벤트 삭제
create or replace procedure deleteEvent(
    p_evnum in tp_event.evnum%type
)
is
begin
    delete from tp_event where evnum=p_evnum;
end;

-- 관리자 이벤트 수정
create or replace procedure updateAdminEvent(
    p_evnum in tp_event.evnum%type,
    p_id in tp_event.id%type,
    p_title in tp_event.title%type,
    p_evdate in tp_event.evdate%type,
    p_evperson in tp_event.evperson%type,
    p_eimage in tp_event.eimage%type,
    p_eimage2 in tp_event.eimage2%type
)
is
begin
    update tp_event set title=p_title, id=p_id, evdate=p_evdate, evperson=p_evperson, eimage=p_eimage, eimage2=p_eimage2 where evnum=p_evnum;
    commit;
end;

-- 관리자 유저관리(관리자변경)
create or replace procedure adminMember(
    p_id in tp_member.id%type,
    p_admin in tp_member.admin%type
)  
is
begin
    update tp_member set admin=p_admin where id=p_id;
end;

-- 관리자 유저 조회
create or replace procedure getAdminUserPage(
    p_id in tp_member.id%type,
    p_idcur OUT SYS_REFCURSOR
)
is
begin
    open p_idcur for
    select * from tp_member where id=p_id;
end;

-- 관리자 유저 포인트 수정
create or replace procedure adminPointUpdate(
    p_id in tp_member.id%type,
    p_mpoint in tp_member.mpoint%type
)
is
begin
    update tp_member set mpoint=p_mpoint where id=p_id;
end;

select * from tp_reply;

select avg(rate) from tp_reply where evnum = 2;