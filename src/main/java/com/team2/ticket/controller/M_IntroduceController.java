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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.team2.ticket.dto.EventVO;
import com.team2.ticket.dto.IntroVO;
import com.team2.ticket.dto.NoticeVO;
import com.team2.ticket.dto.Paging;
import com.team2.ticket.dto.ReplyVO;
import com.team2.ticket.service.IntroduceService;

@Controller
public class M_IntroduceController {

	@Autowired
	IntroduceService ids;
	
	@RequestMapping("/Mintroduce")
	public ModelAndView introduce(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		HashMap<String, Object> result = ids.getIntro();
		mav.addObject("introduce", (IntroVO)result.get("intro"));
		mav.setViewName("mobile/introduce/M_introduceForm");
		return mav;
	}
	
	@RequestMapping("/Mnotice")
	public ModelAndView notice(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		int page = 1;
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
			session.setAttribute("page", page);
		} else if(session.getAttribute("page") != null) {
			page = (Integer)session.getAttribute("page");
		} else {
			session.removeAttribute("page");
		}
		
		HashMap<String, Object> result = ids.getNotice(page);
		mav.addObject("notice", (List<NoticeVO>)result.get("notice"));
		mav.addObject("paging", (Paging)result.get("paging"));
		mav.setViewName("mobile/introduce/M_noticeForm");
		return mav;
	}
	
	@RequestMapping("/MnoticeView")
	public ModelAndView noticeView(@RequestParam("ntnum") int ntnum, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		HashMap<String, Object> result = ids.noticeView(ntnum);
		mav.addObject("noticeView", (NoticeVO)result.get("noticeView"));
		mav.setViewName("mobile/introduce/M_noticeView");
		return mav;
	}
	
	@RequestMapping("/Mevent")
	public ModelAndView event(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		HashMap<String, Object> result = ids.getEvent();
		mav.addObject("event", (List<EventVO>)result.get("event"));
		mav.setViewName("mobile/introduce/M_eventForm");
		return mav;
	}
	
	@RequestMapping("/MeventDetail")
	public ModelAndView eventDetail(@RequestParam("evnum") int evnum,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("evnum", evnum);
		paramMap.put("ref_cursor1", null);
		paramMap.put("ref_cursor2", null);
			
		ids.eventDetail(paramMap);
			
		ArrayList<HashMap<String, Object>> list1 = (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor1");
		ArrayList<HashMap<String, Object>> list2 = (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor2");
			
		mav.addObject("eventView", list1.get(0));
		mav.addObject("ereply", list2);
		mav.setViewName("mobile/introduce/M_eventDetail");
		return mav;
	}
	
	@RequestMapping(value="/MeventReply", method=RequestMethod.POST)
	public String eventReply(ReplyVO replyvo, HttpServletRequest request) {
		ids.insertReply(replyvo);
		return "redirect:/MeventDetailWithoutCount?num=" + replyvo.getEvnum();
	}
	
	@RequestMapping("/MeventDetailWithoutCount")
	public ModelAndView eventDetailWithoutCount(@RequestParam("num") int evnum,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("evnum", evnum);
		paramMap.put("ref_cursor1", null);
		paramMap.put("ref_cursor2", null);
		
		ids.eventDetailWithoutCount(paramMap);
		
		ArrayList<HashMap<String, Object>> list1 = (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor1");
		ArrayList<HashMap<String, Object>> list2 = (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor2");
		
		mav.addObject("eventView", list1.get(0));
		mav.addObject("ereply", list2);
		mav.setViewName("mobile/introduce/M_eventDetail");
		return mav;
	}
	
	@RequestMapping("/MdelRep")
	public String delRep(@RequestParam("replynum") int replynum, @RequestParam("evnum") int evnum,
			HttpServletRequest request) {
		ids.deleteReply(replynum);
		return "redirect:/MeventDetailWithoutCount?num=" + evnum;
	}
	
	@RequestMapping("/MupdRepForm")
	public String updRepForm(@RequestParam("replynum") int replynum,
			HttpServletRequest request, Model model) {
		HashMap<String, Object> result = ids.getReply(replynum);
		model.addAttribute("reply", (ReplyVO)result.get("reply"));
		return "mobile/introduce/M_updRepForm";
	}
	
	@RequestMapping("/MupdRep")
	public String updRep(@ModelAttribute("reply") @Valid ReplyVO replyvo, BindingResult result,
			HttpServletRequest request, Model model) {
		String url = "redirect:/eventDetailWithoutCount?num=" + replyvo.getEvnum();
		
		if(result.getFieldError("content") != null) {
			model.addAttribute("message", result.getFieldError("content").getDefaultMessage());
		} else if(result.getFieldError("rate") != null) {
			model.addAttribute("message", result.getFieldError("content").getDefaultMessage());
		} else {
			ids.updateReply(replyvo);
			model.addAttribute("reply", replyvo);
			url = "mobile/introduce/M_completeReply";
		}
		return url;
		
	}
	
	
}
