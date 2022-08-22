package com.team2.ticket.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.team2.ticket.dto.MemberVO;
import com.team2.ticket.service.MypageMemberService;

@Controller
public class MypageMemberController {
	@Autowired
	MypageMemberService mms;
	
	@RequestMapping("/mypage")
	public String withdrawal_form(HttpServletRequest request, Model model) {
		return "redirect:/goodsCartList";
	}
	
	@RequestMapping("/checkPwdForm")
	public String check_pwd_form(HttpServletRequest request, Model model,
			@RequestParam("purpose") String purpose) {
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null)
			return "member/loginForm";
		else {
			model.addAttribute("purpose", purpose);
		}
		return "mypage/checkPwd";
	}
	
	@RequestMapping("/checkPwd")
	public String check_pwd(HttpServletRequest request, Model model,
			@RequestParam("purpose") String purpose,
			@RequestParam("pwd") String pwd) {
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		String url = "mypage/checkPwd";
		if(loginUser == null)
			return "member/loginForm";
		else {
			if(loginUser.getPwd()==null) {
				model.addAttribute("message", "비밀번호 오류. 관리자에게 문의하세요.");
			} else if(pwd.equals(loginUser.getPwd())) {
				int orderNum = mms.getOrderNum(loginUser.getId());
				model.addAttribute("orderNum", orderNum);
				url = "mypage/"+purpose;
			} else {
				request.setAttribute("message", "비밀번호가 틀렸습니다.");
			}
		}
		return url;
	}
	
	@RequestMapping("/withdrawal")
	public String withdrawal(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		MemberVO loginUser
			= (MemberVO)session.getAttribute("loginUser");
		if(loginUser == null)
			return "member/loginForm";
		else {
			mms.deleteMember(loginUser.getId());
			session.removeAttribute("loginUser");
		}
		return "redirect:/";
	}

//	@RequestMapping("/modifyMember")
//	public String modify_member_form(HttpServletRequest request, Model model) {
//		return "";
//	}
}
