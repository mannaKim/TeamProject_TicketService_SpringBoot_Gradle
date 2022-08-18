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
}
