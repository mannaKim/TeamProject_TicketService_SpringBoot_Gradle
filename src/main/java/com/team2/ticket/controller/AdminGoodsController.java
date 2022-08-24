package com.team2.ticket.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.team2.ticket.dto.GoodsVO;
import com.team2.ticket.dto.MemberVO;
import com.team2.ticket.dto.Paging;
import com.team2.ticket.service.AdminGoodsService;
import com.team2.ticket.service.GoodsOrderService;
import com.team2.ticket.service.GoodsService;

@Controller
public class AdminGoodsController {
	@Autowired
	AdminGoodsService as;
	
	@Autowired
	ServletContext context;
	
	@Autowired
	GoodsService gs;
	
	@Autowired
	GoodsOrderService os;
	
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
	
	@RequestMapping("/adminGoodsInsertForm")
	public String admin_goods_insert_form(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null || loginUser.getAdmin()!=1)
			return "member/loginForm";
		else {
			String [] goodsKindList = {"문구","디지털","가방 · 파우치","취미용품","패션 · 잡화"};
			model.addAttribute("goodsKindList", goodsKindList);
			return "admin/goods/goodsInsert";
		}
	}
	
	@RequestMapping(value="goodsfileup", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> goodsfileup(HttpServletRequest request, Model model) {
		HashMap<String,Object> result = new HashMap<String,Object>();
		String path = context.getRealPath("/goods_images");
		try {
			MultipartRequest multi = new MultipartRequest(
					request, path, 5*1024*1024, "UTF-8", new DefaultFileRenamePolicy()
			);
			result.put("STATUS", 1);
			result.put("FILENAME", multi.getFilesystemName("fileimage"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value="goodsfileup2", method=RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> goodsfileup2(HttpServletRequest request, Model model) {
		HashMap<String,Object> result = new HashMap<String,Object>();
		String path = context.getRealPath("/goods_images");
		try {
			MultipartRequest multi = new MultipartRequest(
					request, path, 5*1024*1024, "UTF-8", new DefaultFileRenamePolicy()
			);
			result.put("STATUS", 1);
			result.put("FILENAME", multi.getFilesystemName("fileimage2"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping("/adminGoodsInsert")
	public String admin_goods_insert(
			@ModelAttribute("goods") @Valid GoodsVO goodsvo,
			BindingResult result,
			Model model,
			HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		String [] goodsKindList = {"문구","디지털","가방 · 파우치","취미용품","패션 · 잡화"};
		model.addAttribute("goodsKindList", goodsKindList);
		if(loginUser == null || loginUser.getAdmin()!=1)
			return "member/loginForm";
		else {
			String url = "admin/goods/goodsInsert";
			if(result.getFieldError("kind")!=null) 
				model.addAttribute("message", result.getFieldError("kind").getDefaultMessage());
			else if(result.getFieldError("name")!=null) 
				model.addAttribute("message", result.getFieldError("name").getDefaultMessage());
			else if(result.getFieldError("num_inventory")!=null) 
				model.addAttribute("message", result.getFieldError("num_inventory").getDefaultMessage());
			else if(result.getFieldError("price1")!=null) 
				model.addAttribute("message", result.getFieldError("price1").getDefaultMessage());
			else if(result.getFieldError("price2")!=null) 
				model.addAttribute("message", result.getFieldError("price2").getDefaultMessage());
			else if(result.getFieldError("image")!=null) 
				model.addAttribute("message", result.getFieldError("image").getDefaultMessage());
			else if(result.getFieldError("detail_img")!=null) 
				model.addAttribute("message", result.getFieldError("detail_img").getDefaultMessage());
			else {
				HashMap<String,Object> paramMap = new HashMap<String,Object>();
				paramMap.put("name", goodsvo.getName());
				paramMap.put("kind", goodsvo.getKind());
				paramMap.put("num_inventory", goodsvo.getNum_inventory());
				paramMap.put("price1", goodsvo.getPrice1());
				paramMap.put("price2", goodsvo.getPrice2());
				paramMap.put("price3", goodsvo.getPrice3());
				paramMap.put("content", goodsvo.getContent());
				paramMap.put("image", goodsvo.getImage());
				paramMap.put("detail_img", goodsvo.getDetail_img());
				as.insertGoods(paramMap);
				url = "redirect:/adminGoodsList?page=1";
			}
			return url;
		}
	}
	
	@RequestMapping("/adminGoodsDetail")
	public ModelAndView admin_goods_detail(HttpServletRequest request,
			@RequestParam("gseq") int gseq) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null || loginUser.getAdmin()!=1)
			mav.setViewName("member/loginForm");
		else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("gseq", gseq);
			paramMap.put("ref_cursor", null);
			
			gs.getGoods(paramMap);
			ArrayList<HashMap<String, Object>> list
				= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
			HashMap<String, Object> resultMap = list.get(0);
			
			String [] goodsKindList = {"","문구","디지털","가방 · 파우치","취미용품","패션 · 잡화"};
			mav.addObject("goodsKind", goodsKindList[Integer.parseInt(resultMap.get("KIND").toString())]);
			mav.addObject("goodsVO", resultMap);
			mav.setViewName("admin/goods/goodsDetail");
		}
		return mav;
	}
	
	@RequestMapping("/adminGoodsDelete")
	public String admin_goods_delete(HttpServletRequest request,
			@RequestParam("gseq") int gseq) {
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null || loginUser.getAdmin()!=1)
			return "member/loginForm";
		else {
			as.deleteGoods(gseq);
		}
		return "redirect:/adminGoodsList?page=1";
	}
	
	@RequestMapping("/adminGoodsUpdateForm")
	public ModelAndView admin_goods_update_form(HttpServletRequest request, 
			@RequestParam("gseq") int gseq) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null || loginUser.getAdmin()!=1)
			mav.setViewName("member/loginForm");
		else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("gseq", gseq);
			paramMap.put("ref_cursor", null);
			
			gs.getGoods(paramMap);
			ArrayList<HashMap<String, Object>> list
				= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
			HashMap<String, Object> resultMap = list.get(0);
			
			GoodsVO goods = new GoodsVO();
			goods.setGseq(Integer.parseInt(resultMap.get("GSEQ").toString()));
			goods.setName(resultMap.get("NAME").toString());
			goods.setKind(resultMap.get("KIND").toString());
			goods.setNum_inventory(Integer.parseInt(resultMap.get("NUM_INVENTORY").toString()));
			goods.setPrice1(Integer.parseInt(resultMap.get("PRICE1").toString()));
			goods.setPrice2(Integer.parseInt(resultMap.get("PRICE2").toString()));
			goods.setPrice3(Integer.parseInt(resultMap.get("PRICE3").toString()));
			goods.setContent(resultMap.get("CONTENT").toString());
			goods.setImage(resultMap.get("IMAGE").toString());
			goods.setDetail_img(resultMap.get("DETAIL_IMG").toString());
			goods.setUseyn(resultMap.get("USEYN").toString());
			goods.setBestyn(resultMap.get("BESTYN").toString());
			
			String [] goodsKindList = {"문구","디지털","가방 · 파우치","취미용품","패션 · 잡화"};
			mav.addObject("goodsKindList", goodsKindList);
			mav.addObject("goods", goods);
			mav.setViewName("admin/goods/goodsModify");
		}
		return mav;
	}
	
	@RequestMapping("/adminGoodsUpdate")
	public String admin_goods_update(
			@ModelAttribute("goods") @Valid GoodsVO goodsvo,
			BindingResult result,
			Model model,
			HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		String [] goodsKindList = {"문구","디지털","가방 · 파우치","취미용품","패션 · 잡화"};
		model.addAttribute("goodsKindList", goodsKindList);
		if(loginUser == null || loginUser.getAdmin()!=1)
			return "member/loginForm";
		else {
			String url = "admin/goods/goodsModify";
			if(result.getFieldError("kind")!=null) 
				model.addAttribute("message", result.getFieldError("kind").getDefaultMessage());
			else if(result.getFieldError("name")!=null) 
				model.addAttribute("message", result.getFieldError("name").getDefaultMessage());
			else if(result.getFieldError("num_inventory")!=null) 
				model.addAttribute("message", result.getFieldError("num_inventory").getDefaultMessage());
			else if(result.getFieldError("price1")!=null) 
				model.addAttribute("message", result.getFieldError("price1").getDefaultMessage());
			else if(result.getFieldError("price2")!=null) 
				model.addAttribute("message", result.getFieldError("price2").getDefaultMessage());
			else {
				HashMap<String,Object> paramMap = new HashMap<String,Object>();
				paramMap.put("name", goodsvo.getName());
				paramMap.put("kind", goodsvo.getKind());
				paramMap.put("num_inventory", goodsvo.getNum_inventory());
				paramMap.put("price1", goodsvo.getPrice1());
				paramMap.put("price2", goodsvo.getPrice2());
				paramMap.put("price3", goodsvo.getPrice3());
				paramMap.put("useyn", goodsvo.getUseyn());
				paramMap.put("bestyn", goodsvo.getBestyn());
				paramMap.put("content", goodsvo.getContent());
				paramMap.put("gseq", goodsvo.getGseq());
				if(goodsvo.getImage()==null) {
					paramMap.put("image", request.getParameter("oldImage"));
				} else {
					paramMap.put("image", goodsvo.getImage());
				}	
				if(goodsvo.getDetail_img()==null) {
					paramMap.put("detail_img", request.getParameter("oldDetail_img"));
				} else {
					paramMap.put("detail_img", goodsvo.getDetail_img());
				}
//				System.out.println("갱신이미지 "+goodsvo.getImage());
//				System.out.println("갱신상세이미지 "+goodsvo.getDetail_img());
//				System.out.println("옛날이미지 "+request.getParameter("oldImage"));
//				System.out.println("옛날상세이미지 "+request.getParameter("oldDetail_img"));
//				System.out.println("바꾼이미지 "+paramMap.get("image").toString());
//				System.out.println("바꾼상세이미지 "+paramMap.get("detail_img").toString());
				as.updateGoods(paramMap);
				url = "redirect:/adminGoodsDetail?gseq="+goodsvo.getGseq();
			}
			return url;
		}
	}
	
	@RequestMapping("/adminGoodsOrderList")
	public ModelAndView admin_goods_order_list(HttpServletRequest request) {
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
			HashMap<String,Object> paramMap = new HashMap<String,Object>();
			paramMap.put("ref_cursor", null);
			as.listAdminGoodsOrder(paramMap, page);
			ArrayList<HashMap<String, Object>> finalList
				= (ArrayList<HashMap<String, Object>>)paramMap.get("finalList");
			mav.addObject("goodsOrderList", finalList);
			mav.addObject("paging", (Paging)paramMap.get("paging"));
			mav.setViewName("admin/goods/goodsOrderList");
		}
		return mav;
	}
	
	@RequestMapping("/adminGoodsOrderModify")
	public ModelAndView admin_goods_order_modify(HttpServletRequest request,
			@RequestParam("goseq") int goseq) {
		ModelAndView mav =  new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null || loginUser.getAdmin()!=1)
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
			mav.setViewName("admin/goods/goodsOrderModify");
		}
		return mav;
	}
	
	@RequestMapping(value="/adminChangeOrderResult", method=RequestMethod.POST)
	public String admin_change_order_result(HttpServletRequest request,
			@RequestParam("goseq") int goseq,
			@RequestParam("godseq") int godseq,
			@RequestParam("result") String result) {
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null || loginUser.getAdmin()!=1)
			return "member/loginForm";
		else {
			if(request.getParameter("all").equals("1")) 
					as.changeResultAll(goseq, "0");
			else {
				if(result.equals("0")) as.changeResult(godseq, "1");
				else as.changeResult(godseq, "0");
			}
		}
		return "redirect:/adminGoodsOrderModify?goseq="+goseq;
	}
}
