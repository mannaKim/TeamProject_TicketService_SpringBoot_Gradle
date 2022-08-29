create or replace PROCEDURE tp_getMember(
    p_id IN tp_member.id%TYPE, 
    p_curvar OUT SYS_REFCURSOR
)
IS
    result_cur SYS_REFCURSOR;  
BEGIN
    OPEN result_cur FOR SELECT * FROM tp_member WHERE id=p_id;
    p_curvar := result_cur;
END;


create or replace procedure ticketingList(
    p_cur OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cur FOR  
        select * from tp_ticket_product order by edate desc;
END;

create or replace procedure getTProduct(
    p_tpseq in tp_ticket_product.tpseq%type,
    p_cur OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cur FOR  
        select * from tp_ticket_product where tpseq=p_tpseq;
END;

create or replace procedure getchoisDay(
    p_tpseq in tp_ticket_product.tpseq%type,
    p_cur OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cur FOR  
        select * from tp_ticket_product where tpseq=p_tpseq;
END;

create or replace procedure insertOrder(
    p_id in tp_ticket_cart.id%type,
    p_tpseq in tp_ticket_cart.tpseq%type,
    p_choisdate in tp_ticket_cart.choisdate%type,
    p_quantity1 in tp_ticket_cart.quantity1%type,
    p_quantity2 in tp_ticket_cart.quantity2%type,
    p_cur OUT SYS_REFCURSOR
)
IS
BEGIN
    insert into tp_ticket_cart( cseq, id, tpseq, choisdate, quantity1, quantity2 )
    values( tp_ticket_cart_cseq.nextVal, p_id, p_tpseq, p_choisdate, p_quantity1, p_quantity2 );
    commit;
    OPEN p_cur FOR  
        select * from tp_ticket_product where tpseq=p_tpseq;
END;

create or replace procedure tclistTicket(
    p_id in tp_ticket_cart.id%type,
    p_cur OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cur FOR  
        select * from tp_ticket_cart_view where id=p_id;
END;

create or replace procedure getTicketList(
    p_id in tp_ticket_cart.id%type,
    p_startNum IN NUMBER,
    p_endNum IN NUMBER,
    p_cur OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cur FOR
        select * from (
        select * from (
        select rownum as rn, c.* from (
        (select * from tp_ticket_cart_view where id=p_id order by cseq desc) c)
        ) where rn>=p_startNum
        ) where rn<=p_endNum;
END;

create or replace procedure mtp_getAllCount(
    p_id in tp_ticket_cart.id%type,
    p_cnt out number
)
is
    v_cnt number;
begin
    select count(*) into v_cnt from tp_ticket_cart_view where id=p_id;
    p_cnt := v_cnt;
end;


create or replace procedure adminlistTicket(
    p_startNum number,
    p_endNum number,
    p_key in product.name%type,
    p_cur OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cur FOR  
    select * from (
	select * from (
    select rownum as rn, p.* from 
    ((select * from tp_ticket_product where name like '%'||p_key||'%' order by tpseq desc) p)
	) where rn >= p_startNum
	) where rn <= p_endNum;
END;

create or replace procedure adminlistTicketCart(
    p_cur OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cur FOR 
        select * from tp_ticket_cart_view order by cseq desc;
END;


create or replace procedure adminlistTicketCart(
    p_startNum number,
    p_endNum number,
    p_key in product.name%type,
    p_cur OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cur FOR 
    select * from (
	select * from (
    select rownum as rn, c.* from 
    ((select * from tp_ticket_cart_view where pname like '%'||p_key||'%' order by cseq desc) c)
	) where rn >= p_startNum
	) where rn <= p_endNum;
END;


create or replace procedure tp_adminGetAllCount(
    p_key in tp_ticket_product.name%type,
    p_cnt out number
)
is
    v_cnt number;
begin
    select count(*) into v_cnt from tp_ticket_product where name like '%'||p_key||'%';
    p_cnt := v_cnt;
end;


create or replace procedure tpc_adminGetAllCount(
    p_key in tp_ticket_cart_view.pname%type,
    p_cnt out number
)
is
    v_cnt number;
begin
    select count(*) into v_cnt from tp_ticket_cart_view where pname like '%'||p_key||'%';
    p_cnt := v_cnt;
end;


create or replace procedure insertTProduct(
    p_name in tp_ticket_product.name%type,
    p_price1 in tp_ticket_product.price1%type,
    p_price2 in tp_ticket_product.price2%type,
    p_price3 in tp_ticket_product.price3%type,
    p_showtime in tp_ticket_product.showtime%type,
    p_age in tp_ticket_product.age%type,
    p_content in tp_ticket_product.content%type,
    p_place in tp_ticket_product.place%type,
    p_daytime in tp_ticket_product.daytime%type,
    p_sdate in tp_ticket_product.sdate%type,
    p_edate in tp_ticket_product.edate%type,
    p_address in tp_ticket_product.address%type,
    p_image in tp_ticket_product.image%type
)
is
begin
    insert into tp_ticket_product( tpseq ,name, price1, price2, price3, showtime, age, content, place, daytime, sdate, edate, address, image )
    values( tp_ticket_product_tpseq.nextVal, p_name, p_price1, p_price2, p_price3, p_showtime, p_age, p_content, p_place, p_daytime,
            p_sdate,p_edate,p_address,p_image );
    commit;
end;


create or replace procedure deleteTicket_productr(
    p_tpseq in tp_ticket_product.tpseq%type
)
is
begin
    delete from tp_ticket_product where tpseq=p_tpseq;
    commit;
end;


create or replace procedure adminUpdateTicket(
    p_name in tp_ticket_product.name%type,
    p_price1 in tp_ticket_product.price1%type,
    p_price2 in tp_ticket_product.price2%type,
    p_price3 in tp_ticket_product.price3%type,
    p_showtime in tp_ticket_product.showtime%type,
    p_age in tp_ticket_product.age%type,
    p_content in tp_ticket_product.content%type,
    p_place in tp_ticket_product.place%type,
    p_daytime in tp_ticket_product.daytime%type,
    p_sdate in tp_ticket_product.sdate%type,
    p_edate in tp_ticket_product.edate%type,
    p_address in tp_ticket_product.address%type,
    p_image in tp_ticket_product.image%type,
    p_tpseq in tp_ticket_product.tpseq%type
)
is
begin
    update tp_ticket_product set name=p_name, price1=p_price1, price2=p_price2, price3=p_price3,
        showtime=p_showtime, age=p_age, content=p_content, place=p_place, daytime=p_daytime, 
        sdate=p_sdate, edate=p_edate, address=p_address, image=p_image where tpseq=p_tpseq;
    commit;
end;


create or replace procedure deleteTicket_productr_cart(
    p_cseq in tp_ticket_cart.cseq%type
)
is
begin
    delete from tp_ticket_cart where cseq=p_cseq;
    commit;
end;


create or replace procedure getTProduct2(
    p_tpseq in tp_ticket_product.tpseq%type,
    p_id IN tp_member.id%TYPE,
    p_cur OUT SYS_REFCURSOR,
    p_cur2 OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cur FOR  
        select * from tp_ticket_product where tpseq=p_tpseq;
    OPEN p_cur2 FOR
        select * from tp_member where id=p_id;
END;