package com.team2.ticket.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team2.ticket.dao.IAdminGoodsDao;
import com.team2.ticket.dao.IGoodsOrderDao;
import com.team2.ticket.dto.GoodsBannerVO;
import com.team2.ticket.dto.GoodsVO;
import com.team2.ticket.dto.Paging;

@Service
public class AdminGoodsService {
	@Autowired
	IAdminGoodsDao adao;
	
	@Autowired
	IGoodsOrderDao odao;

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

	public void deleteGoods(int gseq) {
		adao.deleteGoods(gseq);
	}

	public void updateGoods(GoodsVO goodsvo) {
		adao.updateGoods(goodsvo);
	}

	public void listAdminGoodsOrder(HashMap<String, Object> paramMap, int page) {
		Paging paging = new Paging();
		paging.setPage(page);
		paramMap.put("cnt", 0);
		adao.getAdminGoodsOrderCount(paramMap);
		paging.setTotalCount(Integer.parseInt(paramMap.get("cnt").toString()));
		paging.setDisplayRow(10);
		
		paging.paging();
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		
		//?????? ????????? ????????? ??????
		ArrayList<HashMap<String,Object>> finalList
			= new ArrayList<HashMap<String,Object>>();

		//????????????(goseq)?????? ??????
		adao.listAdminGoodsOrder(paramMap);
		ArrayList<HashMap<String,Object>> goseqList
			= (ArrayList<HashMap<String,Object>>)paramMap.get("ref_cursor");

		//??????????????? ??????????????? ??????
		for(HashMap<String,Object> result : goseqList) {
			int goseq = Integer.parseInt(result.get("GOSEQ").toString());
			paramMap.put("ref_cursor", null);
			paramMap.put("goseq", goseq);
			odao.listGoodsOrder(paramMap);

			ArrayList<HashMap<String,Object>> orderList
				= (ArrayList<HashMap<String,Object>>)paramMap.get("ref_cursor");

			HashMap<String,Object> orderFirst = orderList.get(0); 
			//?????? ?????? ??? ????????? ????????? ?????? ???????????? ????????? ????????? ?????? ????????? ?????? ???????????? ??????
			if(orderList.size()>1)
				orderFirst.put("GNAME", (String)orderFirst.get("GNAME")+" ??? "+(orderList.size()-1)+"???");
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

	public void changeResultAll(int goseq, String result) {
		adao.changeResultAll(goseq, result);
	}

	public void changeResult(int godseq, String result) {
		adao.changeResult(godseq, result);
	}

	public void getGoodsBannerList(HashMap<String, Object> paramMap) {
		adao.getGoodsBannerList(paramMap);
	}

	public void insertGoodsBanner(GoodsBannerVO goodsbannervo) {
		adao.insertGoodsBanner(goodsbannervo);
	}

	public void deleteGoodsBanner(int gbseq) {
		adao.deleteGoodsBanner(gbseq);
	}

	public GoodsBannerVO getGoodsBanner(int gbseq) {
		return adao.getGoodsBanner(gbseq);
	}

	public void updateGoodsBanner(GoodsBannerVO goodsbannervo) {
		adao.updateGoodsBanner(goodsbannervo);
	}
}
