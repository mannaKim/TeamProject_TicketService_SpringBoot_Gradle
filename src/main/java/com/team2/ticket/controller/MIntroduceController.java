package com.team2.ticket.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.team2.ticket.service.GoodsService;
import com.team2.ticket.service.IntroduceService;

@Controller
public class MIntroduceController {

	@Autowired
	IntroduceService ids;
	
	@Autowired
	GoodsService gs;
	
	@RequestMapping("/mobilemain")
	public String index(HttpServletRequest request, Model model) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ref_cursor", null);
		ids.getTieketMain(paramMap);
		ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		model.addAttribute("ticketList", list);
		
		paramMap.put("ref_cursor", null);
		gs.getMobileGoodsBanner(paramMap);
		ArrayList<HashMap<String, Object>> list2
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		model.addAttribute("goodsBannerList", list2);
		return "mobile/mobilemain";
	}
}
