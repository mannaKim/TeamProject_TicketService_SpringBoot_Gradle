package com.team2.ticket.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IGoodsDao {

	void getBestNewGoods(HashMap<String, Object> paramMap);

}
