package com.team2.ticket.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ITicketingDao {
	
	public void ticketingList(HashMap<String, Object> paramMap);
	public void getTProduct(HashMap<String, Object> paramMap);
	public void getchoisDay(HashMap<String, Object> paramMap);
	public void insertOrder(HashMap<String, Object> paramMap);
	public void tclistTicket(HashMap<String, Object> paramMap1);

	
}
