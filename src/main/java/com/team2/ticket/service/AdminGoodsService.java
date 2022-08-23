package com.team2.ticket.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team2.ticket.dao.IAdminGoodsDao;
import com.team2.ticket.dto.Paging;

@Service
public class AdminGoodsService {
	@Autowired
	IAdminGoodsDao adao;

	public void getAdminGoodsKindList(HashMap<String, Object> paramMap, int page) {
		Paging paging = new Paging();
		paging.setPage(page);
		paramMap.put("cnt", 0);
		adao.getAdminGoodsKindCount(paramMap);
		paging.setTotalCount(Integer.parseInt(paramMap.get("cnt").toString()));
		paging.setDisplayRow(10);
		
		paging.paging();
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		
		adao.getAdminGoodsKindList(paramMap);
		paramMap.put("paging", paging);
	}

	public void getAdminGoodsSearchList(HashMap<String, Object> paramMap, int page) {
		Paging paging = new Paging();
		paging.setPage(page);
		paramMap.put("cnt", 0);
		adao.getAdminGoodsSearchCount(paramMap);
		paging.setTotalCount(Integer.parseInt(paramMap.get("cnt").toString()));
		paging.setDisplayRow(10);
		
		paging.paging();
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		
		adao.getAdminGoodsSearchList(paramMap);
		paramMap.put("paging", paging);
	}

	public void insertGoods(HashMap<String, Object> paramMap) {
		adao.insertGoods(paramMap);
	}
}
