package com.team2.ticket.dao;

import org.apache.ibatis.annotations.Mapper;

import com.team2.ticket.dto.MemberVO;

@Mapper
public interface IMemberDao {

	public MemberVO getMember(String id);

}
