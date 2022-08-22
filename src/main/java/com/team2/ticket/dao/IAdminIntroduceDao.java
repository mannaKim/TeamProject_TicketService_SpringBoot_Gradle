package com.team2.ticket.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.team2.ticket.dto.MemberVO;
import com.team2.ticket.dto.NoticeVO;

@Mapper
public interface IAdminIntroduceDao {

	public void adminIntroAllCount(HashMap<String, Object> cntMap);
	public void getAdminNotice(HashMap<String, Object> paramMap);
	public void getAdminNoticeView(HashMap<String, Object> paramMap);
	public void insertAdminNotice(HashMap<String, Object> paramMap);
	public void deleteNotice(HashMap<String, Object> paramMap);
	public void adminUpdateNotice(HashMap<String, Object> paramMap);
	public void getAdminUser(HashMap<String, Object> paramMap);
	public void getEventList(HashMap<String, Object> paramMap);
	public void insertEvent(HashMap<String, Object> paramMap);
	public void getAdminEventView(HashMap<String, Object> paramMap);
	public void deleteEvent(HashMap<String, Object> paramMap);
	public void updateAdminEvent(HashMap<String, Object> paramMap);
	public void adminEventAllCount(HashMap<String, Object> paramMap);
	public void adminMember(HashMap<String, Object> paramMap);
	public void getAdminUserPage(HashMap<String, Object> paramMap);
	public void adminPointUpdate(MemberVO membervo);

}
