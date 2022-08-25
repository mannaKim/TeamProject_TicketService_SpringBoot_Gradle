select * from tp_qna;

/* 혹시 쓸지 몰라 주석 처리. 리스트 가져오는 프로시저.
CREATE OR REPLACE PROCEDURE qlistQna (
    p_startNum IN NUMBER,
    p_endNum IN NUMBER,
    p_rc   OUT     SYS_REFCURSOR )
IS
BEGIN
    OPEN p_rc FOR
    SELECT * FROM (
    SELECT * FROM (
    SELECT ROWNUM AS rn, q.* FROM ((SELECT * FROM TP_QNA ORDER BY qseq desc)q) 
    ) WHERE rn>= p_startNum
    ) WHERE rn<= p_endNum;
END;
*/

--리스트 가져오기
create or replace PROCEDURE qgetAllCount(
    p_cnt OUT NUMBER
)
IS
    v_cnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_cnt FROM TP_QNA;
    p_cnt := v_cnt;
END;

select * from qna;

CREATE OR REPLACE PROCEDURE qinsertQna(
    p_id IN tp_qna.id%TYPE,
    p_subject  IN tp_qna.subject%TYPE,
    p_content  IN tp_qna.content%TYPE,
    p_kind  IN tp_qna.kind%TYPE
    )
IS
BEGIN
    insert into tp_qna(qseq, id, subject, content, kind) 
    values( tp_qna_seq.nextVal, p_id, p_subject, p_content, p_kind );
    commit;    
END;



CREATE OR REPLACE PROCEDURE qgetQna (
    p_qseq IN   TP_Qna.qseq%TYPE,
    p_rc   OUT     SYS_REFCURSOR,
    p_rc1  OUT     SYS_REFCURSOR )
IS
    v_num NUMBER;
    v_cnt NUMBER;
BEGIN
    OPEN p_rc FOR
        SELECT * FROM tp_qna WHERE qseq=p_qseq;
     OPEN p_rc1 FOR  
        SELECT * FROM tp_qreply where qnanum=p_qseq ORDER BY renum DESC;
    select count(*) into v_cnt from tp_qreply where qnanum=v_num;
        update tp_qna set replycnt = v_cnt where qseq=v_num;
        
END;


CREATE OR REPLACE PROCEDURE qmylistQna (
    p_id IN   TP_QNA.ID%TYPE,
    p_startNum IN NUMBER,
    p_endNum IN NUMBER,
    p_rc   OUT     SYS_REFCURSOR )
IS
BEGIN
    OPEN p_rc FOR
    SELECT * FROM (
    SELECT * FROM (
    SELECT ROWNUM AS rn, q.* FROM ((SELECT * FROM TP_QNA WHERE id=p_id ORDER BY qseq desc)q) 
    ) WHERE rn>= p_startNum
    ) WHERE rn<= p_endNum;
END;



CREATE OR REPLACE PROCEDURE qgetMyCount(
    p_id IN TP_QNA.ID%TYPE,
    p_cnt OUT NUMBER
)
IS
    v_cnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_cnt FROM TP_QNA WHERE id=p_id;
    p_cnt := v_cnt;
END;


CREATE OR REPLACE PROCEDURE qinsertReply(
    p_qnanum IN tp_qreply.qnanum%TYPE, 
    p_id IN tp_qreply.id%TYPE,
    p_content IN tp_qreply.content%TYPE )
IS
BEGIN
    insert into tp_qreply( renum, qnanum, id, content ) 
    values( tp_qreply_seq.nextVal, p_qnanum, p_id, p_content );
    commit;
END;



CREATE OR REPLACE PROCEDURE qlistQnaN (
    p_startNum IN NUMBER,
    p_endNum IN NUMBER,
    p_rc   OUT     SYS_REFCURSOR )
IS
BEGIN
    OPEN p_rc FOR
    SELECT * FROM (
    SELECT * FROM (
    SELECT ROWNUM AS rn, q.* FROM ((SELECT * FROM TP_QNA WHERE rep=1 ORDER BY qseq desc)q) 
    ) WHERE rn>= p_startNum
    ) WHERE rn<= p_endNum;
end;

CREATE OR REPLACE PROCEDURE qlistQna (
    p_startNum IN NUMBER,
    p_endNum IN NUMBER,
    p_curvar OUT SYS_REFCURSOR
    )

is
    temp_cur SYS_REFCURSOR;
    v_qnanum number;
    v_rownum number;
    v_cnt number;
begin

OPEN temp_cur  FOR
    SELECT * FROM (
    SELECT * FROM (
    SELECT ROWNUM AS rn, q.qseq FROM ((SELECT * FROM TP_QNA ORDER BY qseq desc)q) 
    ) WHERE rn>= p_startNum
    ) WHERE rn<= p_endNum;

    LOOP
        FETCH temp_cur INTO v_rownum, v_qnanum;
        EXIT WHEN temp_cur%NOTFOUND;
        select count(*) into v_cnt from tp_qreply where qnanum=v_qnanum;
        update tp_qna set replycnt = v_cnt where qseq=v_qnanum;
        
        if v_cnt > 0 then 
        update tp_qna set rep = 2 where qseq=v_qnanum;
        ELSE  
        update tp_qna set rep = 1 where qseq=v_qnanum;
        end if;
        
    END LOOP;
    commit;

    OPEN temp_cur For 
    select * from(select * from(select rownum as rn, q.* from((select * from tp_qna order by qseq desc) q)) where rn>=p_startNum) where rn<=p_endNum;
    p_curvar := temp_cur;
end;


CREATE OR REPLACE PROCEDURE qdeleteReply(
    p_renum IN tp_qreply.renum%TYPE )
IS
BEGIN
    delete from tp_qreply where renum=p_renum;
    commit;
END;


CREATE OR REPLACE PROCEDURE qdeleteQna(
    p_qseq IN tp_qna.qseq%TYPE )
IS
BEGIN
    delete from tp_qna where qseq=p_qseq;
    commit;
END;



CREATE OR REPLACE PROCEDURE faqList (
    p_rc   OUT     SYS_REFCURSOR )
IS
BEGIN
    OPEN p_rc FOR
        SELECT * FROM tp_faq;
        
END;


CREATE OR REPLACE PROCEDURE faqListK (
	p_kind IN tp_faq.kind%TYPE,
    p_rc   OUT     SYS_REFCURSOR )
IS
BEGIN
    OPEN p_rc FOR
        SELECT * FROM tp_faq where kind=p_kind;
        
END;


create or replace PROCEDURE qgetAllFaq(
    p_cnt OUT NUMBER
)
IS
    v_cnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_cnt FROM TP_FAQ;
    p_cnt := v_cnt;
END;


CREATE OR REPLACE PROCEDURE qlistFaq (
    p_startNum IN NUMBER,
    p_endNum IN NUMBER,
    p_curvar OUT SYS_REFCURSOR
    )

is
begin

    OPEN p_curvar For 
    select * from(select * from(select rownum as rn, q.* from((select * from tp_faq order by faqnum desc) q)) where rn>=p_startNum) where rn<=p_endNum;

end;



CREATE OR REPLACE PROCEDURE qinsertFaq(
    p_con_q IN tp_faq.con_q%TYPE,
    p_kind IN tp_faq.kind%TYPE, 
    p_con_a IN tp_faq.con_a%TYPE )
IS
BEGIN
    insert into tp_faq( faqnum, con_q, kind, con_a ) 
    values( tp_faq_seq.nextVal, p_con_q, p_kind, p_con_a );
    commit;
END;



create or replace PROCEDURE qUpdateFaq(
    p_con_q IN tp_faq.con_q%TYPE,
    p_kind IN tp_faq.kind%TYPE, 
    p_con_a IN tp_faq.con_a%TYPE,
    p_faqnum IN tp_faq.faqnum%TYPE
)
IS
BEGIN
    update tp_faq set con_q=p_con_q, kind=p_kind, con_a=p_con_a
    where faqnum=p_faqnum;
    commit;
END;



CREATE OR REPLACE PROCEDURE  pgetFaq(
    p_faqnum IN tp_faq.faqnum%type,
    p_cur1 OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cur1 FOR
        SELECT * FROM tp_faq WHERE faqnum=p_faqnum;
END;


CREATE OR REPLACE PROCEDURE faqDelete(
    p_faqnum IN tp_faq.faqnum%TYPE )
IS
BEGIN
    delete from tp_faq where faqnum=p_faqnum;
    commit;
END;