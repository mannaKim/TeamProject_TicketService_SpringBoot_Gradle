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

import com.team2.ticket.dto.FaqVO;
import com.team2.ticket.dto.MemberVO;
import com.team2.ticket.dto.Paging;
import com.team2.ticket.dto.QnaVO;
import com.team2.ticket.service.QnaService;

@Controller
public class M_QnaController {

	@Autowired
	QnaService qs;
	
	@RequestMapping(value="/mqnaList")
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
			mav.setViewName("mobile/qna/m_qnaList");
		}
		return mav;
	}
	
	@RequestMapping(value="/mqnaWriteForm")
	public String qna_writre_form( HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		if( loginUser == null ) return "member/loginForm";
		String [] kindList = {"전시", "회원안내", "관람/예약", "굿즈", "기타"};

		request.setAttribute("kindList", kindList);
		
	    return "mobile/qna/m_qnaWrite";
	}
	
	@RequestMapping("/mqnaWrite")
	public ModelAndView qna_write( 
			@ModelAttribute("dto") @Valid QnaVO qnavo,
			BindingResult result,  
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
	    if (loginUser == null) 
	    	mav.setViewName("member/loginForm");
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
				mav.setViewName("redirect:/mqnaList");
	    }
	    return mav;
	}
	
	@RequestMapping(value="/mqnaView")
	public ModelAndView qna_view(
			Model model, 
			HttpServletRequest request,
			@RequestParam("qseq") int qseq
	) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		if( loginUser == null ) {
			mav.setViewName("member/loginForm");
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
			
			mav.setViewName("mobile/qna/m_qnaView");
		}
		return mav;
	}
	
	// mypage
	@RequestMapping(value="/mqnaMy")
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
			mav.setViewName("mobile/qna/m_qnaMy");
		}
		return mav;
	}
	
	@RequestMapping(value="/mqnaMyView")
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
			
			mav.setViewName("mobile/qna/m_qnaMyView");
		}
		return mav;
	}
	
	@RequestMapping("/mqnaDelete")
	public String qna_Delete(
			@RequestParam("qseq") int qseq,
			HttpServletRequest request) {
		System.out.println("qseq : "+ qseq + "       ");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("qseq" , qseq);
		qs.qdeleteQna(paramMap);
		
		return "redirect:/mqnaMy";
	}
	
	// faq
		@RequestMapping(value="/mqnafaq")
		public ModelAndView faq( HttpServletRequest request) {
			ModelAndView mav = new ModelAndView();
			HttpSession session = request.getSession();
			MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
			if( loginUser == null ) mav.setViewName("member/loginForm");
			else {

			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("ref_cursor", null);
			qs.faqList( paramMap );

			ArrayList<HashMap<String, Object>> list 
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
			
			mav.addObject("faqList", list );
			mav.setViewName("mobile/qna/m_faq");
			}
		    return mav;
		}
		
		@RequestMapping(value="/mqnafaqK")
		public ModelAndView faq_kind( HttpServletRequest request) {
			ModelAndView mav = new ModelAndView();
			HttpSession session = request.getSession();
			MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
			if( loginUser == null ) mav.setViewName("member/loginForm");
			
			String url = "mobile/qna/m_faq";
			
			int kind = Integer.parseInt( request.getParameter("kind") );

			mav.setViewName(url);	
			
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("ref_cursor", null);
			paramMap.put("kind", kind);
			qs.faqListK( paramMap );
			
			ArrayList<HashMap<String, Object>> list 
			= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
			
			mav.addObject("faqList", list );
			
		    return mav;
		}
		
		@RequestMapping(value="/mfaqList")
		public ModelAndView faq_list(Model model, HttpServletRequest request) {
			ModelAndView mav = new ModelAndView();
			HttpSession session = request.getSession();
			MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
			
			if( loginUser == null || loginUser.getAdmin()!=1 ) {
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
				qs.qlistFaq( paramMap, page );
				
				ArrayList<HashMap<String, Object>> list 
				= (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
				
				mav.addObject("faqList", list);
				mav.addObject("paging", (Paging)paramMap.get("paging"));
				mav.setViewName("admin/qna/m_afaqlist");
			}
			return mav;
		}
		
		@RequestMapping(value="/mfaqWriteForm")
		public String faq_writre_form( HttpServletRequest request) {
			HttpSession session = request.getSession();
			MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
			if( loginUser == null || loginUser.getAdmin()!=1 ) 
				return "member/loginForm";
			String [] kindList = {"전시", "회원안내", "관람/예약", "굿즈"};

			request.setAttribute("kindList", kindList);
			
		    return "admin/qna/m_afaqwrite";
		}
		
		@RequestMapping("/mfaqWrite")
		public ModelAndView faq_Write( 
				@ModelAttribute("dto") @Valid FaqVO faqvo,
				BindingResult result,  
				HttpServletRequest request,
				@RequestParam("subject") String con_q, 
				@RequestParam("content") String con_a) {
			ModelAndView mav = new ModelAndView();
			HttpSession session = request.getSession();
			MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		    if (loginUser == null) 
		    	mav.setViewName("member/loginForm");
		    else {

		    		HashMap<String, Object> paramMap = new HashMap<String, Object>();
					paramMap.put("con_q", con_q);
					paramMap.put("kind", faqvo.getKind() );
					paramMap.put("con_a", con_a );
				
					qs.qinsertFaq( paramMap );
					mav.setViewName("redirect:/mfaqList");
		    }
		    return mav;
		}
		
		@RequestMapping(value="/mfaqUpdateForm")
		public ModelAndView faq_update_form( HttpServletRequest request, @RequestParam("faqnum") String faqnum) {
			ModelAndView mav = new ModelAndView();
			HttpSession session = request.getSession();
			MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
			if( loginUser == null || loginUser.getAdmin()!=1 ) mav.setViewName("member/loginForm");
			else {
			String [] kindList = {"전시", "회원안내", "관람/예약", "굿즈"};
			System.out.println("실행테스트");
			request.setAttribute("kindList", kindList);
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("faqnum", Integer.parseInt(faqnum));
			paramMap.put("ref_cursor1", null);
			qs.pgetFaq( paramMap );

			ArrayList< HashMap<String, Object>> list
				=(ArrayList< HashMap<String, Object>>) paramMap.get("ref_cursor1");
			HashMap<String, Object> fvo = list.get(0);

			FaqVO favo = new FaqVO();
			favo.setKind( (String)fvo.get("KIND") );
			favo.setCon_q( (String)fvo.get("CON_Q") );
			favo.setCon_a( (String)fvo.get("CON_A") );
			mav.addObject("faqVO", favo);
			System.out.println("내용" + (String)fvo.get("CON_A"));

			mav.setViewName("admin/qna/m_afaqUpdate");
			}
			 return mav;
		}
		
		@RequestMapping("/mfaqDelete")
		public String faq_Delete(
				@RequestParam("faqnum") int faqnum,
				HttpServletRequest request) {
			System.out.println("faqnum : "+ faqnum + "       ");
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("faqnum" , faqnum);
			qs.faqDelete(paramMap);
			
			return "redirect:/mfaqList";
		}
		
		
		@RequestMapping("/mfaqUpdate")
		public ModelAndView faq_Update( 
				@ModelAttribute("dto") @Valid FaqVO faqvo,
				BindingResult result,  
				HttpServletRequest request,
				@RequestParam("subject") String con_q, 
				@RequestParam("content") String con_a) {
			ModelAndView mav = new ModelAndView();
			HttpSession session = request.getSession();
			MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		    if (loginUser == null) 
		    	mav.setViewName("member/loginForm");
		    else {

		    		HashMap<String, Object> paramMap = new HashMap<String, Object>();
					paramMap.put("con_q", con_q);
					paramMap.put("kind", faqvo.getKind() );
					paramMap.put("con_a", con_a );
					paramMap.put("faqnum", faqvo.getFaqnum() );
				
					qs.qUpdateFaq( paramMap );
					mav.setViewName("redirect:/mfaqList");
		    }
		    return mav;
		}
	
	// admin
	@RequestMapping(value="/maqnaList")
	public ModelAndView a_qna_list(Model model, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		if( loginUser == null || loginUser.getAdmin()!=1 ) {
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
			mav.setViewName("admin/qna/m_aqnalist");
		}
		return mav;
	}
	
	@RequestMapping(value="/maqnaView")
	public ModelAndView a_qna_view(
			Model model, 
			HttpServletRequest request,
			@RequestParam("qseq") int qseq
//			@RequestParam("replycnt") int cnt
	) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		if( loginUser == null || loginUser.getAdmin()!=1 ) {
			mav.setViewName("member/loginForm");
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
			
			mav.setViewName("admin/qna/m_aqnaView");
		}
		return mav;
	}
	
	@RequestMapping(value="/maqnaListN")
	public ModelAndView a_qna_list_N(Model model, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO loginUser = (MemberVO)session.getAttribute("loginUser");
		
		if( loginUser == null || loginUser.getAdmin()!=1 ) {
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
			mav.setViewName("admin/qna/m_aqnalist");
		}
		return mav;
	}
	
	// 댓글 등록
	@RequestMapping("/mqnaReply")
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
				
		return "redirect:/maqnaView?qseq=" + qnanum;
	}
	
	
	@RequestMapping("/maqnaReD")
	public String qna_ReD(
			@RequestParam("renum") int renum, 
			@RequestParam("qnanum") int qseq,
			HttpServletRequest request) {
		System.out.println("qnanum : "+ qseq + "       ");
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("renum" , renum);
		qs.qdeleteReply(paramMap);
		
		return "redirect:/maqnaView?qseq=" + qseq;
	}
	
}
