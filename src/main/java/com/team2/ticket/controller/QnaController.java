package com.team2.ticket.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.team2.ticket.dto.MemberVO;
import com.team2.ticket.dto.Paging;
import com.team2.ticket.dto.QnaVO;
import com.team2.ticket.service.QnaService;

@Controller
public class QnaController {

	@Autowired
	QnaService qs;
	
	@RequestMapping(value="/qnaList")
	public ModelAndView qna_list(Model model, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		if( loginUser == null ) {
			mav.setViewName("member/loginForm");
		}else {
			
			int page=1;
			if( request.getParameter("page")!= null) {
				page = Integer.parseInt( request.getParameter("page") );
				session.setAttribute("page", page);
			}else if( session.getAttribute("page")!=null) {
				page = (Integer)session.getAttribute("page");
			}else {
				session.removeAttribute("page");
			}
			
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			
			paramMap.put("ref_curser", null);
			qs.qlistQna( paramMap, page );
			
			ArrayList<HashMap<String, Object>> list 
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
			
			mav.addObject("qnaList", list);
			mav.addObject("paging", (Paging)paramMap.get("paging"));
			mav.setViewName("qna/qnaList");
		}
		return mav;
	}
	
	@RequestMapping(value="/qnaWriteForm")
	public String qna_writre_form( HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		if( loginUser == null ) return "member/login";
		String [] kindList = {"전시", "회원안내", "관람/예약", "굿즈", "기타"};

		request.setAttribute("kindList", kindList);
		
	    return "qna/qnaWrite";
	}
	
	// faq
	@RequestMapping(value="/qnafnq")
	public String fnq( HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		if( loginUser == null ) return "member/login";
		
		String url = "qna/qnafnq";
		
		int kind = Integer.parseInt( request.getParameter("kind") );
		System.out.println("kind = " + kind);
		if(kind==1) {
			// 전체 fnq 보기
		}else if(kind==2) {
			url = "qna/qnafnq2";
			// "전시"
		}else if(kind==3) {
			url = "qna/qnafnq3";
			// "회원안내"
		}else if(kind==4) {
			url = "qna/qnafnq4";
			// "관람/예약"
		} else {
			url = "qna/qnafnq5";
			// "굿즈"
		}
		
	    return url;
	}
	
	@RequestMapping(value="/qnafaq")
	public ModelAndView faq( HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		if( loginUser == null ) mav.setViewName("member/login");
		
		String url = "qna/fnq_test";
		
//		int kind = Integer.parseInt( request.getParameter("kind") );
//		System.out.println("kind = " + kind);
//		if(kind==1) {
//			// 전체 fnq 보기
//		}else if(kind==2) {
//			url = "qna/qnafnq2";
//			// "전시"
//		}else if(kind==3) {
//			url = "qna/qnafnq3";
//			// "회원안내"
//		}else if(kind==4) {
//			url = "qna/qnafnq4";
//			// "관람/예약"
//		} else {
//			url = "qna/qnafnq5";
//			// "굿즈"
//		}

		mav.setViewName(url);	
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ref_cursor", null);
		qs.faqList( paramMap );
		
		ArrayList<HashMap<String, Object>> list 
		= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		mav.addObject("faqList", list );
		
	    return mav;
	}
	
	@RequestMapping("/qnaWrite")
	public ModelAndView qna_write( 
			@ModelAttribute("dto") @Valid QnaVO qnavo,
			BindingResult result,  
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
	    if (loginUser == null) 
	    	mav.setViewName("member/login");
	    else {
//	    	mav.setViewName("qna/qnaWrite");
//	    	if(result.getFieldError("subject") != null ) 
//	    		mav.addObject("message", result.getFieldError("subject").getDefaultMessage() );
//	    	else if(result.getFieldError("content") != null )
//	    		mav.addObject("message", result.getFieldError("content").getDefaultMessage());
//	    	else if(result.getFieldError("kind") != null )
//	    		mav.addObject("message", result.getFieldError("kind").getDefaultMessage());
//	    	else {
	    		HashMap<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("id", loginUser.getId() );
				paramMap.put("subject", qnavo.getSubject() );
				paramMap.put("content", qnavo.getContent() );
				paramMap.put("kind", qnavo.getKind() );
			
				qs.qinsertQna( paramMap );
				mav.setViewName("redirect:/qnaList");
	    }
	    return mav;
	}
	
	@RequestMapping(value="/qnaView")
	public ModelAndView qna_view(
			Model model, 
			HttpServletRequest request,
			@RequestParam("qseq") int qseq
	) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		if( loginUser == null ) {
			mav.setViewName("member/login");
		}else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("qseq", qseq );
			paramMap.put("ref_cursor", null);
			paramMap.put("ref_cursor1", null);
			qs.qgetQna( paramMap );
			
			ArrayList<HashMap<String, Object>> list 
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
			
			ArrayList<HashMap<String, Object>> list1
	 		= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor1");
			
			mav.addObject("qnaVO", list.get(0) );
			mav.addObject("replyList", list1 );
			
			mav.setViewName("qna/qnaView");
		}
		return mav;
	}
	
	@RequestMapping(value="/qnaMy")
	public ModelAndView qna_my_list(Model model, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		if( loginUser == null ) {
			mav.setViewName("member/loginForm");
		}else {
			
			int page=1;
			if( request.getParameter("page")!= null) {
				page = Integer.parseInt( request.getParameter("page") );
				session.setAttribute("page", page);
			}else if( session.getAttribute("page")!=null) {
				page = (Integer)session.getAttribute("page");
			}else {
				session.removeAttribute("page");
			}
			
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			
			paramMap.put("ref_curser", null);
			paramMap.put("id", loginUser.getId());
			qs.qmylistQna( paramMap, page );
			
			ArrayList<HashMap<String, Object>> list 
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
			
			mav.addObject("qnaList", list);
			mav.addObject("paging", (Paging)paramMap.get("paging"));
			mav.setViewName("qna/qnaMy");
		}
		return mav;
	}
	
	@RequestMapping(value="/qnaMyView")
	public ModelAndView qna_My_view(
			Model model, 
			HttpServletRequest request,
			@RequestParam("qseq") int qseq
	) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		if( loginUser == null ) {
			mav.setViewName("member/login");
		}else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("qseq", qseq );
			paramMap.put("ref_cursor", null);
			paramMap.put("ref_cursor1", null);
			qs.qgetQna( paramMap );
			
			ArrayList<HashMap<String, Object>> list 
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
			
			ArrayList<HashMap<String, Object>> list1
	 		= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor1");
			
			mav.addObject("qnaVO", list.get(0) );
			mav.addObject("replyList", list1 );
			
			mav.setViewName("qna/qnaMyView");
		}
		return mav;
	}
	
	@RequestMapping("/qnaDelete")
	public String qna_Delete(
			@RequestParam("qseq") int qseq,
			HttpServletRequest request) {
		System.out.println("qseq : "+ qseq + "       ");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("qseq" , qseq);
		qs.qdeleteQna(paramMap);
		
		return "redirect:/qnaMy";
	}
	
	// admin
	@RequestMapping(value="/aqnaList")
	public ModelAndView a_qna_list(Model model, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		if( loginUser == null ) {
			mav.setViewName("member/loginForm");
		}else {
			
			int page=1;
			if( request.getParameter("page")!= null) {
				page = Integer.parseInt( request.getParameter("page") );
				session.setAttribute("page", page);
			}else if( session.getAttribute("page")!=null) {
				page = (Integer)session.getAttribute("page");
			}else {
				session.removeAttribute("page");
			}
			
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			
			paramMap.put("ref_curser", null);
			qs.qlistQna( paramMap, page );
			
			ArrayList<HashMap<String, Object>> list 
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
			
			mav.addObject("qnaList", list);
			mav.addObject("paging", (Paging)paramMap.get("paging"));
			mav.setViewName("admin/qna/aqnalist");
		}
		return mav;
	}
	
	@RequestMapping(value="/aqnaView")
	public ModelAndView a_qna_view(
			Model model, 
			HttpServletRequest request,
			@RequestParam("qseq") int qseq
//			@RequestParam("replycnt") int cnt
	) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		if( loginUser == null ) {
			mav.setViewName("member/login");
		}else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("qseq", qseq );
			paramMap.put("ref_cursor", null);
			paramMap.put("ref_cursor1", null);
			qs.qgetQna( paramMap );
			
			ArrayList<HashMap<String, Object>> list 
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
			
			ArrayList<HashMap<String, Object>> list1
	 		= (ArrayList<HashMap<String, Object>>) paramMap.get("ref_cursor1");
			
			mav.addObject("qnaVO", list.get(0) );
			mav.addObject("replyList", list1 );
			mav.addObject("id", loginUser.getId());
			
//			int num = 1;
//			if ( cnt > 0) num = 2;
			
			//qs.qnarep(qseq); 
			// 위에꺼는 무조건 2로 바꾸는 것.
//			qs.qnaRep(qseq, num);
			
			mav.setViewName("admin/qna/aqnaView");
		}
		return mav;
	}
	
	@RequestMapping(value="/aqnaListN")
	public ModelAndView a_qna_list_N(Model model, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		if( loginUser == null ) {
			mav.setViewName("member/loginForm");
		}else {
			
			int page=1;
			if( request.getParameter("page")!= null) {
				page = Integer.parseInt( request.getParameter("page") );
				session.setAttribute("page", page);
			}else if( session.getAttribute("page")!=null) {
				page = (Integer)session.getAttribute("page");
			}else {
				session.removeAttribute("page");
			}
			
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			
			paramMap.put("ref_curser", null);
			qs.qlistQnaN( paramMap, page );
			
			ArrayList<HashMap<String, Object>> list 
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
			
			mav.addObject("qnaList", list);
			mav.addObject("paging", (Paging)paramMap.get("paging"));
			mav.setViewName("admin/qna/aqnalist");
		}
		return mav;
	}
	
	// 댓글 등록
	@RequestMapping("/qnaReply")
	public String addReply(
			@RequestParam("qnanum") int qnanum, 
			@RequestParam("id") String id, 
			@RequestParam("content") String content, 
			HttpServletRequest request) {
		
		// 댓글 추가
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("id", id );
		paramMap.put("content", content );
		paramMap.put("qnanum", qnanum );
				
		qs.qinsertReply( paramMap );
				
		return "redirect:/aqnaView?qseq=" + qnanum;
	}
	
	
	@RequestMapping("/aqnaReD")
	public String qna_ReD(
			@RequestParam("renum") int renum, 
			@RequestParam("qnanum") int qseq,
			HttpServletRequest request) {
		System.out.println("qnanum : "+ qseq + "       ");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("renum" , renum);
		qs.qdeleteReply(paramMap);
		
		return "redirect:/aqnaView?qseq=" + qseq;
	}
	
}
