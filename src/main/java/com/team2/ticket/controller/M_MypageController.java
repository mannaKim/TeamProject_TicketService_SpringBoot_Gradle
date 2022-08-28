package com.team2.ticket.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.team2.ticket.service.MypageService;
import com.team2.ticket.service.TicketingService;

@Controller
public class M_MypageController {

	@Autowired
	MypageService ms;
	
	@Autowired
	TicketingService ts;
	
	@RequestMapping("/Mmypage")
	public String mypage(HttpServletRequest request, Model model) {
		return "mobile/mypage/M_goodsCartList";
	}
}
