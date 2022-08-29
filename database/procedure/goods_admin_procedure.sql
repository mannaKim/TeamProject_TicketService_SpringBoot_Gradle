create or replace PROCEDURE getAdminGoodsKindCount(
    p_kind IN tp_goods.kind%TYPE,
    P_cnt OUT NUMBER
)
IS
    v_cnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_cnt 
    FROM tp_goods
    WHERE kind=p_kind;
    p_cnt := v_cnt;
END;


create or replace PROCEDURE getAdminGoodsKindList(
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
                    WHERE kind=p_kind
                    ORDER BY useyn DESC, indate DESC) g)
            ) WHERE rn>=p_startNum
        ) WHERE rn<=p_endNum;
END;


create or replace PROCEDURE getAdminGoodsSearchCount(
    p_key IN tp_goods.name%TYPE,
    P_cnt OUT NUMBER
)
IS
    v_cnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_cnt 
     FROM tp_goods
    WHERE name LIKE '%'||p_key||'%';
    p_cnt := v_cnt;
END;


create or replace PROCEDURE getAdminGoodsSearchList(
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
                    WHERE name LIKE '%'||p_key||'%' 
                    ORDER BY useyn DESC, indate DESC) g)
            ) WHERE rn>=p_startNum
        ) WHERE rn<=p_endNum;
END;


create or replace PROCEDURE getAdminGoodsOrderCount(
    P_cnt OUT NUMBER
)
IS
    v_cnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_cnt 
    FROM goods_orders;
    p_cnt := v_cnt;
END;


create or replace PROCEDURE listAdminGoodsOrder(
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
                    FROM (SELECT goseq, result 
                        FROM goods_order_view 
                        ORDER BY result DESC)
                    ORDER BY goseq DESC) o)
            ) WHERE rn>=p_startNum
        ) WHERE rn<=p_endNum;
END;


create or replace PROCEDURE getGoodsBannerList(
    p_curvar OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_curvar FOR 
        SELECT * FROM goods_banner
        ORDER BY useyn DESC, mobile, order_seq;
END;