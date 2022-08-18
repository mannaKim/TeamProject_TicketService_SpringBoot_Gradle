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