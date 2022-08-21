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
    p_goseq OUT goods_orders.goseq%TYPE
)
IS
    v_goseq goods_orders.goseq%TYPE;
BEGIN
    -- goods_orders에 값 삽입
    INSERT INTO goods_orders(goseq, id, payment) 
    VALUES(goods_orders_seq.nextval, p_id, p_payment);
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
    INSERT INTO goods_orders(goseq, id, payment) 
    VALUES(goods_orders_seq.nextval, p_id, p_payment);
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