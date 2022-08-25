package com.team2.ticket.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.team2.ticket.dto.MemberVO;
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
		
		paramMap.put("ref_cursor", null);
		gs.getGoodsBanner(paramMap);
		ArrayList<HashMap<String, Object>> list3
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		model.addAttribute("goodsBannerList", list3);
		
		return "goods/goodsMain";
	}
	
	@RequestMapping("/goodsCategory")
	public ModelAndView category(HttpServletRequest request, @RequestParam("kind") String kind) {
		ModelAndView mav = new ModelAndView();
		
		int page = 1;
		HttpSession session = request.getSession();
		if(request.getParameter("page")!=null) {
			page = Integer.parseInt(request.getParameter("page"));
			session.setAttribute("page", page);
		}else if(session.getAttribute("page")!=null) {
			page = (Integer)session.getAttribute("page");
		}else {
			session.removeAttribute("page");
		}
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ref_cursor", null);
		paramMap.put("kind", kind);
		
		gs.getGoodsKindList(paramMap, page);		
		ArrayList<HashMap<String, Object>> list
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		String [] goodsKindList = {"","문구","디지털","가방 · 파우치","취미용품","패션 · 잡화"};
		
		mav.addObject("goodsKind", goodsKindList[Integer.parseInt(kind)]);
		mav.addObject("goodsCategoryList", list);
		mav.addObject("kind", kind);
		mav.addObject("paging", (Paging)paramMap.get("paging"));
		mav.setViewName("goods/goodsCategory");
		return mav;
	}
	
	@RequestMapping(value="/goodsSearch")
	public ModelAndView goods_search(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		
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
		paramMap.put("key", key);
		gs.getGoodsSearchList(paramMap, page);
		ArrayList<HashMap<String,Object>> list
			= (ArrayList<HashMap<String,Object>>)paramMap.get("ref_cursor");
		
		mav.addObject("goodsSearchList", list);
		mav.addObject("paging", (Paging)paramMap.get("paging"));
		mav.addObject("key", key);
		mav.setViewName("goods/goodsSearch");
		return mav;
	}
	
	@RequestMapping("/goodsDetail")
	public ModelAndView goods_detail(@RequestParam("gseq") int gseq) {
		ModelAndView mav = new ModelAndView();
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("gseq", gseq);
		paramMap.put("ref_cursor", null);
		
		gs.getGoods(paramMap);
		
		ArrayList<HashMap<String, Object>> list
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		HashMap<String, Object> resultMap = list.get(0);
		
		mav.addObject("goodsVO", resultMap);
		mav.setViewName("goods/goodsDetail");
		return mav;
	}
	
	// 장바구니
	@RequestMapping("/goodsCartInsert")
	public String goods_cart_insert(HttpServletRequest request,
			@RequestParam("gseq") int gseq,
			@RequestParam("quantity") int quantity) {
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null)
			return "member/loginForm";
		else {
			gs.insertGoodsCart(loginUser.getId(), gseq, quantity);
		}
		return "redirect:/goodsCartList";
	}
	
	@RequestMapping("/goodsCartList")
	public ModelAndView goods_cart_list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null)
			mav.setViewName("member/loginForm");
		else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("id", loginUser.getId());
			paramMap.put("ref_cursor", null);
			gs.listGoodsCart(paramMap);
			ArrayList<HashMap<String,Object>> cartList
				= (ArrayList<HashMap<String,Object>>)paramMap.get("ref_cursor");
			
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
			for(HashMap<String,Object> cart : cartList) {
				totalPrice += Integer.parseInt(cart.get("QUANTITY").toString())
									* Integer.parseInt(cart.get("PRICE").toString());
			}
			
			mav.addObject("goodsCartList", cartList);
			mav.addObject("totalPrice", totalPrice);
			mav.setViewName("mypage/goodsCartList");
		}
		return mav;
	}
	
	@RequestMapping("/goodsCartDelete")
	public String goods_cart_delete(HttpServletRequest request,
			@RequestParam("gcseq") int [] gcseqArr) {
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null)
			return "member/loginForm";
		else {
			gs.deleteGoodsCart(gcseqArr);
		}
		return "redirect:/goodsCartList";
	}
}
