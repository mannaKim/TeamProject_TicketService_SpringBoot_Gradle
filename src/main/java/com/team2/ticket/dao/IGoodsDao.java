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
}
