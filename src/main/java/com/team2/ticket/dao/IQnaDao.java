package com.team2.ticket.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.team2.ticket.dto.QnaVO;

@Mapper
public interface IQnaDao {

	public void qlistQna(HashMap<String, Object> paramMap);
	public void qgetAllCount(HashMap<String, Object> paramMap);
	public void qinsertQna(HashMap<String, Object> paramMap);
	public void qgetQna(HashMap<String, Object> paramMap);
	public void qmylistQna(HashMap<String, Object> paramMap);
	public void qgetMyCount(HashMap<String, Object> paramMap);
	public void qinsertReply(HashMap<String, Object> paramMap);
	public void qdeleteReply(HashMap<String, Object> paramMap);
//	public void qnarep(int qnanum);
	public void qdeleteQna(HashMap<String, Object> paramMap);
//	public void qnaRep(int qseq, int num);
	public void qlistQnaN(HashMap<String, Object> paramMap);
	public List<QnaVO> selectfaq();
	public void faqList(HashMap<String, Object> paramMap);


}
