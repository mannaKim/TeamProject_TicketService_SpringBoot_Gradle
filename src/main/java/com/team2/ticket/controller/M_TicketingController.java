package com.team2.ticket.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.team2.ticket.dto.MemberVO;
import com.team2.ticket.dto.Paging;
import com.team2.ticket.service.GoodsOrderService;
import com.team2.ticket.service.MemberService;
import com.team2.ticket.service.MypageService;
import com.team2.ticket.service.TicketingService;

@Controller
public class M_TicketingController {

	@Autowired
	TicketingService ts;
	
	@Autowired
	GoodsOrderService os;
	
	@Autowired
	MypageService ms;
	
	@Autowired
	MemberService mem;
	
	@RequestMapping("/m_ticketingList")
	public String m_ticketingList( HttpServletRequest request, Model model ) {
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ref_cursor", null);
		
		ts.ticketingList(paramMap);
		
		ArrayList<HashMap<String, Object>> list 
			= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
		
		model.addAttribute("ticketList", list);
		
		return "mobile/ticketing/m_ticketingList";
	}


	@RequestMapping("/m_ticketshow")
	public ModelAndView m_ticketshow( 
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
		mav.setViewName("mobile/ticketing/m_ticketShow");	
		
		return mav;
	}
	@RequestMapping("/m_ticketingForm")
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
		mav.setViewName("mobile/ticketing/m_ticketingForm");	
		
		return mav;
	}

	@RequestMapping("/m_ticketingCart")
	public String TicketingCart( 
			HttpServletRequest request, Model model,
			@RequestParam("tpseq") int tpseq, @RequestParam("selectedDate") String selectedDate ) throws ParseException{
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
		if (mvo == null) { return "mobile/member/M_loginForm";
		} else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("id", mvo.getId() );
			paramMap.put("tpseq", tpseq );
			paramMap.put("ref_cursor", null );
			ts.getchoisDay( paramMap );
			ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
			HashMap<String, Object> resultMap = list.get(0);
			String dates = ""; // ??????????????? ??????????????? ??????
			for (HashMap<String, Object> tpvo : list) { dates = tpvo.get("SDATE").toString(); }
			String datee = ""; // ????????? ????????? ??????????????? ??????
			for (HashMap<String, Object> tpvo : list) { datee = tpvo.get("EDATE").toString(); }
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date sdate = sdf.parse(dates); // ?????? ?????? ????????? ???????????? ??????
			Date edate = sdf.parse(datee); // ????????? ?????? ????????? ???????????? ?????? 
			Date date = sdf.parse(selectedDate); // ????????? ?????? ????????? ???????????? ??????
			Date c1 = sdate; // ????????????
			Date c2 = edate; // ???????????????
			Date c3 = date; // ????????????
			// a.compareTo(b) = ??????????????? ???????????? ???????????? ????????? ??????.
			// a = b -> 0, a > b -> ??????, a < b -> ????????? ????????????.
			int sday = c1.compareTo(c3); // ?????? ????????? ??????????????? ????????????. 1
			int eday = c2.compareTo(c3); // ????????? ????????? ?????? ????????? ????????????. 0
			// ??????????????? ????????????????????? ??????????????? ??????
			if (sday <= 0 && eday >= 0) {
				model.addAttribute("choisDay", selectedDate);
				model.addAttribute("tpvo", resultMap);
				return "mobile/ticketing/m_ticketingCart";
			} else {
				model.addAttribute("message", "?????? ?????? ??? ????????? ?????? ??????????????????.");
			}
			return "redirect:/m_ticketingForm?tpseq="+tpseq;
		}
	}

	@RequestMapping("/m_ticketingCartList")
	public ModelAndView m_ticketingCartList( 
			HttpServletRequest request, Model model,  
			@RequestParam("tpseq") int tpseq,
			@RequestParam("choisDay") String choisDay,
			@RequestParam( value="quantity1", required=false ) int quantity1,
			@RequestParam( value="quantity2", required=false ) int quantity2 ){
		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
		if (mvo == null) {
			mav.setViewName("mobile/member/M_loginForm");
		} else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("id", mvo.getId() );
			paramMap.put("tpseq", tpseq );
			paramMap.put("ref_cursor", null );
			paramMap.put("ref_cursor2", null );
			
			ts.getTProduct2( paramMap );
			
			ArrayList<HashMap<String, Object>> list
				= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
			
			ArrayList<HashMap<String, Object>> pointlist
				= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor2");
			
			HashMap<String, Object> resultMap = list.get(0);
			
			int totalPrice1 = 0; // ?????? ?????? * ????????????
			for (HashMap<String, Object> tpvo : list) {
				totalPrice1 += Integer.parseInt(tpvo.get("PRICE1").toString()) * quantity1 ;
			}
			int totalPrice2 = 0; // ????????? ?????? * ????????????
			for (HashMap<String, Object> tpvo : list) {
				totalPrice2 += Integer.parseInt(tpvo.get("PRICE2").toString()) * quantity2 ;
			}
			int totalPrice3 = totalPrice1 + totalPrice2; // ????????????(?????????) = ???????????? ?????? + ??????????????? ??????
			int selecttotal = quantity1 + quantity2; // ?????? ?????? ?????? = ?????? ???????????? + ????????? ????????????
			int totalPrice4 = 0; // ?????? ?????? ??????
			for( HashMap<String, Object> tpvo : list ) {
				if(tpvo.get("PRICE3") != null) // price3(????????????) null ????????? ??????????????? if ??? ??????
					totalPrice4 = totalPrice3 - (Integer.parseInt(tpvo.get("PRICE3").toString()) * selecttotal);
				else 
					totalPrice4 = totalPrice3;
			}
		
			//double MPoint1 = totalPrice3 * 0.03; // ?????? ?????? ?????? x 0.03 = ????????? ????????? 
			//double MPoint2 = totalPrice4 * 0.03; // ?????? ????????? ?????? x 0.03 = ????????? ????????? 
			
			mav.addObject("userPoint", pointlist.get(0)); // ??????????????? ?????????
			
			mav.addObject("totalPrice1", totalPrice1 );
			mav.addObject("totalPrice2", totalPrice2 );
			mav.addObject("totalPrice3", totalPrice3 );
			mav.addObject("totalPrice4", totalPrice4 );
			mav.addObject("quantity1", quantity1 );
			mav.addObject("quantity2", quantity2 );
			mav.addObject("selecttotal", selecttotal );
			mav.addObject("choisDay", choisDay );
			mav.addObject("tpvo", resultMap );
			mav.setViewName("mobile/ticketing/m_ticketingCartList");	
		}
		
		return mav;
	}
	
	@RequestMapping("/m_ticketing")
	public ModelAndView ticketing( 
			HttpServletRequest request, Model model, 
			@RequestParam( "tpseq" ) int tpseq,
			@RequestParam( "choisDay" ) String choisDay,
			@RequestParam( "use_pnt" ) int dpoint, 
			@RequestParam( value="totalPrice_cc", required=false ) int totalPrice_cc, 
			@RequestParam( value="selectevent", required=false  ) String selectevent,
			@RequestParam( value="quantity1", required=false ) int quantity1,
			@RequestParam( value="quantity2", required=false ) int quantity2 ){
		
		int totalPrice_result = totalPrice_cc - dpoint - Integer.parseInt(selectevent); // ?????? ???????????? = ???????????? - ????????? ????????? - ????????????
		double Mpoint = totalPrice_result * 0.03;
		/*
		if( selectevent != null ) { // select ??? null ?????? ????????? null ??????????????? ???????????? ??????.
			if( Integer.parseInt(selectevent) == 0 ) {
				Mpoint = ( totalPrice_result * 0.03 ) - ( dpoint * 0.03 );  // ?????? ????????? = ?????? ??? ????????? - ????????? ?????????
			} else {
				Mpoint = ( totalPrice_result * 0.03 ) - ( Integer.parseInt(selectevent) * 0.03 ) - ( dpoint * 0.03 ); 
			}
		} else {
			Mpoint = ( totalPrice_result * 0.03 ) - ( dpoint * 0.03 ); // ???????????? ????????? ????????? 
		}*/
		
		System.out.println(dpoint + " = dpoint ??????????????? ");
		System.out.println(Mpoint + " = Mpoint ");
		System.out.println(totalPrice_result* 0.03 + " = totalPrice_result* 0.03");
		System.out.println(totalPrice_result + " = totalPrice_result");
		System.out.println(Integer.parseInt(selectevent)* 0.03 + " = selectevent* 0.03");
		System.out.println(Integer.parseInt(selectevent) + " = selectevent");
		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
		if (mvo == null) {
			mav.setViewName("mobile/member/M_loginForm");
		} else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("id", mvo.getId() );
			
			paramMap.put("Mpoint", (int)Mpoint );
			paramMap.put("dpoint", dpoint );
			
			paramMap.put("tpseq", tpseq );
			paramMap.put("choisdate", choisDay );
			paramMap.put("quantity1", quantity1 );
			paramMap.put("quantity2", quantity2 );
			paramMap.put("ref_cursor", null );

			ts.insertOrder( paramMap );
			
			os.deletePoint(paramMap); // ?????? ?????????
			os.updatePoint(paramMap); // ?????? ?????????
			
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
			int selecttotal = quantity1 + quantity2; // ??????+????????? ?????????
			
			int setotal = 0;
			if( selectevent != null ) {
				setotal = totalPrice3 - Integer.parseInt(selectevent);
			} else {
				setotal = totalPrice3; 
			}
			
			mav.addObject("Mpoint", Mpoint); // ???????????? ????????? ??? .
			mav.addObject("dpoint", dpoint); // ????????? ????????? ??? .
			mav.addObject("totalPrice_result", totalPrice_result);
			
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
			mav.setViewName("mobile/ticketing/m_ticketing");
		}
		return mav;
	}
	
	@RequestMapping("/m_ticketCartList")
	public String ticketCartList( HttpServletRequest request, Model model ){
		
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
		if (mvo == null) {
			return "mobile/member/M_loginForm";
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
			
			MemberVO member = mem.getMember(mvo.getId());
			session.setAttribute("loginUser", member);
			
			return "mobile/mypage/m_ticketCartList";
		}
	}	
	@RequestMapping("/m_ticketShowMypage")
	public String ticketShowMypage( 
			HttpServletRequest request, Model model,
			@RequestParam("tpseq") int tpseq){
		
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
		if (mvo == null) {
			return "mobile/member/M_loginForm";
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
			
			return "mobile/mypage/m_ticketShowMypage";
		}
	}	

	
}
