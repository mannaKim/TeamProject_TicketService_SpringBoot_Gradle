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
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.team2.ticket.dto.EventVO;
import com.team2.ticket.dto.MemberVO;
import com.team2.ticket.dto.NoticeVO;
import com.team2.ticket.dto.Paging;
import com.team2.ticket.service.AdminIntroduceService;

@Controller
public class AdminIntroduce {

	@Autowired
	AdminIntroduceService ais;
	
	@Autowired
	ServletContext context;
	
	@RequestMapping("/adminNotice")
	public ModelAndView adminNotice(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") == null) {
			mav.setViewName("member/loginForm");
		} else {
			int page = 1;
			if(request.getParameter("page") != null) {
				page = Integer.parseInt(request.getParameter("page"));
				session.setAttribute("page", page);
			} else if(session.getAttribute("page") != null) {
				page = (Integer)session.getAttribute("page");
			} else {
				session.removeAttribute("page");
			}
			
			String key = "";
			if(request.getParameter("key") != null) {
				key = request.getParameter("key");
				session.setAttribute("key", key);
			} else if(session.getAttribute("key") != null) {
				key = (String)session.getAttribute("key");
			} else {
				session.removeAttribute("key");
			}
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("key", key);
			paramMap.put("ref_cursor", null);
			ais.getAdminNotice(paramMap, page, key);
			ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
			mav.addObject("adminnotice", list);
			mav.addObject("key", key);
			mav.addObject("paging", (Paging)paramMap.get("paging"));
			mav.setViewName("admin/introduce/adminNotice");
		}
		return mav;
	}
	
	@RequestMapping("/adminNoticeView")
	public ModelAndView adminNoticeView(@RequestParam("ntnum") int ntnum, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ntnum", ntnum);
		paramMap.put("ref_cursor", null);
		
		ais.getAdminNoticeView(paramMap);
		
		ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		HashMap<String, Object> resultMap = list.get(0);
		mav.addObject("notice", resultMap);
		mav.setViewName("admin/introduce/adminNoticeView");
		return mav;
	}
	
	@RequestMapping("/adminNoticeInsert")
	public String adminNoticeInsert(HttpServletRequest request) {
		return "admin/introduce/adminNoticeWrite";
	}
	
	@RequestMapping(value="/noticeWrite", method=RequestMethod.POST)
	public String noticeWrite(@ModelAttribute("notice") @Valid NoticeVO noticevo,
			BindingResult result, HttpServletRequest request, Model model) {
		String url = "admin/introduce/adminNoticeWrite";
		
		if(result.getFieldError("title") != null) {
			model.addAttribute("message", result.getFieldError("title").getDefaultMessage());
		} else if(result.getFieldError("content") != null) {
			model.addAttribute("message", result.getFieldError("content").getDefaultMessage());
		} else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("ntnum", noticevo.getNtnum());
			paramMap.put("title", noticevo.getTitle());
			paramMap.put("content", noticevo.getContent());
			paramMap.put("id", noticevo.getId());
			
			ais.insertAdminNotice(paramMap);
			url = "redirect:/adminNotice";
		}
		return url;
	}
	
	@RequestMapping("/adminNoticeUpdateForm")
	public String adminNoticeUpdateForm(@RequestParam("num") int ntnum, Model model,
			HttpServletRequest request) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ntnum", ntnum);
		paramMap.put("ref_cursor", null);
		
		ais.getAdminNoticeView(paramMap);
		ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		HashMap<String, Object> resultMap = list.get(0);
		
		NoticeVO nvo = new NoticeVO();
		nvo.setNtnum(Integer.parseInt(String.valueOf(resultMap.get("NTNUM"))));
		nvo.setTitle((String)resultMap.get("TITLE"));
		nvo.setContent((String)resultMap.get("CONTENT"));
		nvo.setId((String)resultMap.get("ID"));
		
		model.addAttribute("ntnum", ntnum);
		model.addAttribute("notice", nvo);
		return "admin/introduce/adminNoticeUpdateForm";
	}
	
	@RequestMapping(value="/updateNotice", method=RequestMethod.POST)
	public String updateNotice(@ModelAttribute("notice") @Valid NoticeVO noticevo,
			BindingResult result, HttpServletRequest request, Model model) {
		
		String url = "admin/introduce/adminNoticeUpdateForm";
		if(result.getFieldError("title") !=  null) {
			model.addAttribute("message", result.getFieldError("title").getDefaultMessage());
		} else if(result.getFieldError("content") != null) {
			model.addAttribute("message", result.getFieldError("content").getDefaultMessage());
		} else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("ntnum", noticevo.getNtnum());
			paramMap.put("title", noticevo.getTitle());
			paramMap.put("content", noticevo.getContent());
			paramMap.put("id", noticevo.getId());
			
			ais.adminUpdateNotice(paramMap);
			url = "redirect:/adminNoticeView?ntnum=" + noticevo.getNtnum();
		}
		return url;
	}
	
	@RequestMapping("/adminNoticeDelete")
	public String adminNoticeDelete(@RequestParam("num") int ntnum, HttpServletRequest request) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ntnum", ntnum);
		ais.deleteNotice(paramMap);
		
		return "redirect:/adminNotice";
	}
	
	@RequestMapping("/adminEvent")
	public String adminEvent(HttpServletRequest request, Model model) {
		
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO)session.getAttribute("loginUser");
		
		if(mvo == null) {
			return "member/loginForm";
		} else {
			int page = 1;
			if(request.getParameter("page") != null) {
				page = Integer.parseInt(request.getParameter("page"));
				session.setAttribute("page", page);
			} else if(session.getAttribute("page") != null) {
				page = (Integer)session.getAttribute("page");
			} else {
				session.removeAttribute("page");
			}
			
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("ref_cursor", null);
			
			ais.getEventList(paramMap, page);
			ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
			model.addAttribute("loginUser", mvo);
			model.addAttribute("eventList", list);
			model.addAttribute("paging", (Paging)paramMap.get("paging"));
			return "admin/introduce/adminEvent";
		}
	}
	@RequestMapping("/adminEventInsert")
	public String adminEventInsert(HttpServletRequest request) {
		
		String url = "admin/introduce/eventWriteForm";
		HttpSession session = request.getSession();
		MemberVO mvo =(MemberVO)session.getAttribute("loginUser");
		if(mvo == null) {
			return "member/loginForm";
		}
			return url;
	}
	
	@RequestMapping("/eventselectimg1")
	public String eventselectimg1() {
		return "admin/introduce/eventselectimg1";
	}
	
	@RequestMapping("/eventselectimg2")
	public String eventselectimg2() {
		return "admin/introduce/eventselectimg2";
	}
	
	@RequestMapping(value="/evimgupload1", method=RequestMethod.POST)
	public String evimgupload1(HttpServletRequest request, Model model) {
		String path = context.getRealPath("/ticket_image");
		
		try {
			MultipartRequest multi = new MultipartRequest(
					request, path, 5*1024*1024, "UTF-8", new DefaultFileRenamePolicy()
			);
			model.addAttribute("evimage1", multi.getFilesystemName("evimage1"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "admin/introduce/eventupload1";
	}
	
	@RequestMapping(value="/evimgupload2", method=RequestMethod.POST)
	public String evimgupload2(HttpServletRequest request, Model model) {
		String path = context.getRealPath("/ticket_image");
		
		try {
			MultipartRequest multi = new MultipartRequest(
					request, path, 5*1024*1024, "UTF-8", new DefaultFileRenamePolicy()
			);
			model.addAttribute("evimage2", multi.getFilesystemName("evimage2"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "admin/introduce/eventupload2";
	}
	
	@RequestMapping(value="/eventWrite", method=RequestMethod.POST)
	public String eventWrite(@ModelAttribute("eventList") @Valid EventVO eventvo,
			BindingResult result, HttpServletRequest requets, Model model) {
		String url = "admin/introduce/eventWriteForm";
		if(result.getFieldError("title") != null) {
			model.addAttribute("message", result.getFieldError("title").getDefaultMessage());
		} else if(result.getFieldError("evdate") != null) {
			model.addAttribute("message", result.getFieldError("evdate").getDefaultMessage());
		} else if(result.getFieldError("evperson") != null) {
			model.addAttribute("message", result.getFieldError("evperson").getDefaultMessage());
		} else {
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("evnum", eventvo.getEvnum());
			paramMap.put("id", eventvo.getId());
			paramMap.put("title", eventvo.getTitle());
			paramMap.put("indate", eventvo.getIndate());
			paramMap.put("evdate", eventvo.getEvdate());
			paramMap.put("evperson", eventvo.getEvperson());
			paramMap.put("readcount", eventvo.getReadcount());
			paramMap.put("eimage1", eventvo.getEimage());
			paramMap.put("eimage2", eventvo.getEimage2());
			ais.insertEvent(paramMap);
			url = "redirect:/adminEvent";
		}
		return url;
	}
	
	@RequestMapping("/adminEventView")
	public String eventDetail(@RequestParam("evnum") int evnum, HttpServletRequest request,
			Model model) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("evnum", evnum);
		paramMap.put("ref_cursor", null);
		ais.getAdminEventView(paramMap);
		
		ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		model.addAttribute("event", list.get(0));
		return "admin/introduce/adminEventView";
	}
	
	@RequestMapping("/adminEventUpdateForm")
	public String adminEventUpdateForm(@RequestParam("num") int evnum, Model model,
			HttpServletRequest request) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("evnum", evnum);
		paramMap.put("ref_cursor", null);
		
		ais.getAdminEventView(paramMap);
		ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		HashMap<String, Object> resultMap = list.get(0);
		
		EventVO evo = new EventVO();
		evo.setEvnum(Integer.parseInt(String.valueOf(resultMap.get("EVNUM"))));
		evo.setTitle((String)resultMap.get("TITLE"));
		evo.setEvdate((String)resultMap.get("EVDATE"));
		evo.setEvperson((String)resultMap.get("EVPERSON"));
		evo.setEimage((String)resultMap.get("EIMAGE"));
		evo.setEimage2((String)resultMap.get("EIMAGE2"));
		evo.setId((String)resultMap.get("ID"));
		
		model.addAttribute("evnum", evnum);
		model.addAttribute("event", evo);
		return "admin/introduce/updateEventForm";
	}
	
	@RequestMapping(value="/updateAdminEvent", method=RequestMethod.POST)
	public String updateAdminEvent(@ModelAttribute("event") @Valid EventVO eventvo,
			BindingResult result, @RequestParam(value="oldPicture1", required=false) String oldPicture1,
			@RequestParam(value="oldPicture2", required=false) String oldPicture2, HttpServletRequest request,
			Model model) {
		
		String url = "admin/introduce/updateEventForm";
		if(result.getFieldError("title") != null) {
			model.addAttribute("message", result.getFieldError("title").getDefaultMessage());
		} else if(result.getFieldError("evdate") != null) {
			model.addAttribute("message", result.getFieldError("evdate").getDefaultMessage());
		} else if(result.getFieldError("evperson") != null) {
			model.addAttribute("message", result.getFieldError("evperson").getDefaultMessage());
		} else {
			if(eventvo.getEimage()==null || eventvo.getEimage().equals("")) {
				eventvo.setEimage(oldPicture1);
			} else if(eventvo.getEimage2()==null || eventvo.getEimage2().equals("")) {
				eventvo.setEimage2(oldPicture2);
			}
			HashMap<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("evnum", eventvo.getEvnum());
			paramMap.put("id", eventvo.getId());
			paramMap.put("title", eventvo.getTitle());
			paramMap.put("evdate", eventvo.getEvdate());
			paramMap.put("evperson", eventvo.getEvperson());
			paramMap.put("eimage", eventvo.getEimage());
			paramMap.put("eimage2", eventvo.getEimage2());
			
			ais.updateAdminEvent(paramMap);
			url = "redirect:/adminEvent";
		}
		return url;
		
	}
	
	@RequestMapping("/adminEventDelete")
	public String adminEventDelete(@RequestParam("num") int evnum, HttpServletRequest request) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("evnum", evnum);
		ais.deleteEvent(paramMap);		
		return "redirect:/adminEvent";
	}
	
	@RequestMapping("/adminCheck")
	public String adminCheck(HttpServletRequest request, Model model) {
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
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("ref_cursor", null);
		
		ais.getAdminUser(paramMap, page);
		ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		model.addAttribute("UserPage", list);
		model.addAttribute("paging", (Paging)paramMap.get("paging"));
		return "admin/adminUserPage";
	}
	
	@RequestMapping("/adminUserUpdateForm")
	public String adminUserUpdateForm(@RequestParam("id") String id, HttpServletRequest request,
			Model model) {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("id", id);
		paramMap.put("ref_cursor", null);
		ais.getAdminUserPage(paramMap);
		
		ArrayList<HashMap<String, Object>> list = (ArrayList<HashMap<String, Object>>)paramMap.get("ref_cursor");
		
		model.addAttribute("member", list.get(0));
		return "admin/introduce/adminUserUpdateForm";
	}
	
	@RequestMapping("/editadmin")
	public String editadmin(@ModelAttribute("member") MemberVO membervo,
			HttpServletRequest request, Model model) {
		
		if(membervo.getAdmin()==1) {
			membervo.setAdmin(0);
		} else {
			membervo.setAdmin(1);
		}
		
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("id", membervo.getId());
		paramMap.put("admin", membervo.getAdmin());
		ais.adminMember(paramMap);
		return "redirect:/adminCheck";
	}
	
	@RequestMapping(value="/pointUpdate", method=RequestMethod.POST)
	public String pointUpdate(@ModelAttribute("member") MemberVO membervo, 
			@RequestParam("mpoint") int mpoint, HttpServletRequest request,
			Model model) {
		
		String url = "admin/introduce/adminUserUpdateForm";
		if(membervo.getMpoint()==0) {
			model.addAttribute("message", "포인트값을 입력해주세요.");
		} else {
			ais.adminPointUpdate(membervo);
			model.addAttribute("member", membervo);
			url = "admin/introduce/completeUser";
		}
		return url;
	}
}
