package com.team2.ticket.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.team2.ticket.dto.Paging;
import com.team2.ticket.service.GoodsService;

@Controller
public class GoodsController {
	@Autowired
	GoodsService gs;
	
	@RequestMapping("/goodsMain")
	public String goods_main(HttpServletRequest request, Model model) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ref_cursor1", null);
		paramMap.put("ref_cursor2", null);
		gs.getBestNewGoods(paramMap);
		
		ArrayList<HashMap<String, Object>> list1
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor1");
		ArrayList<HashMap<String, Object>> list2
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor2");
		model.addAttribute("bestGoodsList", list1);
		model.addAttribute("newGoodsList", list2);
		
		return "goods/goodsMain";
	}
}
