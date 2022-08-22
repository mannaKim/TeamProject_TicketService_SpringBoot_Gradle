package com.team2.ticket.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team2.ticket.dao.ITicketingDao;

@Service
public class TicketingService {

	@Autowired
	ITicketingDao tdao;
	
	public void ticketingList(HashMap<String, Object> paramMap) {
		tdao.ticketingList(paramMap);
	}
	
	// show, form 에서 동시사용 .
	public void getTProduct(HashMap<String, Object> paramMap) {
		tdao.getTProduct(paramMap);
	}
	public void getchoisDay(HashMap<String, Object> paramMap) {
		tdao.getchoisDay(paramMap);	
	}
	public void insertOrder(HashMap<String, Object> paramMap) {
		tdao.insertOrder(paramMap);	
	}
	public void tclistTicket(HashMap<String, Object> paramMap1) {
		tdao.tclistTicket(paramMap1);	
	}
	
}
