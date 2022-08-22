package com.team2.ticket.service;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team2.ticket.dao.IMemberDao;
import com.team2.ticket.dto.MemberVO;

@Service
public class MemberService {

	@Autowired
	IMemberDao mdao;

	public MemberVO getMember(String id) {
		return mdao.getMember(id);
	}

	public void insertMember(MemberVO membervo) {
		mdao.insertMember(membervo);
	}

	public void updateMember(MemberVO membervo) {
		mdao.updateMember(membervo);
	}

	public void deleteMember(String id) {
		mdao.deleteMember(id);
	}

	public MemberVO getNameMember(String name) {
		return mdao.getNameMember(name);
	}

	public void resetPwd(MemberVO mvo) {
		mdao.resetPwd(mvo);
	}

	public int getOrderNum(String id) {
		return mdao.getOrderNum(id);
	}
}
