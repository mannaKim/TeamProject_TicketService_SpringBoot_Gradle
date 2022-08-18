package com.team2.ticket.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team2.ticket.dao.IGoodsDao;
import com.team2.ticket.dto.Paging;

@Service
public class GoodsService {
	@Autowired
	IGoodsDao gdao;

	public void getBestNewGoods(HashMap<String, Object> paramMap) {
		gdao.getBestNewGoods(paramMap);
	}
	
	public void getGoodsKindList(HashMap<String, Object> paramMap, int page) {
		Paging paging = new Paging();
		paging.setPage(page);
		paramMap.put("cnt", 0);
		gdao.getGoodsKindCount(paramMap);
		paging.setTotalCount(Integer.parseInt(paramMap.get("cnt").toString()));
		
		paging.paging();
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		
		gdao.getGoodsKindList(paramMap);
		paramMap.put("paging", paging);
	}
}
