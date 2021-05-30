package org.shoppingmall.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.shoppingmall.domain.BasketVO;
import org.shoppingmall.domain.Criteria;
import org.shoppingmall.domain.PageDTO;
import org.shoppingmall.domain.ProductAttachVO;
import org.shoppingmall.domain.ProductInfoVO;
import org.shoppingmall.domain.UserVO;
import org.shoppingmall.service.ProductAttachService;
import org.shoppingmall.service.ProductInfoService;
import org.shoppingmall.service.ProductQuestionServiceImpl;
import org.shoppingmall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j; 

@Log4j
@Controller
@RequestMapping("/common/*")
public class CommonController {
	@Autowired
	private UserService userService;
	
	@Autowired
	private ProductInfoService productInfoService;
	
	@Autowired
	private ProductAttachService productAttachService; 
	
	@Autowired
	private ProductQuestionServiceImpl productQuestionServiceImpl;
	
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
	public String doRegister(UserVO userVO, RedirectAttributes rttr) {
		int result = userService.registerUser(userVO, "ROLE_MEMBER");
		if(result == 1) {
			log.info("[회원가입 성공] id: "+userVO.getId());
			rttr.addFlashAttribute("registerResult", "success");
		}
		return "redirect:/common/login";
	}
	
	@GetMapping("/main")
	public void mainPage(Model model, Criteria criteria) {
		log.info(criteria);
		int total = productInfoService.getCount(criteria);
		PageDTO pageDTO = new PageDTO(criteria, total); 
		log.info("pageDTO : "+pageDTO);

		model.addAttribute("products", productInfoService.getProductInfoListWithPaging(criteria));
		model.addAttribute("pageMaker", pageDTO); 
		model.addAttribute("total", total);
	}
	
	@GetMapping("/getProduct")
	public void getProduct(int pno, Model model) {
		// 상품 상세페이지 관련 정보를 view에 전송
		model.addAttribute("product", productInfoService.getProductInfo(pno));
		model.addAttribute("productQuestionList", productQuestionServiceImpl.getProductQuestionList(pno));
	}
	
	// 장바구니 페이지
	@GetMapping("/basket")
	public void basket(HttpServletRequest request, Model model) {
		Cookie[] cookieList = request.getCookies();
		if(cookieList!=null && cookieList.length != 0) {
			List<BasketVO> basketList = new ArrayList<BasketVO>(); 
			for(Cookie cookie : cookieList) {
				String cName = cookie.getName();
				if(cName.startsWith("p")) {
					int pno = Integer.parseInt(cName.substring(1));
					ProductInfoVO productInfoVO = productInfoService.getProductInfo(pno);
					ProductAttachVO productAttachVO =  productAttachService.getProductMainImage(pno);
					BasketVO basketVO = new BasketVO(productInfoVO.getPno(), productInfoVO.getSellerId(),
							productInfoVO.getSellerName(), productInfoVO.getBusiName(),	productInfoVO.getCategory(),
							productInfoVO.getPrdName(), Integer.parseInt(cookie.getValue()), productInfoVO.getPrice(), 
							productInfoVO.getDiscount(), productAttachVO, productInfoVO.getStock());
					basketList.add(basketVO);
				}
			}
			model.addAttribute("basketList", basketList);
		}
	}
	@GetMapping("/findId")
	public void findId() {
		
	}
	@GetMapping("/findPwd")
	public void findPwd() {
		
	}
}
