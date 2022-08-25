package com.team2.ticket.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IGoodsOrderDao {
	
	void listGoodsCartToBuy(HashMap<String, Object> paramMap);

	void insertGoodsOrder(HashMap<String, Object> paramMap);

	void insertGoodsOrderDetail(HashMap<String, Object> paramMap);

	void listGoodsOrder(HashMap<String, Object> paramMap);

	void insertGoodsOrderOne(HashMap<String, Object> paramMap);

	void getGoodsOrderCount(HashMap<String, Object> paramMap);

	void listGoodsOrderById(HashMap<String, Object> paramMap);
	
	void updatePoint(HashMap<String, Object> paramMap);
	
	void deletePoint(HashMap<String, Object> paramMap);
	
	void getTotalGoods(HashMap<String, Object> paramMap);
	
}
