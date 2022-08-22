package com.team2.ticket.controller;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.team2.ticket.dto.MemberVO;
import com.team2.ticket.service.TicketingService;

@Controller
public class TicketingController {

	@Autowired
	TicketingService ts;
	
	@RequestMapping("/ticketingList")
	public String ticketingList( HttpServletRequest request, Model model ) {
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ref_cursor", null);
		
		ts.ticketingList(paramMap);
		
		ArrayList<HashMap<String, Object>> list 
			= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
		
		model.addAttribute("ticketList", list);
		
		return "ticketing/ticketingList";
	}
	
	@RequestMapping("/ticketshow")
	public ModelAndView ticketshow( 
			HttpServletRequest request, Model model,  
			@RequestParam("tpseq") int tpseq){
		ModelAndView mav = new ModelAndView();
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("tpseq", tpseq );
		paramMap.put("ref_cursor", null );
		
		ts.getTProduct( paramMap );
		
		ArrayList<HashMap<String, Object>> list
		= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
		
		HashMap<String, Object> resultMap = list.get(0);
		
		mav.addObject("tpvo", resultMap );
		mav.setViewName("ticketing/ticketShow");	
		
		return mav;
	}
	
	@RequestMapping("/ticketingForm")
	public ModelAndView ticketingForm( 
			HttpServletRequest request, Model model,  
			@RequestParam("tpseq") int tpseq){
		ModelAndView mav = new ModelAndView();
	
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("tpseq", tpseq );
		paramMap.put("ref_cursor", null );
		
		ts.getTProduct( paramMap );
	
		ArrayList<HashMap<String, Object>> list
			= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
		
		HashMap<String, Object> resultMap = list.get(0);
		
		mav.addObject("tpvo", resultMap );
		mav.setViewName("ticketing/ticketingForm");	
		
		return mav;
	}
	
	@RequestMapping("/ticketingCart")
	public String TicketingCart( 
			HttpServletRequest request, Model model,
			@RequestParam("tpseq") int tpseq,
			@RequestParam("selectedDate") String selectedDate ) throws ParseException{
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
		if (mvo == null) {
			return "member/loginForm";
		} else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("id", mvo.getId() );
			paramMap.put("tpseq", tpseq );
			paramMap.put("ref_cursor", null );
			
			ts.getchoisDay( paramMap );
			
			ArrayList<HashMap<String, Object>> list
			= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
			
			HashMap<String, Object> resultMap = list.get(0);
			
			String dates = "";
			for (HashMap<String, Object> tpvo : list) {
				dates = tpvo.get("SDATE").toString();
			}
			String datee = "";
			for (HashMap<String, Object> tpvo : list) {
				datee = tpvo.get("EDATE").toString();
			}
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date sdate = sdf.parse(dates);
			Date edate = sdf.parse(datee);
			Date date = sdf.parse(selectedDate);
			
			Date c1 = sdate; // 시작날짜
			Date c2 = edate; // 마지막날짜
			Date c3 = date; // 선택날짜
	
			int sday = c1.compareTo(c3);
			int eday = c2.compareTo(c3);
			
			if (sday <= 0 && eday >= 0) {
				model.addAttribute("choisDay", selectedDate);
				model.addAttribute("tpvo", resultMap);
				return "ticketing/ticketingCart";
			} else {
				model.addAttribute("message", "기간 확인 후 날짜를 다시 선택해주세요.");
			}
			return "redirect:/ticketingForm?tpseq="+tpseq;
		}
	}

	@RequestMapping("/ticketingCartList")
	public ModelAndView ticketingCartList( 
			HttpServletRequest request, Model model,  
			@RequestParam("tpseq") int tpseq,
			@RequestParam("choisDay") String choisDay,
			@RequestParam( value="quantity1", required=false ) int quantity1,
			@RequestParam( value="quantity2", required=false ) int quantity2 ){
		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
		if (mvo == null) {
			mav.setViewName("member/loginForm");
		} else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("id", mvo.getId() );
			paramMap.put("tpseq", tpseq );
			paramMap.put("ref_cursor", null );
			
			ts.getTProduct( paramMap );
			
			ArrayList<HashMap<String, Object>> list
				= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
			
			HashMap<String, Object> resultMap = list.get(0);
			
			int totalPrice1 = 0;
			for (HashMap<String, Object> tpvo : list) {
				totalPrice1 += Integer.parseInt(tpvo.get("PRICE1").toString()) * quantity1 ;
			}
			int totalPrice2 = 0;
			for (HashMap<String, Object> tpvo : list) {
				totalPrice2 += Integer.parseInt(tpvo.get("PRICE2").toString()) * quantity2 ;
			}
			int totalPrice3 = totalPrice1 + totalPrice2;
			int selecttotal = quantity1 + quantity2;
			int totalPrice4 = 0; // 최종 할인 금액
			for( HashMap<String, Object> tpvo : list ) {
				if(tpvo.get("PRICE3") != null) // price3(할인금액) null 인경우 오류로인해 if 문 추가
					totalPrice4 = totalPrice3 - (Integer.parseInt(tpvo.get("PRICE3").toString()) * selecttotal);
				else 
					totalPrice4 = totalPrice3;
			}
			mav.addObject("totalPrice1", totalPrice1 );
			mav.addObject("totalPrice2", totalPrice2 );
			mav.addObject("totalPrice3", totalPrice3 );
			mav.addObject("totalPrice4", totalPrice4 );
			mav.addObject("quantity1", quantity1 );
			mav.addObject("quantity2", quantity2 );
			mav.addObject("selecttotal", selecttotal );
			mav.addObject("choisDay", choisDay );
			mav.addObject("tpvo", resultMap );
			mav.setViewName("ticketing/ticketingCartList");	
		}
		
		return mav;
	}
	
	@RequestMapping("/ticketing")
	public ModelAndView ticketing( 
			HttpServletRequest request, Model model, 
			@RequestParam( "tpseq" ) int tpseq,
			@RequestParam( "choisDay" ) String choisDay,
			@RequestParam( value="selectevent", required=false  ) String selectevent,
			@RequestParam( value="quantity1", required=false ) int quantity1,
			@RequestParam( value="quantity2", required=false ) int quantity2 ){
		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
		if (mvo == null) {
			mav.setViewName("member/loginForm");
		} else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("id", mvo.getId() );
			paramMap.put("tpseq", tpseq );
			paramMap.put("choisdate", choisDay );
			paramMap.put("quantity1", quantity1 );
			paramMap.put("quantity2", quantity2 );
			paramMap.put("ref_cursor", null );

			ts.insertOrder( paramMap );
			
			ArrayList<HashMap<String, Object>> list
				= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
			
			HashMap<String, Object> resultMap1 = list.get(0);
			int totalPrice1 = 0;
			for (HashMap<String, Object> tpvo : list) {
				totalPrice1 += Integer.parseInt(tpvo.get("PRICE1").toString()) * quantity1 ;
			}
			int totalPrice2 = 0;
			for (HashMap<String, Object> tpvo : list) {
				totalPrice2 += Integer.parseInt(tpvo.get("PRICE2").toString()) * quantity2 ;
			}
			int totalPrice3 = totalPrice1 + totalPrice2;
			int selecttotal = quantity1 + quantity2; // 어른+어린이 티켓수
			
			int setotal = 0;
			if( selectevent != null ) {
				setotal = totalPrice3 - Integer.parseInt(selectevent);
			}else {
				setotal = totalPrice3; }
			
			mav.addObject("totalPrice1", totalPrice1 );
			mav.addObject("totalPrice2", totalPrice2 );
			mav.addObject("totalPrice3", totalPrice3 );
			mav.addObject("selecttotal", selecttotal );
			mav.addObject("selectevent", selectevent );
			mav.addObject("setotal", setotal );
			mav.addObject("quantity1", quantity1 );
			mav.addObject("quantity2", quantity2 );
			mav.addObject("choisDay", choisDay );
			mav.addObject("tpvo", resultMap1 );
			mav.setViewName("ticketing/ticketing");
		}
		return mav;
	}
	
	
	
}
