create or replace PROCEDURE getBestNewGoods(
    p_curvar1 OUT SYS_REFCURSOR,
    p_curvar2 OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar1 FOR
        SELECT * FROM best_goods_view;
    OPEN p_curvar2 FOR
        SELECT * FROM new_goods_view;
END;


create or replace PROCEDURE getGoodsKindCount(
    p_kind IN tp_goods.kind%TYPE,
    P_cnt OUT NUMBER
)
IS
    v_cnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_cnt 
    FROM tp_goods
    WHERE kind=p_kind AND useyn='y';
    p_cnt := v_cnt;
END;


create or replace PROCEDURE getGoodsKindList(
    p_kind IN tp_goods.kind%TYPE,
    p_startNum IN NUMBER,
    p_endNum IN NUMBER,
    p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR
        SELECT * FROM (
            SELECT * FROM (
                SELECT rownum AS rn, g.* FROM (
                    (SELECT * FROM tp_goods 
                    WHERE kind=p_kind AND useyn='y'
                    ORDER BY INDATE DESC) g)
            ) WHERE rn>=p_startNum
        ) WHERE rn<=p_endNum;
END;


create or replace PROCEDURE getGoodsSearchCount(
    p_key IN tp_goods.name%TYPE,
    P_cnt OUT NUMBER
)
IS
    v_cnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_cnt 
     FROM tp_goods
    WHERE name LIKE '%'||p_key||'%' AND useyn='y';
    p_cnt := v_cnt;
END;


create or replace PROCEDURE getGoodsSearchList(
    p_key IN tp_goods.name%TYPE,
    p_startNum IN NUMBER,
    p_endNum IN NUMBER,
    p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR
        SELECT * FROM (
            SELECT * FROM (
                SELECT rownum AS rn, g.* FROM (
                    (SELECT * FROM tp_goods 
                    WHERE name LIKE '%'||p_key||'%' AND useyn='y'
                    ORDER BY indate DESC) g)
            ) WHERE rn>=p_startNum
        ) WHERE rn<=p_endNum;
END;


create or replace PROCEDURE getGoods(
    p_gseq IN tp_goods.gseq%TYPE,
    p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR SELECT * FROM tp_goods WHERE gseq=p_gseq;
END;


create or replace PROCEDURE listGoodsCart(
    p_id IN goods_cart_view.id%TYPE,
    p_curvar OUT SYS_REFCURSOR,
    p_idpoint OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR 
        SELECT * FROM goods_cart_view WHERE id=p_id; 
    OPEN p_idpoint FOR
        select * from tp_member where id=p_id;
END;


create or replace PROCEDURE getGoodsBanner(
    p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR 
        SELECT * FROM goods_banner 
        WHERE useyn='y'
        ORDER BY order_seq;
END;