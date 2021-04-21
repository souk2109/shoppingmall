package org.shoppingmall.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/common/*")
public class UserController {
	@GetMapping("/home")
	public void home() {
		
	}
	@GetMapping("/loginPage")
	public void loginPage() {
		
	}
	@GetMapping("/registerPage")
	public void registerPage() {
		
	}
}
