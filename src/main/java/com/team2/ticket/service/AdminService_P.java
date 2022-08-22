package com.team2.ticket.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team2.ticket.dao.IAdminDao_P;
import com.team2.ticket.dto.Paging;

@Service
public class AdminService_P {

	@Autowired
	IAdminDao_P adao;

	public void adminlistTicket(HashMap<String, Object> paramMap, int page, String key) {
		Paging paging = new Paging();
		paging.setPage(page);
		paging.setDisplayPage(10);
		paging.setDisplayRow(10);
		paramMap.put("cnt", 0);
		paramMap.put("key", key);
		adao.tp_adminGetAllCount(paramMap);
		int count = (Integer)paramMap.get("cnt"); 
		paging.setTotalCount(count); 
		paging.paging(); 
		
		paramMap.put("startNum", paging.getStartNum() );
		paramMap.put("endNum", paging.getEndNum() );
		paramMap.put("paging", paging);
		
		adao.adminlistTicket( paramMap );
	}
	
	public void adminlistTicketCart(HashMap<String, Object> paramMap, int page, String key) {
		
		Paging paging = new Paging();
		paging.setPage(page);
		paging.setDisplayPage(10);
		paging.setDisplayRow(10);
		paramMap.put("cnt", 0);
		paramMap.put("key", key);
		adao.tpc_adminGetAllCount(paramMap);
		int count = (Integer)paramMap.get("cnt"); 
		paging.setTotalCount(count); 
		paging.paging(); 
		
		paramMap.put("startNum", paging.getStartNum() );
		paramMap.put("endNum", paging.getEndNum() );
		paramMap.put("paging", paging);
		
		adao.adminlistTicketCart( paramMap );
	}
	
	/*
	public void adminlistTicketCart(HashMap<String, Object> paramMap) {
		adao.adminlistTicketCart( paramMap );
	}*/

	public void insertTProduct(HashMap<String, Object> paramMap) {
		adao.insertTProduct( paramMap );
	}

	public void deleteTicket_productr(HashMap<String, Object> paramMap) {
		adao.deleteTicket_productr( paramMap );
	}

	public void adminUpdateTicket(HashMap<String, Object> paramMap) {
		adao.adminUpdateTicket( paramMap );
	}

	public void deleteTicket_productr_cart(HashMap<String, Object> paramMap) {
		adao.deleteTicket_productr_cart( paramMap );	
	}
}
