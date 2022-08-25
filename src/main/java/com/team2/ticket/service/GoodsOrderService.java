package com.team2.ticket.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team2.ticket.dao.IGoodsOrderDao;
import com.team2.ticket.dto.Paging;

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
		odao.getTotalGoods(paramMap);
	}

	public void insertGoodsOrderOne(HashMap<String, Object> paramMap) {
		odao.insertGoodsOrderOne(paramMap);
	}

	public void listGoodsOrderAll(HashMap<String, Object> paramMap, int page) {
		Paging paging = new Paging();
		paging.setPage(page);
		paramMap.put("cnt", 0);
		odao.getGoodsOrderCount(paramMap);
		paging.setTotalCount(Integer.parseInt(paramMap.get("cnt").toString()));
		
		paging.paging();
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		
		//allGoodsOrderList.jsp에 전달될 리스트
		ArrayList<HashMap<String,Object>> finalList
			= new ArrayList<HashMap<String,Object>>();

		//전달된 아이디로 진행중인 주문번호들을 조회
		odao.listGoodsOrderById(paramMap);
		ArrayList<HashMap<String,Object>> goseqList
			= (ArrayList<HashMap<String,Object>>)paramMap.get("ref_cursor");

		//주문번호별 주문내역을 조회
		for(HashMap<String,Object> result : goseqList) {
			int goseq = Integer.parseInt(result.get("GOSEQ").toString());
			paramMap.put("ref_cursor", null);
			paramMap.put("goseq", goseq);
			odao.listGoodsOrder(paramMap);

			ArrayList<HashMap<String,Object>> orderList
				= (ArrayList<HashMap<String,Object>>)paramMap.get("ref_cursor");

			HashMap<String,Object> orderFirst = orderList.get(0); 
			//주문 상품 중 첫번째 상품을 대표 상품으로 이름과 가격을 주문 전체에 대한 내용으로 변경
			if(orderList.size()>1)
				orderFirst.put("GNAME", (String)orderFirst.get("GNAME")+" 외 "+(orderList.size()-1)+"건");
			int totalPrice = 0;
			for(HashMap<String,Object> order : orderList) {
				totalPrice += Integer.parseInt(order.get("QUANTITY").toString())
						* Integer.parseInt(order.get("PRICE").toString());
			}
			orderFirst.put("PRICE", totalPrice);

			finalList.add(orderFirst);
		}
		paramMap.put("finalList", finalList);
		paramMap.put("paging", paging);
	}
	
	public void deletePoint(HashMap<String, Object> paramMap) {
		odao.deletePoint(paramMap);
	}
	
	public void updatePoint(HashMap<String, Object> paramMap) {
		odao.updatePoint(paramMap);
	}
}
