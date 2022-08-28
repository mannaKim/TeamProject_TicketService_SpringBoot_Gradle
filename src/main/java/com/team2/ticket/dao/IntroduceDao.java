package com.team2.ticket.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.team2.ticket.dto.EventVO;
import com.team2.ticket.dto.IntroVO;
import com.team2.ticket.dto.NoticeVO;
import com.team2.ticket.dto.Paging;
import com.team2.ticket.dto.ReplyVO;

@Mapper
public interface IntroduceDao {

	public IntroVO getIntro();
	public List<NoticeVO> getNotice(Paging paging);
	public void noticeReadcount(int ntnum);
	public NoticeVO noticeView(int ntnum);
	public List<EventVO> getEvent();
	public void eventReadCount(HashMap<String, Object> paramMap);
	public void getEventView(HashMap<String, Object> paramMap);
	public void insertReply(ReplyVO replyvo);
	public void deleteReply(int replynum);
	public void updateReply(ReplyVO replyvo);
	public ReplyVO getReply(int replynum);
	public int getAllCount();
	public void getTicketMain(HashMap<String, Object> paramMap);

}
