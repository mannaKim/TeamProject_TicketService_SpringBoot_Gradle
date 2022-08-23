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

@Controller
public class AdminGoodsController {
	@Autowired
	AdminGoodsService as;
	
	@Autowired
	ServletContext context;
	
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
}
