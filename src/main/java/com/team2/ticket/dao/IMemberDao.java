package com.team2.ticket.dao;

import org.apache.ibatis.annotations.Mapper;

import com.team2.ticket.dto.MemberVO;

@Mapper
public interface IMemberDao {

	public MemberVO getMember(String id);

	public void insertMember(MemberVO membervo);

	public void updateMember(MemberVO membervo);

	public void deleteMember(String id);

	public MemberVO getNameMember(String name);

	public void resetPwd(MemberVO mvo);

	public int getOrderNum(String id);

}
