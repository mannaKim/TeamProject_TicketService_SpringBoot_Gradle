package com.team2.ticket.service;

import java.util.ArrayList;
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

	public void getGoodsSearchList(HashMap<String, Object> paramMap, int page) {
		Paging paging = new Paging();
		paging.setPage(page);
		paramMap.put("cnt", 0);
		gdao.getGoodsSearchCount(paramMap);
		paging.setTotalCount(Integer.parseInt(paramMap.get("cnt").toString()));
		
		paging.paging();
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		
		gdao.getGoodsSearchList(paramMap);
		paramMap.put("paging", paging);
	}

	public void getGoods(HashMap<String, Object> paramMap) {
		gdao.getGoods(paramMap);
	}

	public void insertGoodsCart(String id, int gseq, int quantity) {	
		// testMap에 담아온 카트 리스트에 gseq가 동일한 상품이 있다면 insert가 아니라 quantity 업데이트
		HashMap<String, Object> testMap = new HashMap<String, Object>();
		testMap.put("id", id);
		testMap.put("ref_cursor", null);
		gdao.listGoodsCart(testMap);
		ArrayList<HashMap<String,Object>> list
			= (ArrayList<HashMap<String,Object>>)testMap.get("ref_cursor");
		
		int count = 0;
		for(HashMap<String,Object> cart : list) {
			int cart_gseq = Integer.parseInt(cart.get("GSEQ").toString());
			if(cart_gseq == gseq) {
				count++;
				gdao.updateGoodsCart(id, gseq, quantity);
			}
		}
		if(count==0) gdao.insertGoodsCart(id, gseq, quantity);
	}

	public void listGoodsCart(HashMap<String, Object> paramMap) {
		gdao.listGoodsCart(paramMap);
	}

	public void deleteGoodsCart(int[] gcseqArr) {
		for(int gcseq : gcseqArr) {
			gdao.deleteGoodsCart(gcseq);
		}
	}

	public void getPcGoodsBanner(HashMap<String, Object> paramMap) {
		gdao.getPcGoodsBanner(paramMap);
	}
	
	public void getMobileGoodsBanner(HashMap<String, Object> paramMap) {
		gdao.getMobileGoodsBanner(paramMap);
	}
}
