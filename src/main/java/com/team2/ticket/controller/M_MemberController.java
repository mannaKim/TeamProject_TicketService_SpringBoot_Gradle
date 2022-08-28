package com.team2.ticket.controller;

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

import com.team2.ticket.dto.MemberVO;
import com.team2.ticket.service.MemberService;

@Controller
public class M_MemberController {

	@Autowired
	MemberService ms;
	
	@RequestMapping("/MloginForm")
	public String loginForm() {
		return "mobile/member/M_loginForm";
	}
	
	@RequestMapping(value="/mlogin", method=RequestMethod.POST)
	public String login(@ModelAttribute("member") @Valid MemberVO membervo, 
			BindingResult result,
			HttpServletRequest request, Model model) {
		String url = "mobile/member/M_loginForm";
		
		if(result.getFieldError("id") != null) {
			model.addAttribute("message", result.getFieldError("id").getDefaultMessage());
			return url;
		} else if(result.getFieldError("pwd") != null) {
			model.addAttribute("message", result.getFieldError("pwd").getDefaultMessage());
			return url;
		} else {
			MemberVO mvo = ms.getMember(membervo.getId());
			
			if(mvo == null) {
				model.addAttribute("message", "가입된 아이디가 없습니다.");
			} else if(mvo.getPwd() == null) {
				model.addAttribute("message", "비밀번호가 없습니다(데이터베이스 오류, 관리자에게 문의하세요)");
			} else if(!mvo.getPwd().equals(membervo.getPwd())) {
				model.addAttribute("message", "비밀번호가 일치하지 않습니다.");
			} else if(mvo.getPwd().equals(membervo.getPwd())) {
				HttpSession session = request.getSession();
				session.setAttribute("loginUser", mvo);
				url = "redirect:/";
			}
			return url;
		}
	}
	
	@RequestMapping("/Mlogout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("/MtermsAndConditions")
	public String termsAndConditions() {
		return "mobile/member/M_termsAndConditions";
	}
	
	@RequestMapping("/MshowTerm")
	public String showTerm(@RequestParam("num") int num, HttpServletRequest request,
			Model model) {
		model.addAttribute("num", request.getParameter("num"));
		return "mobile/member/M_termsView";
	}
	
	@RequestMapping("/MjoinForm")
	public String joinForm() {
		return "mobile/member/M_joinForm";
	}
	
	@RequestMapping("/MidCheckForm")
	public ModelAndView idCheckForm(@RequestParam("id") String id, Model model,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		MemberVO mvo = ms.getMember(id);
		
		if(mvo == null) {
			mav.addObject("result", -1);
		} else {
			mav.addObject("result", 1);
		}
		mav.addObject("id", id);
		mav.setViewName("mobile/member/M_idCheck");
		return mav;
	}
	
	@RequestMapping(value="/Mjoin", method=RequestMethod.POST)
	public ModelAndView join(@ModelAttribute("member") @Valid MemberVO membervo,
			BindingResult result,
			@RequestParam(value="re_id", required=false) String re_id,
			@RequestParam(value="pwd_check", required=false) String pwd_check,
			HttpServletRequest request, Model model) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("mobile/member/M_loginForm");
		mav.addObject("re_id", re_id);
		
		if(result.getFieldError("id") != null) {
			model.addAttribute("message", result.getFieldError("id").getDefaultMessage());
		} else if(result.getFieldError("pwd") != null) {
			model.addAttribute("message", result.getFieldError("pwd").getDefaultMessage());
		} else if(result.getFieldError("name") != null) {
			model.addAttribute("message", result.getFieldError("name").getDefaultMessage());
		} else if(result.getFieldError("email") != null) {
			model.addAttribute("message", result.getFieldError("email").getDefaultMessage());
		} else if(result.getFieldError("phone") != null) {
			model.addAttribute("message", result.getFieldError("phone").getDefaultMessage());
		} else if(result.getFieldError("address1") != null) {
			model.addAttribute("message", result.getFieldError("address1").getDefaultMessage());
		} else if(!membervo.getId().equals(re_id)) {
			model.addAttribute("message", "아이디 중복체크를 진행해주세요");
		} else if(!membervo.getPwd().equals(pwd_check)) {
			model.addAttribute("message", "비밀번호가 일치하지 않습니다.");
		} else {
			ms.insertMember(membervo);
			mav.setViewName("mobile/member/M_completeJoin");
		}
		return mav;
	}
	
	@RequestMapping("/MEditcheckPwd")
	public String EditcheckPwd(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") == null) {
			return "mobile/member/M_loginForm";
		} else {
			return "mobile/member/M_EditcheckPwd";
		}
	}
	
	@RequestMapping(value="/MEditcheck", method=RequestMethod.POST)
	public ModelAndView Editcheck(@ModelAttribute("member") @Valid MemberVO membervo, BindingResult result,
			@RequestParam(value="id", required=false) String id, 
			@RequestParam(value="pwd", required=false) String pwd, HttpServletRequest request,
			Model model) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("mobile/member/M_EditcheckPwd");
		
		if(result.getFieldError("pwd") != null) {
			mav.addObject("message", result.getFieldError("pwd").getDefaultMessage());
			return mav;
		} else {
			MemberVO mvo = ms.getMember(id);
			if(!mvo.getPwd().equals(pwd)) {
				mav.addObject("message", "비밀번호가 일치하지 않습니다.");
			} else {
				mav.addObject("member", mvo);
				mav.setViewName("mobile/member/M_EditMemberForm");
			}
			return mav;
		}
	}
	
	@RequestMapping(value="/MEditMember", method=RequestMethod.POST)
	public String EditMember(@ModelAttribute("member") @Valid MemberVO membervo,
			BindingResult result,
			@RequestParam("pwd_check") String pwd_check, HttpServletRequest request,
			Model model) {
		
		String url = "mobile/member/M_EditMemberForm";
		
		if(result.getFieldError("pwd") != null) {
			model.addAttribute("message", result.getFieldError("pwd").getDefaultMessage());
		} else if(result.getFieldError("name") != null){
			model.addAttribute("message", result.getFieldError("name").getDefaultMessage());
		} else if(result.getFieldError("email") != null) {
			model.addAttribute("message", result.getFieldError("email").getDefaultMessage());
		} else if(result.getFieldError("phone") != null) {
			model.addAttribute("message", result.getFieldError("phone").getDefaultMessage());
		} else if(result.getFieldError("address1") != null) {
			model.addAttribute("message", result.getFieldError("address1").getDefaultMessage());
		} else if(!membervo.getPwd().equals(pwd_check)) {
			model.addAttribute("message", "비밀번호가 일치하지 않습니다.");
		} else {
			ms.updateMember(membervo);
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", membervo);
			model.addAttribute("message", "회원정보 수정완료, 다시 로그인하세요");
			url = "mobile/member/M_loginForm";
		}
		return url;
	}
	
	@RequestMapping("/MWithdrawcheckPwd")
	public String WithdrawcheckPwd(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginUser") == null) {
			return "mobile/member/M_loginForm";
		} else {
			return "mobile/member/M_WithdrawcheckPwd";
		}
	}
	
	@RequestMapping(value="/MWithdrawcheck", method=RequestMethod.POST)
	public ModelAndView Withdrawcheck(@ModelAttribute("member") @Valid MemberVO membervo, BindingResult result,
			@RequestParam(value="id", required=false) String id, 
			@RequestParam(value="pwd", required=false) String pwd, HttpServletRequest request,
			Model model) {
	ModelAndView mav = new ModelAndView();
	mav.setViewName("mobile/member/M_WithdrawcheckPwd");
	
	if(result.getFieldError("pwd") != null) {
		mav.addObject("message", result.getFieldError("pwd").getDefaultMessage());
		return mav;
	} else {
		MemberVO mvo = ms.getMember(id);
		if(!mvo.getPwd().equals(pwd)) {
			mav.addObject("message", "비밀번호가 일치하지 않습니다.");
		} else {
			int orderNum = ms.getOrderNum(membervo.getId());
			model.addAttribute("orderNum", orderNum);
			mav.addObject("member", mvo);
			mav.setViewName("mobile/member/M_withdrawalForm");
		}
		return mav;
		}
	}
	
	@RequestMapping("/Mwithdrawal")
	public String withdrawal(@RequestParam("id") String id, Model model, HttpServletRequest request) {
		String url = "";
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginUser");
		if(mvo==null) {
			return "mobile/member/M_loginForm";
		} else {
			ms.deleteMember(mvo.getId());
			session.removeAttribute("loginUser");
			url = "redirect:/";
		}
		return url;
	}
	
	@RequestMapping("/MfindIdForm")
	public String findIdForm() {
		return "mobile/member/M_findId";
	}
	
	
	@RequestMapping(value="/MfindId", method=RequestMethod.POST)
	public String findId(@RequestParam(value="name", required=false) String name,
			@RequestParam(value="phone", required=false) String phone,
			HttpServletRequest request, Model model) {
			String url = "mobile/member/MfindId";
			
			MemberVO mvo = ms.getNameMember(name);
			
			if(mvo.getName() == null) {
				model.addAttribute("message", "이름을 입력해주세요.");
			} else if(!mvo.getName().equals(name)){
				model.addAttribute("message", "일치하는 회원이 없습니다.");
			} else if(!mvo.getPhone().equals(phone)) {
				model.addAttribute("message", "전화번호와 일치하는 회원이 없습니다.");
			} else {
				model.addAttribute("memberVO", mvo);
				url = "mobile/member/M_completeFindId";
			}
		return url;
	}
	
	@RequestMapping("/MfindPwdForm")
	public String findPwdForm() {
		return "mobile/member/M_findPwd";
	}
	
	
	@RequestMapping(value="/MfindPwdStep1", method=RequestMethod.POST)
	public String findPwdStep1(@RequestParam(value="id", required=false) String id,
			@RequestParam(value="name", required=false) String name,
			@RequestParam(value="phone", required=false) String phone,
			HttpServletRequest request, Model model) {
			String url = "mobile/member/M_findPwd";
			
			MemberVO mvo = ms.getMember(id);
			
			if(mvo == null) {
				model.addAttribute("message", "아이디를 입력해주세요.");
			} else if(!mvo.getId().equals(id)) {
				model.addAttribute("message", "일치하는 아이디가 없습니다.");
			} else if(!mvo.getName().equals(name)){
				model.addAttribute("message", "일치하는 회원이 없습니다.");
			} else if(!mvo.getPhone().equals(phone)) {
				model.addAttribute("message", "전화번호와 일치하는 회원이 없습니다.");
			} else {
				model.addAttribute("memberVO", mvo);
				url = "mobile/member/M_findPwdConfirmNumber";
			}
		return url;
	}
	
	@RequestMapping(value="/MfindPwdStep2", method=RequestMethod.POST)
	public String findPwdStep2(@RequestParam("id") String id, @RequestParam("name") String name,
			@RequestParam("phone") String phone, @RequestParam("confirmNum") String confirmNum,
			HttpServletRequest request, Model model) {
		model.addAttribute("confirmNum", confirmNum);
		model.addAttribute("id", id);
		model.addAttribute("name", name);
		model.addAttribute("phone", phone);
		
		String url = "mobile/member/M_resetPwd";
		if(!confirmNum.equals("0000")) {
			model.addAttribute("message", "인증번호가 맞지 않습니다.");
			url = "mobile/member/M_findPwdConfirmNumber";
		}
		return url;
	}
	
	@RequestMapping(value="/MresetPwd", method=RequestMethod.POST)
	public String resetPwd(@ModelAttribute("member") @Valid MemberVO membervo, BindingResult result,
			@RequestParam("pwd_chk") String pwd_chk, HttpServletRequest request, Model model) {
		
		String url = "mobile/member/M_resetPwd";
		if(result.getFieldError("pwd") != null) {
			model.addAttribute("message", result.getFieldError("pwd").getDefaultMessage());
		} else {
			if(!membervo.getPwd().equals(pwd_chk)) {
				model.addAttribute("message", "비밀번호가 일치하지 않습니다.");
			} else {
				ms.resetPwd(membervo);
				model.addAttribute("loginUser", membervo);
				url = "mobile/member/M_completeResetPwd";
			}
			return url;
		}
		return url;
	}
}
