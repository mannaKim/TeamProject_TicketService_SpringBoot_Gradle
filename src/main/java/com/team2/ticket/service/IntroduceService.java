package com.team2.ticket.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.team2.ticket.dao.IntroduceDao;

@Service
public class IntroduceService {

	@Autowired
	IntroduceDao idao;
}
