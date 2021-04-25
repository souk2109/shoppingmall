package org.shoppingmall.controller;

import org.shoppingmall.domain.SellerRequestVO;
import org.shoppingmall.service.SellerRequestService;
import org.shoppingmall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/member/*")
public class MemberController {
	@Autowired
	private SellerRequestService sellerRequestService;
	
	@Autowired
	private UserService userService;
	
	@GetMapping("/myPage")
	public void myPage(String result) {
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
	// 비밀번호 변경 요청
	@PostMapping("/doModifyPwd")
	public String doModifyPwd(String id, String oldPwd,String pwd, RedirectAttributes redirectAttributes) {
		String result = userService.changePwd(id, oldPwd, pwd);
		log.info("비밀번호 변경 결과 : "+result);
		redirectAttributes.addFlashAttribute("pwdResult", result);
		return "redirect:/member/myPage";
	}
}
