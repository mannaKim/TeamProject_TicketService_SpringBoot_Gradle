package com.team2.ticket.service;

import javax.validation.constraints.NotNull;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team2.ticket.dao.IMypageMemberDao;

@Service
public class MypageMemberService {
	@Autowired
	IMypageMemberDao mdao;

	public int getOrderNum(String id) {
		return mdao.getOrderNum(id);
	}

	public void deleteMember(String id) {
		mdao.deleteMember(id);
	}
}
