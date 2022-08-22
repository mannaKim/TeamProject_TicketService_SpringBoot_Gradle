package com.team2.ticket.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IMypageDao {

	public void getTicketList(HashMap<String, Object> paramMap);

	public void mtp_getAllCount(HashMap<String, Object> cntMap);


}
