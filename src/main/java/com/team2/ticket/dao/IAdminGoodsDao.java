package com.team2.ticket.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IAdminGoodsDao {

	void getAdminGoodsKindCount(HashMap<String, Object> paramMap);

	void getAdminGoodsKindList(HashMap<String, Object> paramMap);

	void getAdminGoodsSearchCount(HashMap<String, Object> paramMap);

	void getAdminGoodsSearchList(HashMap<String, Object> paramMap);

}
