package com.team2.ticket.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.team2.ticket.dto.MemberVO;
import com.team2.ticket.dto.Paging;
import com.team2.ticket.service.AdminService_P;
import com.team2.ticket.service.TicketingService;

@Controller
public class AdminController_P {

	@Autowired
	AdminService_P as;
	
	@Autowired
	ServletContext context;
	
	@Autowired
	TicketingService ts;

	@RequestMapping("/admin_ticketList")
	public String ticketingList( 
			HttpServletRequest request, Model model ){
		
		HttpSession session = request.getSession();
		
		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
			session.setAttribute("page", page);
		} else if (session.getAttribute("page") != null) {
			page = (Integer) session.getAttribute("page");
		} else {
			session.removeAttribute("page");
		}
		
		String key = "";
		if (request.getParameter("key") != null) {
			key = request.getParameter("key");
			session.setAttribute("key", key);
		} else if (session.getAttribute("key") != null) {
			key = (String) session.getAttribute("key");
		} else {
			session.removeAttribute("key");
		}
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put( "key", key );
		paramMap.put("ref_cursor", null);
		
		as.adminlistTicket( paramMap, page, key );
		
		ArrayList<HashMap<String, Object>> list 
			= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
		
		model.addAttribute("paging", (Paging)paramMap.get("paging"));	
		model.addAttribute("key", key);	
		model.addAttribute("ticketList", list);	
		
		return "admin/ticket/admin_ticketList";
	}
	
	
	@RequestMapping("/adminticketOrderList")
	public String adminticketOrderlistForm( 
			HttpServletRequest request, Model model ){
		
		HttpSession session = request.getSession();
		
		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
			session.setAttribute("page", page);
		} else if (session.getAttribute("page") != null) {
			page = (Integer) session.getAttribute("page");
		} else {
			session.removeAttribute("page");
		}
		
		String key = "";
		if (request.getParameter("key") != null) {
			key = request.getParameter("key");
			session.setAttribute("key", key);
		} else if (session.getAttribute("key") != null) {
			key = (String) session.getAttribute("key");
		} else {
			session.removeAttribute("key");
		}
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put( "key", key );
		paramMap.put("ref_cursor", null);
		
		as.adminlistTicketCart( paramMap, page, key );
		//as.adminlistTicketCart( paramMap );
		
		ArrayList<HashMap<String, Object>> list 
		= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
		
		model.addAttribute("paging", (Paging)paramMap.get("paging"));	
		model.addAttribute("key", key);	
		model.addAttribute("ticketCartList", list);
		
		return "admin/ticket/adminticketOrderList";
	}
	
	@RequestMapping(value="fileup")
	@ResponseBody
	public HashMap<String, Object> fileup(Model model, HttpServletRequest request) {
	
		HashMap<String, Object> result = new HashMap<String, Object>();
		String path = context.getRealPath("/ticket_image");
		try {
			MultipartRequest multi = new MultipartRequest(
					request, path, 5*1024*1024, "UTF-8", new DefaultFileRenamePolicy()
			);
			result.put("STATUS",1);
			result.put("FILENAME", multi.getFilesystemName("fileimage") );
			System.out.println( multi.getFilesystemName("fileimage") ); // 파일이미지가 출력되는지확인 
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	@RequestMapping(value="/admin_ticketWriteForm")
	public String admin_ticketWriteForm(HttpServletRequest request, Model model) {
		
		return "admin/ticket/admin_ticketWrite";
	}
	
	@RequestMapping(value="/admin_ticketWrite", method=RequestMethod.POST)
	public String admin_ticketWrite(HttpServletRequest request, Model model) {
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("name", request.getParameter("name"));
		paramMap.put("price1", Integer.parseInt(request.getParameter("price1")));
		paramMap.put("price2", Integer.parseInt(request.getParameter("price2")));
		paramMap.put("price3", Integer.parseInt(request.getParameter("price3")));
		paramMap.put("showtime", request.getParameter("showtime"));
		paramMap.put("age", request.getParameter("age"));
		paramMap.put("content", request.getParameter("content"));
		paramMap.put("place", request.getParameter("place"));
		paramMap.put("daytime", request.getParameter("daytime"));
		paramMap.put("sdate", request.getParameter("sdate"));
		paramMap.put("edate", request.getParameter("edate"));
		paramMap.put("address", request.getParameter("address"));
		paramMap.put("image", request.getParameter("image"));
		
		as.insertTProduct( paramMap );
		
		return "redirect:/admin_ticketList";
	}
	
	@RequestMapping("admin_deleteForm")
	public String admin_deleteForm(
			@RequestParam("tpseq") int tpseq,
			Model model, HttpServletRequest request) {
		model.addAttribute("tpseq", tpseq);
		return "admin/ticket/admin_ticketCheckPassForm";
	}
	
	
	@RequestMapping("admin_delete2Form")
	public String admin_delete2Form(
			@RequestParam("cseq") int cseq,
			Model model, HttpServletRequest request) {
		model.addAttribute("cseq", cseq);
		return "admin/ticket/admin_ticketCart_CheckPassForm";
	}
	
	@RequestMapping("/ticketEditCheck")
	public String ticketEditCheck(
			@RequestParam("pass") String pass, 
			@RequestParam("tpseq") String tpseq, 		
			Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
		
		if( pass.equals( mvo.getPwd() ) ) {
			model.addAttribute("tpseq", tpseq);
			return "admin/ticket/admin_ticketCheckPass";
		} else {
			model.addAttribute("message", "비밀번호가 맞지 않습니다. 확인해주세요");
			return "admin/ticket/admin_ticketCheckPassForm";
		}
			
	}
	@RequestMapping("/ticketCart_EditCheck")
	public String ticketCart_EditCheck(
			@RequestParam("pass") String pass, 
			@RequestParam("cseq") String cseq, 		
			Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
		
		if( pass.equals( mvo.getPwd() ) ) {
			model.addAttribute("cseq", cseq);
			return "admin/ticket/admin_ticketCheckPass";
		} else {
			model.addAttribute("message", "비밀번호가 맞지 않습니다. 확인해주세요");
			return "admin/ticket/admin_ticketCart_CheckPassForm";
		}
		
	}
	
	@RequestMapping("/admin_delete")
	public String admin_delete(
			Model model, HttpServletRequest request,
			@RequestParam("tpseq") String tpseq ) {

		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("tpseq", tpseq);	
		
		as.deleteTicket_productr( paramMap );
		// 삭제후 경로 이동 
		return "redirect:/admin_ticketList";
	}
	
	
	@RequestMapping("/admin_delete_cart")
	public String admin_delete_cart(
			Model model, HttpServletRequest request,
			@RequestParam("cseq") int cseq ) {
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("cseq", cseq);	
		
		as.deleteTicket_productr_cart( paramMap );
		// 삭제후 경로 이동 
		return "redirect:/adminticketOrderList";
		//return "admin/ticket/adminticketOrderList";
		
	}
	
	@RequestMapping("/admin_ticketUpdateForm")
	public String admin_ticketUpdateForm(
			Model model, HttpServletRequest request,
			@RequestParam("tpseq") int tpseq ) {
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("tpseq", tpseq );
		paramMap.put("ref_cursor", null );
		
		ts.getTProduct( paramMap );
		
		ArrayList<HashMap<String, Object>> list
			= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor");
		
		HashMap<String, Object> resultMap = list.get(0);
		
		model.addAttribute("tpvo", resultMap );
		
		return "admin/ticket/admin_UpdateForm";
	}
	
	
	@RequestMapping(value="/admin_ticketUpdate", method=RequestMethod.POST)
	public String admin_ticketUpdate(
			Model model, HttpServletRequest request) {
		System.out.println("1");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("name", request.getParameter("name"));
		paramMap.put("price1", Integer.parseInt(request.getParameter("price1")));
		paramMap.put("price2", Integer.parseInt(request.getParameter("price2")));
		paramMap.put("price3", Integer.parseInt(request.getParameter("price3")));
		paramMap.put("showtime", request.getParameter("showtime"));
		paramMap.put("age", request.getParameter("age"));
		paramMap.put("content", request.getParameter("content"));
		paramMap.put("place", request.getParameter("place"));
		paramMap.put("daytime", request.getParameter("daytime"));
		paramMap.put("sdate", request.getParameter("sdate"));
		paramMap.put("edate", request.getParameter("edate"));
		paramMap.put("address", request.getParameter("address"));
		paramMap.put("image", request.getParameter("image"));
		paramMap.put("tpseq", request.getParameter("tpseq"));
		System.out.println("2");
		
		as.adminUpdateTicket( paramMap );
		
		return "redirect:/admin_ticketList";
	}

}