package com.team2.ticket.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.team2.ticket.dto.MemberVO;
import com.team2.ticket.dto.Paging;
import com.team2.ticket.service.AdminGoodsService;

@Controller
public class AdminGoodsController {
	@Autowired
	AdminGoodsService as;
	
	@RequestMapping("/adminGoodsList")
	public ModelAndView admin_goods_list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null || loginUser.getAdmin()!=1)
			mav.setViewName("member/loginForm");
		else {
			int page = 1;
			if(request.getParameter("page")!=null) {
				page = Integer.parseInt(request.getParameter("page"));
				session.setAttribute("page", page);
			}else if(session.getAttribute("page")!=null) {
				page = (Integer)session.getAttribute("page");
			}else {
				session.removeAttribute("page");
			}
			
			String key = "";
			if(request.getParameter("key")!=null) {
				key = request.getParameter("key");
				session.setAttribute("key", key);
			}else if(session.getAttribute("key")!=null) {
				key = (String)session.getAttribute("key");
			}else {
				session.removeAttribute("key");
			}
			
			HashMap<String,Object> paramMap = new HashMap<String,Object>();
			paramMap.put("ref_cursor", null);
			
			if(request.getParameter("kind")!=null) {
				paramMap.put("kind", (String)request.getParameter("kind"));
				as.getAdminGoodsKindList(paramMap, page);
				ArrayList<HashMap<String, Object>> list
					= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
				mav.addObject("goodsList", list);
				mav.addObject("kind", (String)request.getParameter("kind"));
			}
			else {
				paramMap.put("key", key);
				as.getAdminGoodsSearchList(paramMap, page);
				ArrayList<HashMap<String,Object>> list
					= (ArrayList<HashMap<String,Object>>)paramMap.get("ref_cursor");
				mav.addObject("key", key);
				mav.addObject("goodsList", list);
			}
			String [] goodsKindList = {"","문구","디지털","가방 · 파우치","취미용품","패션 · 잡화"};
			mav.addObject("goodsKindList", goodsKindList);
			mav.addObject("paging", (Paging)paramMap.get("paging"));
			mav.setViewName("admin/goods/goodsList");
		}
		return mav;
	}
}
