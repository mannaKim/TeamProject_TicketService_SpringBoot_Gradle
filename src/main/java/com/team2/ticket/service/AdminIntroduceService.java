package com.team2.ticket.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team2.ticket.dao.IAdminIntroduceDao;
import com.team2.ticket.dto.MemberVO;
import com.team2.ticket.dto.NoticeVO;
import com.team2.ticket.dto.Paging;

@Service
public class AdminIntroduceService {

	@Autowired
	IAdminIntroduceDao aidao;

	public void getAdminNotice(HashMap<String, Object> paramMap, int page, String key) {
		Paging paging = new Paging();
		paging.setDisplayPage(5);
		paging.setDisplayRow(5);
		paging.setPage(page);
		HashMap<String, Object> cntMap = new HashMap<String, Object>();
		cntMap.put("cnt", 0);
		cntMap.put("introName", 1);
		
		cntMap.put("key", key);
		aidao.adminIntroAllCount(cntMap);
		int count = Integer.parseInt(cntMap.get("cnt").toString());
		paging.setTotalCount(count);
		paging.paging();
		
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		aidao.getAdminNotice(paramMap);
		paramMap.put("paging", paging);
	}

	public void getAdminNoticeView(HashMap<String, Object> paramMap) {
		aidao.getAdminNoticeView(paramMap);
	}

	public void insertAdminNotice(HashMap<String, Object> paramMap) {
		aidao.insertAdminNotice(paramMap);
	}

	public void deleteNotice(HashMap<String, Object> paramMap) {
		aidao.deleteNotice(paramMap);
	}

	public void adminUpdateNotice(HashMap<String, Object> paramMap) {
		aidao.adminUpdateNotice(paramMap);
		
	}

	public void getAdminUser(HashMap<String, Object> paramMap, int page) {
		Paging paging = new Paging();
		paging.setDisplayPage(10);
		paging.setDisplayRow(10);
		paging.setPage(page);
		paramMap.put("cnt", 0);
		paramMap.put("tableName", 2);
		aidao.adminEventAllCount(paramMap);
		int count = (Integer)paramMap.get("cnt");
		paging.setTotalCount(count);
		paging.paging();
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		aidao.getAdminUser(paramMap);
		paramMap.put("paging", paging);	
	}

	public void getEventList(HashMap<String, Object> paramMap, int page) {
		Paging paging = new Paging();
		paging.setDisplayPage(5);
		paging.setDisplayRow(5);
		paging.setPage(page);
		paramMap.put("cnt", 0);
		paramMap.put("tableName", 1);
		
		aidao.adminEventAllCount(paramMap);
		int count = (Integer)paramMap.get("cnt");
		paging.setTotalCount(count);
		paging.paging();
		
		paramMap.put("startNum", paging.getStartNum());
		paramMap.put("endNum", paging.getEndNum());
		aidao.getEventList(paramMap);
		paramMap.put("paging", paging);	
	}

	public void insertEvent(HashMap<String, Object> paramMap) {
		aidao.insertEvent(paramMap);
	}

	public void getAdminEventView(HashMap<String, Object> paramMap) {
		aidao.getAdminEventView(paramMap);
		
	}

	public void deleteEvent(HashMap<String, Object> paramMap) {
		aidao.deleteEvent(paramMap);
	}

	public void updateAdminEvent(HashMap<String, Object> paramMap) {
		aidao.updateAdminEvent(paramMap);
	}

	public void adminMember(HashMap<String, Object> paramMap) {
		aidao.adminMember(paramMap);
	}

	public void getAdminUserPage(HashMap<String, Object> paramMap) {
		aidao.getAdminUserPage(paramMap);
	}

	public void adminPointUpdate(MemberVO membervo) {
		aidao.adminPointUpdate(membervo);
		
	}

}
