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

import com.team2.ticket.dto.MemberVO;
import com.team2.ticket.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	MemberService ms;
	
	@RequestMapping("/loginForm")
	public String loginForm() {
		return "member/loginForm";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(@ModelAttribute("member") @Valid MemberVO membervo, 
			BindingResult result,
			HttpServletRequest request, Model model) {
		String url = "member/loginForm";
		
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
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/";
	}
	
}
