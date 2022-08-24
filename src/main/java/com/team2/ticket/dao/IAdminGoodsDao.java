package com.team2.ticket.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

import com.team2.ticket.dto.GoodsBannerVO;

@Mapper
public interface IAdminGoodsDao {

	void getAdminGoodsKindCount(HashMap<String, Object> paramMap);

	void getAdminGoodsKindList(HashMap<String, Object> paramMap);

	void getAdminGoodsSearchCount(HashMap<String, Object> paramMap);

	void getAdminGoodsSearchList(HashMap<String, Object> paramMap);

	void insertGoods(HashMap<String, Object> paramMap);

	void deleteGoods(int gseq);

	void updateGoods(HashMap<String, Object> paramMap);

	void getAdminGoodsOrderCount(HashMap<String, Object> paramMap);

	void listAdminGoodsOrder(HashMap<String, Object> paramMap);

	void changeResultAll(int goseq, String result);

	void changeResult(int godseq, String result);

	void getGoodsBannerList(HashMap<String, Object> paramMap);

	void insertGoodsBanner(GoodsBannerVO goodsbannervo);

	void deleteGoodsBanner(int gbseq);

	GoodsBannerVO getGoodsBanner(int gbseq);

	void updateGoodsBanner(GoodsBannerVO goodsbannervo);

}
