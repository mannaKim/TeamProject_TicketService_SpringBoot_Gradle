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

import com.team2.ticket.dto.MemberVO;
import com.team2.ticket.dto.Paging;
import com.team2.ticket.service.MypageService;
import com.team2.ticket.service.TicketingService;

@Controller
public class MypageController {

	@Autowired
	MypageService ms;
	
	@Autowired
	TicketingService ts;
	
//	@RequestMapping("/mypage")
//	public String mypage( ){
//		return "redirect:/ticketCartList";
//	}
		
	
	@RequestMapping("/ticketCartList")
	public String ticketCartList( HttpServletRequest request, Model model ){
		
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
		if (mvo == null) {
			return "member/loginForm";
		} else {
			
			int page = 1;
			if (request.getParameter("page") != null) {
				page = Integer.parseInt(request.getParameter("page"));
				session.setAttribute("page", page);
			} else if (session.getAttribute("page") != null) {
				page = (Integer) session.getAttribute("page");
			} else {
				session.removeAttribute("page");
			}
			
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("id", mvo.getId() );
			paramMap.put("ref_cursor", null );
			
			ms.getTicketList( paramMap, page );

			ArrayList<HashMap<String, Object>> list
				= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
			
			model.addAttribute("tclist", list);
			model.addAttribute("paging",(Paging)paramMap.get("paging"));
			
			return "mypage/ticketCartList";
		}
	}	
	@RequestMapping("/ticketShowMypage")
	public String ticketShowMypage( 
			HttpServletRequest request, Model model,
			@RequestParam("tpseq") int tpseq){
		
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
		if (mvo == null) {
			return "member/loginForm";
		} else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("id", mvo.getId() );
			paramMap.put("tpseq", tpseq );
			paramMap.put("ref_cursor", null );
			
			ts.getTProduct( paramMap );
			
			ArrayList<HashMap<String, Object>> list
				= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
			
			HashMap<String, Object> resultMap = list.get(0);
			
			model.addAttribute("tpvo", resultMap);
			
			return "mypage/ticketShowMypage";
		}
	}	
	
}
