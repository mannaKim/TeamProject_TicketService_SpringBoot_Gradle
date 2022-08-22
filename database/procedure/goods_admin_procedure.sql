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