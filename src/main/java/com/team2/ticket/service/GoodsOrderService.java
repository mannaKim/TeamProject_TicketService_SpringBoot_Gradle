package com.team2.ticket.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team2.ticket.dao.IGoodsOrderDao;

@Service
public class GoodsOrderService {
	@Autowired
	IGoodsOrderDao odao;

	public void listGoodsCartToBuy(HashMap<String, Object> paramMap) {
		ArrayList<HashMap<String,Object>> list
			= new ArrayList<HashMap<String,Object>>();
		for(int gcseq : (int [])paramMap.get("gcseqArr")) {
			paramMap.put("gcseq", gcseq);
			odao.listGoodsCartToBuy(paramMap);
			ArrayList<HashMap<String, Object>> cartList
				= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
			list.add(cartList.get(0));
		}
		paramMap.put("goodsCartListToBuy", list);
	}

	public void insertGoodsOrder(HashMap<String, Object> paramMap, int[] gcseqArr) {
		odao.insertGoodsOrder(paramMap);
		for(int gcseq : gcseqArr) {
			paramMap.put("gcseq", gcseq);
			odao.insertGoodsOrderDetail(paramMap);
		}
	}

	public void listGoodsOrder(HashMap<String, Object> paramMap) {
		odao.listGoodsOrder(paramMap);
	}

	public void insertGoodsOrderOne(HashMap<String, Object> paramMap) {
		odao.insertGoodsOrderOne(paramMap);
	}
}
