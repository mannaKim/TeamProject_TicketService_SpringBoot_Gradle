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
import com.team2.ticket.service.GoodsOrderService;
import com.team2.ticket.service.TicketingService;

@Controller
public class TicketingController {

	@Autowired
	TicketingService ts;
	
	@Autowired
	GoodsOrderService os;
	
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
			
			Date c1 = sdate; // ????????????
			Date c2 = edate; // ???????????????
			Date c3 = date; // ????????????
	
			int sday = c1.compareTo(c3);
			int eday = c2.compareTo(c3);
			
			if (sday <= 0 && eday >= 0) {
				model.addAttribute("choisDay", selectedDate);
				model.addAttribute("tpvo", resultMap);
				return "ticketing/ticketingCart";
			} else {
				model.addAttribute("message", "?????? ?????? ??? ????????? ?????? ??????????????????.");
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
			mav.setViewName("ticketing/ticketingCartList");	
		}
		
		return mav;
	}
	
	@RequestMapping("/ticketing")
	public ModelAndView ticketing( 
			HttpServletRequest request, Model model, 
			@RequestParam( "tpseq" ) int tpseq,
			@RequestParam( "choisDay" ) String choisDay,
			@RequestParam( value="use_pnt", required=false ) String dpoint, 
			@RequestParam( value="totalPrice_cc", required=false ) int totalPrice_cc, 
			@RequestParam( value="selectevent", required=false  ) String selectevent,
			@RequestParam( value="quantity1", required=false ) int quantity1,
			@RequestParam( value="quantity2", required=false ) int quantity2 ){
		
		int totalPrice_result = 0;
		if (dpoint != null ) {
			if ( selectevent != null )
				totalPrice_result = totalPrice_cc - Integer.parseInt(dpoint) - Integer.parseInt(selectevent); // ?????? ???????????? = ???????????? - ????????? ?????????	
			else
				totalPrice_result = totalPrice_cc - Integer.parseInt(dpoint);
		} else {
			totalPrice_result = totalPrice_cc - Integer.parseInt(selectevent);
		}
		double Mpoint = totalPrice_result * 0.03;
		
		System.out.println(dpoint + " = dpoint ??????????????? ");
		System.out.println(Mpoint + " = Mpoint ");
		System.out.println(totalPrice_result* 0.03 + " = totalPrice_result* 0.03");
		System.out.println(totalPrice_result + " = totalPrice_result");
		
		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
		if (mvo == null) {
			mav.setViewName("member/loginForm");
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
			mav.setViewName("ticketing/ticketing");
		}
		return mav;
	}

	
}