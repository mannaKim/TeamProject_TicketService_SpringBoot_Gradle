package com.team2.ticket.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team2.ticket.dao.IntroduceDao;
import com.team2.ticket.dto.EventVO;
import com.team2.ticket.dto.IntroVO;
import com.team2.ticket.dto.NoticeVO;
import com.team2.ticket.dto.Paging;
import com.team2.ticket.dto.ReplyVO;

@Service
public class IntroduceService {

	@Autowired
	IntroduceDao idao;

	public HashMap<String, Object> getIntro() {
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		IntroVO intro = idao.getIntro();
		
		result.put("intro", intro);
		return result;
	}

	public HashMap<String, Object> getNotice(int page) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		Paging paging = new Paging();
		paging.setDisplayPage(5);
		paging.setDisplayRow(5);
		paging.setPage(page);
		int count = idao.getAllCount();
		paging.setTotalCount(count);
		paging.paging();
		
		List<NoticeVO> nvo = idao.getNotice(paging);
		
		result.put("notice", nvo);
		result.put("paging", paging);
		return result;
	}

	public HashMap<String, Object> noticeView(int ntnum) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		idao.noticeReadcount(ntnum);
		NoticeVO nvo = idao.noticeView(ntnum);
		
		result.put("noticeView", nvo);
		return result;
	}

	public HashMap<String, Object> getEvent() {
		HashMap<String, Object> result = new HashMap<String, Object>();
		List<EventVO> evo = idao.getEvent();
		
		result.put("event", evo);
		return result;
	}

	public void eventDetail(HashMap<String, Object> paramMap) {
		idao.eventReadCount(paramMap);
		idao.getEventView(paramMap);
	}

	public void insertReply(ReplyVO replyvo) {
		idao.insertReply(replyvo);
	}

	public void eventDetailWithoutCount(HashMap<String, Object> paramMap) {
		idao.getEventView(paramMap);
	}

	public void deleteReply(int replynum) {
		idao.deleteReply(replynum);
	}

	public void updateReply(ReplyVO replyvo) {
		idao.updateReply(replyvo);
		
	}

	public HashMap<String, Object> getReply(int replynum) {
		HashMap<String, Object> result = new HashMap<String, Object>();
		ReplyVO rvo = idao.getReply(replynum);
		result.put("reply", rvo);
		return result;
	}
}
