package org.shoppingmall.controller;

import org.shoppingmall.domain.UserVO;
import org.shoppingmall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j; 

@Log4j
@Controller
@RequestMapping("/common/*")
public class CommonController {
	@Autowired
	private UserService userService;
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/login")
	public void loginPage(String error, Model model) {
		if(error != null)
			model.addAttribute("msg",error);
	}
	
	@PostMapping(value = "/doLogin")
	public void doLogin() {
		
	}
	
	@GetMapping("/register")
	public void registerPage() {
		
	}
	@PostMapping(value = "/doRegister")
	public String doRegister(UserVO userVO) {
		int result = userService.registerUser(userVO, "ROLE_MEMBER");
		if(result == 1) {
			log.info("[회원가입 성공] id: "+userVO.getId());
		}
		return "redirect:/common/login";
	}
	
	@GetMapping("/main")
	public void mainPage() {
	}
	@GetMapping("/products")
	public void products() {
	}
}
