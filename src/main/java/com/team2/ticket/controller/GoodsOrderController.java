package com.team2.ticket.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.team2.ticket.dto.GoodsOrderVO;
import com.team2.ticket.dto.MemberVO;
import com.team2.ticket.dto.Paging;
import com.team2.ticket.service.GoodsOrderService;
import com.team2.ticket.service.GoodsService;
import com.team2.ticket.service.MemberService;

@Controller
public class GoodsOrderController {

	@Autowired
	GoodsOrderService os;
	
	@Autowired
	GoodsService gs;
	
	@Autowired
	MemberService ms;
	
	@RequestMapping("/goodsOrderCheck")
	public ModelAndView goods_order_check(HttpServletRequest request,
			@RequestParam("gcseq") int [] gcseqArr, @RequestParam("point") double Mpoint,
			@RequestParam("totalPrice2") String totalprice2, @RequestParam("dpoint") int dpoint) {
		ModelAndView mav =  new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null)
			mav.setViewName("member/loginForm");
		else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			// 추가내용3줄
			paramMap.put("id", loginUser.getId());
			paramMap.put("Mpoint", (int)Mpoint);
			paramMap.put("dpoint", dpoint);
			
			paramMap.put("ref_cursor", null);
			
			paramMap.put("gcseqArr", gcseqArr);
			os.listGoodsCartToBuy(paramMap);
			os.deletePoint(paramMap); // 차감 포인트
			os.updatePoint(paramMap); // 적립 포인트
			
			ArrayList<HashMap<String, Object>> goodsCartListToBuy
				= (ArrayList<HashMap<String, Object>>)paramMap.get("goodsCartListToBuy");
			
			int totalPrice = 0;
			for(HashMap<String,Object> cart : goodsCartListToBuy) {
				totalPrice += Integer.parseInt(cart.get("QUANTITY").toString())
									* Integer.parseInt(cart.get("PRICE").toString());
			}
			
			mav.addObject("totalprice2", totalprice2);
			mav.addObject("totalPrice", totalPrice);
			mav.addObject("Mpoint", (int)Mpoint);
			mav.addObject("goodsCartListToBuy", goodsCartListToBuy);
			session.setAttribute("goodsCartListToBuy", goodsCartListToBuy);
			mav.setViewName("mypage/goodsOrderCheck");
		}
		return mav;
	}
	
	@RequestMapping("/goodsOrderInsert")
	public String goods_order_insert(HttpServletRequest request, Model model,
			@RequestParam("gcseq") int [] gcseqArr, @RequestParam(value="totalprice2", required=false) String totalprice2,
			@Valid GoodsOrderVO goodsordervo, BindingResult result) {
		String url = "mypage/goodsOrderCheck";
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null)
			return "member/loginForm";
		else {
			if(result.getFieldError("name")!=null) 
				model.addAttribute("message", result.getFieldError("name").getDefaultMessage());
			else if(result.getFieldError("phone")!=null) 
				model.addAttribute("message", result.getFieldError("phone").getDefaultMessage());
			else if(result.getFieldError("zip_num")!=null) 
				model.addAttribute("message", result.getFieldError("zip_num").getDefaultMessage());
			else if(result.getFieldError("payment")!=null) 
				model.addAttribute("message", result.getFieldError("payment").getDefaultMessage());
			else {
				session.removeAttribute("goodsCartListToBuy");
				HashMap<String,Object> paramMap = new HashMap<String,Object>();
				paramMap.put("totalprice2", (Integer.parseInt(totalprice2.toString())));
				paramMap.put("id", loginUser.getId());
				paramMap.put("payment", goodsordervo.getPayment());
				paramMap.put("goseq", 0);
				paramMap.put("name", goodsordervo.getName());
				paramMap.put("phone", goodsordervo.getPhone());
				paramMap.put("zip_num", goodsordervo.getZip_num());
				paramMap.put("address1", goodsordervo.getAddress1());
				paramMap.put("address2", goodsordervo.getAddress2());
				paramMap.put("address3", goodsordervo.getAddress3());
				os.insertGoodsOrder(paramMap, gcseqArr);
				String goseq = paramMap.get("goseq").toString();
				MemberVO mvo = ms.getMember(loginUser.getId());
				session.setAttribute("loginUser", mvo);
				url = "redirect:/goodsOrderList?goseq="+goseq;
			}	
		}
		return url;
	}
	
	@RequestMapping("/goodsOrderList")
	public ModelAndView goods_order_list(HttpServletRequest request, 
			@RequestParam("goseq") int goseq) {
		ModelAndView mav =  new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null)
			mav.setViewName("member/loginForm");
		else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("ref_cursor", null);
			paramMap.put("ref_cursor2", null);
			paramMap.put("goseq", goseq);
			os.listGoodsOrder(paramMap);
			
			ArrayList<HashMap<String, Object>> list
				= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
			ArrayList<HashMap<String, Object>> list2
				= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor2");
			mav.addObject("goodsOrderList", list);
			mav.addObject("totalGoods", list2.get(0));
			int totalPrice = 0;
			int payment = 0;
			for(HashMap<String,Object> order : list) {
				totalPrice += Integer.parseInt(order.get("QUANTITY").toString())
									* Integer.parseInt(order.get("PRICE").toString());
				payment = Integer.parseInt(order.get("PAYMENT").toString());
			}
			mav.addObject("totalPrice", totalPrice);
			
			String [] paymentList = {"신용카드","휴대폰결제","계좌이체","가상계좌"};
			mav.addObject("payment", paymentList[payment]);
			
			mav.setViewName("mypage/goodsOrderList");
		}
		return mav;
	}
	
	@RequestMapping("/goodsOrderCheckOne")
	public ModelAndView goods_order_check_one(HttpServletRequest request,
			@RequestParam("gseq") int gseq,
			@RequestParam("quantity") int quantity) {
		ModelAndView mav =  new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null)
			mav.setViewName("member/loginForm");
		else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("gseq", gseq);
			paramMap.put("ref_cursor", null);
			paramMap.put("ref_cursor2", null);
			gs.getGoods(paramMap);
			ArrayList<HashMap<String, Object>> list
				= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
			HashMap<String, Object> resultMap = list.get(0);
			
			int totalPrice = quantity * Integer.parseInt(resultMap.get("PRICE2").toString());
			double MPoint = 0;
			MPoint = (int)totalPrice * 0.05;
			mav.addObject("quantity", quantity);
			mav.addObject("totalPrice", totalPrice);
			mav.addObject("Mpoint", MPoint);
			mav.addObject("goodsVO", resultMap);
			session.setAttribute("totalPrice", totalPrice);
			session.setAttribute("goodsVO", resultMap);
			mav.setViewName("mypage/goodsOrderCheckOne");
		}
		return mav;
	}
	
	@RequestMapping("/goodsOrderInsertOne")
	public String goods_order_insert_one(HttpServletRequest request, Model model,
			@RequestParam("gseq") int gseq,
			@RequestParam("quantity") int quantity, @RequestParam(value="totalPrice2", required=false) String totalprice2,
			@RequestParam("Mpoint") double Mpoint, @RequestParam("dpoint") int dpoint,
			@Valid GoodsOrderVO goodsordervo,
			BindingResult result) {
		String url = "mypage/goodsOrderCheckOne";
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null)
			return "member/loginForm";
		else {
			if(result.getFieldError("name")!=null) 
				model.addAttribute("message", result.getFieldError("name").getDefaultMessage());
			else if(result.getFieldError("phone")!=null) 
				model.addAttribute("message", result.getFieldError("phone").getDefaultMessage());
			else if(result.getFieldError("zip_num")!=null) 
				model.addAttribute("message", result.getFieldError("zip_num").getDefaultMessage());
			else if(result.getFieldError("payment")!=null) 
				model.addAttribute("message", result.getFieldError("payment").getDefaultMessage());
			else {
				session.removeAttribute("goodsVO");
				HashMap<String,Object> paramMap = new HashMap<String,Object>();
				paramMap.put("totalprice2", (Integer.parseInt(totalprice2.toString())));
				paramMap.put("Mpoint", (int)Mpoint);
				paramMap.put("dpoint", dpoint);
				paramMap.put("id", loginUser.getId());
				paramMap.put("payment", goodsordervo.getPayment());
				paramMap.put("goseq", 0);
				paramMap.put("gseq", gseq);
				paramMap.put("quantity", quantity);
				paramMap.put("name", goodsordervo.getName());
				paramMap.put("phone", goodsordervo.getPhone());
				paramMap.put("zip_num", goodsordervo.getZip_num());
				paramMap.put("address1", goodsordervo.getAddress1());
				paramMap.put("address2", goodsordervo.getAddress2());
				paramMap.put("address3", goodsordervo.getAddress3());
				os.insertGoodsOrderOne(paramMap);
				os.deletePoint(paramMap); // 차감 포인트
				os.updatePoint(paramMap); // 적립 포인트
				String goseq = paramMap.get("goseq").toString();
				MemberVO mvo = ms.getMember(loginUser.getId());
				session.setAttribute("loginUser", mvo);
				url = "redirect:/goodsOrderList?goseq="+goseq;
			}
		}
		return url;
	}
	
	@RequestMapping("/allGoodsOrderList")
	public ModelAndView all_goods_order_list(HttpServletRequest request) {
		ModelAndView mav =  new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null)
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
			
			HashMap<String,Object> paramMap = new HashMap<String,Object>();
			paramMap.put("id", loginUser.getId());
			paramMap.put("ref_cursor", null);
			os.listGoodsOrderAll(paramMap, page);
			
			ArrayList<HashMap<String, Object>> finalList
				= (ArrayList<HashMap<String, Object>>)paramMap.get("finalList");
			mav.addObject("allGoodsOrderList", finalList);
			
			mav.addObject("title", "전체 주문 내역");
			mav.addObject("paging", (Paging)paramMap.get("paging"));
			mav.setViewName("mypage/allGoodsOrderList");
		}
		return mav;
	}
	
	@RequestMapping("/goodsOrderDetail")
	public ModelAndView goods_order_detail(HttpServletRequest request,
			@RequestParam("goseq") int goseq) {
		ModelAndView mav =  new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null)
			mav.setViewName("member/loginForm");
		else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("goseq", goseq);
			paramMap.put("ref_cursor", null);
			os.listGoodsOrder(paramMap);
			
			ArrayList<HashMap<String, Object>> list
				= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
			
			int totalPrice = 0;
			for(HashMap<String,Object> order : list) {
				totalPrice += Integer.parseInt(order.get("QUANTITY").toString())
									* Integer.parseInt(order.get("PRICE").toString());
			}
			
			int payment = Integer.parseInt(list.get(0).get("PAYMENT").toString());
			String [] paymentList = {"신용카드","휴대폰결제","계좌이체","가상계좌"};
			
			mav.addObject("payment", paymentList[payment]);
			mav.addObject("goodsOrderList", list);
			mav.addObject("totalPrice", totalPrice);
			mav.addObject("goodsOrderDetail", list.get(0));
			mav.setViewName("mypage/goodsOrderDetail");
		}
		return mav;
	}
}
