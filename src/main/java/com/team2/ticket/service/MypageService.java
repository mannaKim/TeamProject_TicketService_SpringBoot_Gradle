package com.team2.ticket.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team2.ticket.dao.IMypageDao;
import com.team2.ticket.dto.Paging;

@Service
public class MypageService {

	@Autowired
	IMypageDao mdao;

	public void getTicketList(HashMap<String, Object> paramMap, int page) {
		Paging paging = new Paging();
		paging.setPage(page);
		paging.setDisplayPage(5);
		paging.setDisplayRow(5);
		
		paramMap.put("cnt", 0);
		mdao.mtp_getAllCount(paramMap); 
		int count = Integer.parseInt(paramMap.get("cnt").toString());
		paging.setTotalCount(count); 
		paging.paging(); 
		
		paramMap.put("startNum", paging.getStartNum() );
		paramMap.put("endNum", paging.getEndNum() );
		paramMap.put("paging", paging);
		
		mdao.getTicketList( paramMap );
	}

}
