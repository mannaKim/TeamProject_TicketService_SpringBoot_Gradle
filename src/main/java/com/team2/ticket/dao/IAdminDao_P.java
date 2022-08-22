package com.team2.ticket.dao;

import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IAdminDao_P {

	public void adminlistTicket(HashMap<String, Object> paramMap);
	public void tp_adminGetAllCount(HashMap<String, Object> paramMap);
	public void adminlistTicketCart(HashMap<String, Object> paramMap);
	public void tpc_adminGetAllCount(HashMap<String, Object> cntMap);
	public void insertTProduct(HashMap<String, Object> paramMap);
	public void deleteTicket_productr(HashMap<String, Object> paramMap);
	public void adminUpdateTicket(HashMap<String, Object> paramMap);
	public void deleteTicket_productr_cart(HashMap<String, Object> paramMap);

}
