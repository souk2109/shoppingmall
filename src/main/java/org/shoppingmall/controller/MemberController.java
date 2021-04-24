package org.shoppingmall.controller;

import org.shoppingmall.domain.SellerRequestVO;
import org.shoppingmall.service.MemberService;
import org.shoppingmall.service.SellerRequestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/member/*")
public class MemberController {
	@Autowired
	private SellerRequestService sellerRequestService;
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/myPage")
	public void myPage() {
	}
	@GetMapping("/pwdModify")
	public void modify() {
		
	}
	
	@GetMapping("/sellerApply")
	public void sellerapply() {
	}
	// 판매자 신청 요청
	@PostMapping("/doSellerApply")
	public String doSellerApply(SellerRequestVO sellerRequestVO) {
		sellerRequestService.insertSellerRequest(sellerRequestVO);
		log.info("판매자 신청 성공");
		return "redirect:/member/myPage";
	}
	
	@PostMapping("/doModifyPwd")
	public String doModifyPwd(String id, String oldPwd,String pwd) {
		String result = memberService.changePwd(id, oldPwd, pwd);
		return "redirect:/member/myPage";
	}
}
