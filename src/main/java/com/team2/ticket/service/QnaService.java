package com.team2.ticket.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team2.ticket.dao.IQnaDao;
import com.team2.ticket.dto.FaqVO;
import com.team2.ticket.dto.Paging;
import com.team2.ticket.dto.QnaVO;

@Service
public class QnaService {
	
	@Autowired
	IQnaDao qdao;


	public void qlistQna(HashMap<String, Object> paramMap, int page) {
		
		Paging paging = new Paging();
		paging.setPage(page);
		paging.setDisplayPage(5);
		paging.setDisplayRow(5);
		paramMap.put("cnt", 0);
		qdao.qgetAllCount(paramMap);
		int count = Integer.parseInt( paramMap.get("cnt").toString());
		paging.setTotalCount(count);
		paging.paging();
		
		paramMap.put("startNum", paging.getStartNum() );
		paramMap.put("endNum", paging.getEndNum() );
		paramMap.put("paging", paging);
		
		qdao.qlistQna( paramMap );
		
	}

	public void qinsertQna(HashMap<String, Object> paramMap) {
		qdao.qinsertQna(paramMap);
		
	}

	public void qgetQna(HashMap<String, Object> paramMap) {
		qdao.qgetQna( paramMap );	
		
	}

	public void qmylistQna(HashMap<String, Object> paramMap, int page) {
		
		Paging paging = new Paging();
		paging.setPage(page);
		paging.setDisplayPage(5);
		paging.setDisplayRow(5);
		paramMap.put("cnt", 0);
		paramMap.put("cnt", 0);
		qdao.qgetMyCount(paramMap);
		int count = Integer.parseInt( paramMap.get("cnt").toString());
		paging.setTotalCount(count);
		paging.paging();
		
		paramMap.put("startNum", paging.getStartNum() );
		paramMap.put("endNum", paging.getEndNum() );
		paramMap.put("paging", paging);
		
		qdao.qmylistQna( paramMap );
		
	}

	public void qinsertReply(HashMap<String, Object> paramMap) {
		qdao.qinsertReply(paramMap);
	}


	public void qdeleteReply(HashMap<String, Object> paramMap) {
		qdao.qdeleteReply(paramMap);
	}

//	public void qnarep(int qnanum) {
//		qdao.qnarep(qnanum);
//		
//	}

	public void qdeleteQna(HashMap<String, Object> paramMap) {
		qdao.qdeleteQna(paramMap);
		
	}

//	public void qnaRep(int qseq, int num) {
//		qdao.qnaRep(qseq, num);
//		
//	}

	public void qlistQnaN(HashMap<String, Object> paramMap, int page) {
		Paging paging = new Paging();
		paging.setPage(page);
		paging.setDisplayPage(5);
		paging.setDisplayRow(5);
		paramMap.put("cnt", 0);
		qdao.qgetAllCount(paramMap);
		int count = Integer.parseInt( paramMap.get("cnt").toString());
		paging.setTotalCount(count);
		paging.paging();
		
		paramMap.put("startNum", paging.getStartNum() );
		paramMap.put("endNum", paging.getEndNum() );
		paramMap.put("paging", paging);
		
		qdao.qlistQnaN( paramMap );
		
	}


	public void faqList(HashMap<String, Object> paramMap) {
		qdao.faqList(paramMap);
		
	}



}
