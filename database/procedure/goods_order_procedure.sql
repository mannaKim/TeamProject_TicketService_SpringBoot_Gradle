create or replace PROCEDURE listGoodsCartToBuy(
    p_gcseq IN goods_cart_view.gcseq%TYPE,
    p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR 
        SELECT * FROM goods_cart_view 
        WHERE gcseq = p_gcseq;
END;


create or replace PROCEDURE insertGoodsOrder(
    p_id IN goods_orders.id%TYPE,
    p_payment IN goods_orders.payment%TYPE,
    p_totalprice2 in goods_orders.totalprice2%type,
    p_goseq OUT goods_orders.goseq%TYPE
)
IS
    v_goseq goods_orders.goseq%TYPE;
BEGIN
    -- goods_orders에 값 삽입
    INSERT INTO goods_orders(goseq, id, payment, totalprice2) 
    VALUES(goods_orders_seq.nextval, p_id, p_payment, p_totalprice2);
    -- 가장 최근에 삽입한 goseq 추출
    SELECT MAX(goseq) INTO v_goseq FROM goods_orders;
    p_goseq := v_goseq;
    COMMIT;
END;


create or replace PROCEDURE insertGoodsOrderDetail(
    p_gcseq IN goods_cart.gcseq%TYPE,
    p_goseq IN goods_orders.goseq%TYPE,
    p_name IN goods_order_detail.name%TYPE,
    p_zip_num IN goods_order_detail.zip_num%TYPE,
    p_address1 IN goods_order_detail.address1%TYPE,
    p_address2 IN goods_order_detail.address1%TYPE,
    p_address3 IN goods_order_detail.address1%TYPE,
    p_phone IN goods_order_detail.phone%TYPE
)
IS
    v_gseq goods_cart.gseq%TYPE;
    v_quantity goods_cart.quantity%TYPE;
BEGIN
    -- goods_cart에서 gseq와 quantity값 추출
    SELECT gseq, quantity INTO v_gseq, v_quantity
    FROM goods_cart 
    WHERE gcseq=p_gcseq;
    -- goods_order_detail에 값 삽입
    INSERT INTO goods_order_detail(godseq, goseq, gseq, quantity, 
                                    name, zip_num, address1, address2, address3, phone)
    VALUES(goods_order_detail_seq.nextval, p_goseq, v_gseq, v_quantity,
            p_name, p_zip_num, p_address1, p_address2, p_address3, p_phone);
    -- goods_cart에 값 삭제
    DELETE FROM goods_cart WHERE gcseq=p_gcseq;
    -- tp_goods에 재고 업데이트
    UPDATE tp_goods SET num_inventory = num_inventory - v_quantity WHERE gseq = v_gseq;
    COMMIT;
    -- 예외처리
    EXCEPTION WHEN OTHERS THEN ROLLBACK;
END;


create or replace PROCEDURE listGoodsOrder(
    p_goseq IN goods_order_view.goseq%TYPE,
    p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR 
        SELECT * FROM goods_order_view 
        WHERE goseq = p_goseq;
END;


create or replace PROCEDURE insertGoodsOrderOne(
    p_id IN goods_orders.id%TYPE,
    p_payment IN goods_orders.payment%TYPE,
    p_totalprice2 in goods_orders.totalprice2%type,
    p_goseq OUT goods_orders.goseq%TYPE,
    p_gseq IN goods_order_detail.gseq%TYPE,
    p_quantity IN goods_order_detail.quantity%TYPE,
    p_name IN goods_order_detail.name%TYPE,
    p_zip_num IN goods_order_detail.zip_num%TYPE,
    p_address1 IN goods_order_detail.address1%TYPE,
    p_address2 IN goods_order_detail.address1%TYPE,
    p_address3 IN goods_order_detail.address1%TYPE,
    p_phone IN goods_order_detail.phone%TYPE
)
IS
    v_goseq tp_goods.gseq%TYPE;
BEGIN
    -- goods_orders에 값 삽입
    INSERT INTO goods_orders(goseq, id, payment, totalprice2) 
    VALUES(goods_orders_seq.nextval, p_id, p_payment, p_totalprice2);
    -- 가장 최근에 삽입한 goseq 추출
    SELECT MAX(goseq) INTO v_goseq FROM goods_orders;
    p_goseq := v_goseq;
    -- goods_order_detail에 값 삽입
    INSERT INTO goods_order_detail(godseq, goseq, gseq, quantity, 
                                    name, zip_num, address1, address2, address3, phone)
    VALUES(goods_order_detail_seq.nextval, v_goseq, p_gseq, p_quantity,
            p_name, p_zip_num, p_address1, p_address2, p_address3, p_phone);
    -- tp_goods에 재고 업데이트
    UPDATE tp_goods SET num_inventory = num_inventory - p_quantity WHERE gseq = p_gseq;
    COMMIT;
    -- 예외처리
    EXCEPTION WHEN OTHERS THEN ROLLBACK;
END;


create or replace PROCEDURE getGoodsOrderCount(
    p_id IN tp_member.id%TYPE,
    P_cnt OUT NUMBER
)
IS
    v_cnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_cnt 
    FROM goods_orders
    WHERE id=p_id;
    p_cnt := v_cnt;
END;


create or replace PROCEDURE listGoodsOrderById(
    p_id IN tp_member.id%TYPE,
    p_startNum IN NUMBER,
    p_endNum IN NUMBER,
    p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR 
        SELECT * FROM (
            SELECT * FROM (
                SELECT rownum AS rn, o.* FROM (
                    (SELECT DISTINCT goseq
                    FROM (SELECT goseq, id, result 
                        FROM goods_order_view 
                        ORDER BY result DESC)
                    WHERE id=p_id
                    ORDER BY goseq DESC) o)
            ) WHERE rn>=p_startNum
        ) WHERE rn<=p_endNum;
END;


-- 포인트 업데이트
create or replace procedure updatePoint(
    p_id in tp_member.id%type,
    p_mpoint in tp_member.mpoint%type
)
is
begin
    update tp_member set mpoint = mpoint + p_mpoint where id=p_id;
end;

-- 포인트 차감
create or replace procedure deletePoint(
    p_id in tp_member.id%type,
    p_dpoint in tp_member.mpoint%type
)
is
begin
    update tp_member set mpoint = mpoint - p_dpoint where id=p_id;
end;

-- 굿즈 차감액 출력
create or replace procedure getTotalGoods(
    p_goseq in goods_orders.goseq%type,
    p_tcur OUT SYS_REFCURSOR
)
is
begin
    open p_tcur for
    select * from goods_orders where goseq=p_goseq order by goseq desc;
end;