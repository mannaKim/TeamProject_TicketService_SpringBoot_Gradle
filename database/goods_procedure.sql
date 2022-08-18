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