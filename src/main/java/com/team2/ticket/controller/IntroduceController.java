package com.team2.ticket.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.team2.ticket.service.IntroduceService;

@Controller
public class IntroduceController {

	@Autowired
	IntroduceService ids;
	
	@RequestMapping("/")
	public String index() {
		return "main";
	}
}
