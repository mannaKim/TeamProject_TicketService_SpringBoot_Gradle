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
import com.team2.ticket.service.MypageService;
import com.team2.ticket.service.TicketingService;

@Controller
public class M_MypageController {

	@Autowired
	MypageService ms;
	
	@Autowired
	MemberService mem;
	
	@Autowired
	TicketingService ts;
	
	@Autowired
	GoodsService gs;
	
	@Autowired
	GoodsOrderService os;
	
	@RequestMapping("/m_mypage")
	public String mypage(HttpServletRequest request, Model model) {
		return "redirect:/m_goodsCartList";
	}
	
	@RequestMapping("/m_goodsCartInsert")
	public String goods_cart_insert(HttpServletRequest request,
			@RequestParam("gseq") int gseq,
			@RequestParam("quantity") int quantity) {
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null)
			return "mobile/member/M_loginForm";
		else {
			gs.insertGoodsCart(loginUser.getId(), gseq, quantity);
		}
		return "redirect:/m_goodsCartList";
	}
	
	@RequestMapping("/m_goodsCartList")
	public ModelAndView goods_cart_list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null)
			mav.setViewName("mobile/member/M_loginForm");
		else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("id", loginUser.getId());
			paramMap.put("ref_cursor", null);
			paramMap.put("ref_cursor2", null);
			gs.listGoodsCart(paramMap);
			
			ArrayList<HashMap<String,Object>> cartList
				= (ArrayList<HashMap<String,Object>>)paramMap.get("ref_cursor");
			ArrayList<HashMap<String, Object>> pointList 
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor2");
			
			// 카트에서 수량조절을 위해 getGoods메서드로 재고를 가져옴
			for(int i=0; i<cartList.size(); i++) {
				HashMap<String,Object> cart = cartList.get(i);
				HashMap<String, Object> pMap = new HashMap<String, Object>();
				pMap.put("gseq", cart.get("GSEQ"));
				pMap.put("ref_cursor", null);
				gs.getGoods(pMap);
				ArrayList<HashMap<String, Object>> goods
					= (ArrayList<HashMap<String, Object>>)pMap.get("ref_cursor");
				HashMap<String, Object> goodsDetail = goods.get(0);
				cart.put("NUM_INVENTORY", goodsDetail.get("NUM_INVENTORY"));
				cartList.set(i, cart);
			}
			
			int totalPrice = 0;
			double MPoint = 0;
			for(HashMap<String,Object> cart : cartList) {
				totalPrice += Integer.parseInt(cart.get("QUANTITY").toString())
									* Integer.parseInt(cart.get("PRICE").toString());
			}
			MPoint = (int)totalPrice * 0.05;
			mav.addObject("goodsCartList", cartList);
			mav.addObject("userPoint", pointList.get(0));
			mav.addObject("totalPrice", totalPrice);
			mav.addObject("Mpoint", MPoint);
			mav.setViewName("mobile/mypage/m_goodsCartList");
		}
		return mav;
	}
	
	@RequestMapping("/m_goodsCartDelete")
	public String goods_cart_delete(HttpServletRequest request,
			@RequestParam("gcseq") int [] gcseqArr) {
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null)
			return "mobile/member/M_loginForm";
		else {
			gs.deleteGoodsCart(gcseqArr);
		}
		return "redirect:/m_goodsCartList";
	}
	
	@RequestMapping("/m_goodsOrderCheck")
	public ModelAndView goods_order_check(HttpServletRequest request,
			@RequestParam("gcseq") int [] gcseqArr, 
			@RequestParam("use_pnt") int dpoint, // goodsCartList.jsp 에서  사용한 포인트.
			@RequestParam("totalPrice1") int totalPrice1){ // goodsCartList.jsp 에서 결제해야할 상품 금액
		
		// goodsCartList.jsp 에서 넘겨준 포인트(use_pnt)를가지고 계산되는 계산식. 
		int totalprice2 = totalPrice1 - dpoint; // 최종 결제금액 = 결제금액 - 사용할 포인트
		double Mpoint = ( totalPrice1 * 0.05 ) - ( dpoint * 0.05 ); // 최종 포인트 = 적립 총 포인트 - 사용할 포인트
		
		ModelAndView mav =  new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null)
			mav.setViewName("mobile/member/M_loginForm");
		else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			
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
			mav.setViewName("mobile/mypage/m_goodsOrderCheck");
		}
		return mav;
	}
	
	@RequestMapping("/m_goodsOrderInsert")
	public String goods_order_insert(HttpServletRequest request, Model model,
			@RequestParam("gcseq") int [] gcseqArr, @RequestParam(value="totalprice2", required=false) String totalprice2,
			@Valid GoodsOrderVO goodsordervo, BindingResult result) {
		String url = "mobile/mypage/m_goodsOrderCheck";
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null)
			return "mobile/member/M_loginForm";
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
				MemberVO mvo = mem.getMember(loginUser.getId());
				session.setAttribute("loginUser", mvo);
				url = "redirect:/m_goodsOrderList?goseq="+goseq;
			}	
		}
		return url;
	}
	
	@RequestMapping("/m_goodsOrderList")
	public ModelAndView goods_order_list(HttpServletRequest request, 
			@RequestParam("goseq") int goseq) {
		ModelAndView mav =  new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null)
			mav.setViewName("mobile/member/M_loginForm");
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
			
			mav.setViewName("mobile/mypage/m_goodsOrderList");
		}
		return mav;
	}
	
	@RequestMapping("/m_goodsOrderCheckOne")
	public ModelAndView goods_order_check_one(HttpServletRequest request,
			@RequestParam("gseq") int gseq,
			@RequestParam("quantity") int quantity) {
		ModelAndView mav =  new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null)
			mav.setViewName("mobile/member/M_loginForm");
		else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("gseq", gseq);
			paramMap.put("id", loginUser.getId());
			paramMap.put("ref_cursor", null);
			paramMap.put("ref_cursor2", null);
			gs.getGoodsAndPoint(paramMap);
			
			ArrayList<HashMap<String, Object>> list
				= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
			HashMap<String, Object> resultMap = list.get(0);
			ArrayList<HashMap<String, Object>> pointList 
				= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor2");
			
			int totalPrice = quantity * Integer.parseInt(resultMap.get("PRICE2").toString());
			double MPoint = 0;
			MPoint = (int)totalPrice * 0.05;
			mav.addObject("quantity", quantity);
			mav.addObject("totalPrice", totalPrice);
			mav.addObject("Mpoint", (int)MPoint);
			mav.addObject("userPoint", pointList.get(0));
			mav.addObject("goodsVO", resultMap);
			session.setAttribute("totalPrice", totalPrice);
			session.setAttribute("goodsVO", resultMap);
			mav.setViewName("mobile/mypage/m_goodsOrderCheckOne");
		}
		return mav;
	}
	
	@RequestMapping("/m_goodsOrderInsertOne")
	public String goods_order_insert_one(HttpServletRequest request, Model model,
			@RequestParam("gseq") int gseq,
			@RequestParam("quantity") int quantity, 
			@RequestParam("use_pnt") int dpoint, // goodsCartList.jsp 에서  사용한 포인트.
			@RequestParam("totalPrice1") int totalPrice1, // goodsCartList.jsp 에서 결제해야할 상품 금액
			@Valid GoodsOrderVO goodsordervo,
			BindingResult result) {
		String url = "mobile/mypage/m_goodsOrderCheckOne";
		
		// goodsCartList.jsp 에서 넘겨준 포인트(use_pnt)를가지고 계산되는 계산식. 
		int totalprice2 = totalPrice1 - dpoint; // 최종 결제금액 = 결제금액 - 사용할 포인트
		double Mpoint = ( totalPrice1 * 0.05 ) - ( dpoint * 0.05 ); // 최종 포인트 = 적립 총 포인트 - 사용할 포인트
						
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null)
			return "mobile/member/M_loginForm";
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
				paramMap.put("totalprice2", totalprice2);
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
				MemberVO mvo = mem.getMember(loginUser.getId());
				session.setAttribute("loginUser", mvo);
				url = "redirect:/m_goodsOrderList?goseq="+goseq;
			}
		}
		return url;
	}
	
	@RequestMapping("/m_allGoodsOrderList")
	public ModelAndView all_goods_order_list(HttpServletRequest request) {
		ModelAndView mav =  new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null)
			mav.setViewName("mobile/member/M_loginForm");
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
			mav.setViewName("mobile/mypage/m_allGoodsOrderList");
		}
		return mav;
	}
	
	@RequestMapping("/m_goodsOrderDetail")
	public ModelAndView goods_order_detail(HttpServletRequest request,
			@RequestParam("goseq") int goseq) {
		ModelAndView mav =  new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null)
			mav.setViewName("mobile/member/M_loginForm");
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
			mav.setViewName("mobile/mypage/m_goodsOrderDetail");
		}
		return mav;
	}
}
