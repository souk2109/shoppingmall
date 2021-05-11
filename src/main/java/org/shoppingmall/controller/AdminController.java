package org.shoppingmall.controller;

import org.shoppingmall.domain.CardVO;
import org.shoppingmall.domain.SellerRequestVO;
import org.shoppingmall.domain.SellerVO;
import org.shoppingmall.domain.UserVO;
import org.shoppingmall.service.SellerRequestService;
import org.shoppingmall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.log4j.Log4j;
// 관리자 컨트롤러
@Controller
@RequestMapping("/admin/*")
@Log4j
public class AdminController {
	@Autowired
	private UserService userService;
	@Autowired
	private SellerRequestService sellerRequestService;
	
	@GetMapping("/main")
	public void main() {
	}
	@GetMapping("/showSellerRequests")
	public void showSellerRequests() {
		
	}
	@GetMapping("/sellerRequest")
	public void sellerRequest(@RequestParam("id") String id,Model model) {
		UserVO user = userService.getUserById(id);
		SellerRequestVO sellerRequest = sellerRequestService.getRecentSellerRequest(id);
		model.addAttribute("user", user);
		model.addAttribute("sellerRequest", sellerRequest);
	}
	
	@PostMapping("/agreeSellerRequest")
	public String agreeSellerRequest(SellerVO sellerVO, CardVO cardVO) {
		log.info(cardVO);
		sellerRequestService.agreeSellerRequest(sellerVO, cardVO);
		return "redirect:/admin/showSellerRequests";
	}
	
	@PostMapping("/rejectSellerRequest")
	public String rejectSellerRequest(@RequestParam("id") String id) {
		sellerRequestService.rejectSellerRequest(id);
		return "redirect:/admin/showSellerRequests";
	}
	 
}
