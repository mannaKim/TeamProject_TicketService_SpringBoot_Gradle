package com.team2.ticket.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IGoodsDao {

	void getBestNewGoods(HashMap<String, Object> paramMap);
	
	void getGoodsKindCount(HashMap<String, Object> cntMap);

	void getGoodsKindList(HashMap<String, Object> paramMap);

	void getGoodsSearchCount(HashMap<String, Object> cntMap);

	void getGoodsSearchList(HashMap<String, Object> paramMap);

	void getGoods(HashMap<String, Object> paramMap);

	void listGoodsCart(HashMap<String, Object> paramMap);

	void updateGoodsCart(String id, int gseq, int quantity);

	void insertGoodsCart(String id, int gseq, int quantity);

	void deleteGoodsCart(int gcseq);

	void getPcGoodsBanner(HashMap<String, Object> paramMap);
	
	void getMobileGoodsBanner(HashMap<String, Object> paramMap);

	void getGoodsAndPoint(HashMap<String, Object> paramMap);
}
