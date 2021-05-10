package org.shoppingmall.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.shoppingmall.domain.BasketVO;
import org.shoppingmall.domain.CardVO;
import org.shoppingmall.domain.ProductAttachVO;
import org.shoppingmall.domain.ProductInfoVO;
import org.shoppingmall.domain.SellerRequestVO;
import org.shoppingmall.domain.SimpleCardVO;
import org.shoppingmall.security.CustomUserDetails;
import org.shoppingmall.service.CardService;
import org.shoppingmall.service.ProductAttachService;
import org.shoppingmall.service.ProductInfoService;
import org.shoppingmall.service.SellerRequestService;
import org.shoppingmall.service.SimpleCardService;
import org.shoppingmall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	
	@Autowired
	private SimpleCardService simpleCardService;
	
	@Autowired
	private ProductInfoService productInfoService;
	
	@Autowired
	private ProductAttachService productAttachService;
	
	@Autowired
	private CardService cardService;
	
	@GetMapping("/myPage")
	public void myPage(Model model, SecurityContextHolder contextHolder) {
		Authentication authentication =  SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails user = (CustomUserDetails)authentication.getPrincipal();
		model.addAttribute("myCard", simpleCardService.getSimpleCardVO(user.getUsername()));
	}
	@GetMapping("/pwdModify")
	public void modify() {
		
	}
	
	@GetMapping("/sellerApply")
	public void sellerapply() {
	}
	
	@GetMapping("/deactivatePage")
	public void deactivatePage() {
	}
	@GetMapping("/regSimpleCard")
	public void regSimpleCard() {
	}
	
	// 상품 결제 페이지 (회원가입을 해야 결제가 가능)
	@GetMapping("/directPayment")
	public void directPayment(Model model) {
			
	}
	
	// 장바구니 상품 결제 페이지 (회원가입을 해야 결제가 가능)
	@GetMapping("/basketPayment")
	public void payment(Model model, HttpServletRequest request) {
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
	// 판매자 신청 요청
	@Transactional
	@PostMapping("/doSellerApply")
	public String doSellerApply(SellerRequestVO sellerRequestVO) {
		log.info("sellerRequestVO:" + sellerRequestVO); 
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

	// 회원탈퇴 요청
	@PostMapping("/doDeactivate")
	public String doModifyPwd(String id, String pwd, RedirectAttributes redirectAttributes) {
		String result = userService.deactivateUser(id, pwd);
		String url;
		redirectAttributes.addFlashAttribute("deactivateResult", result);
		if(result == "success") {
			// 시큐리티 세션을 삭제
			SecurityContextHolder.clearContext();
			url = "redirect:/common/main";
		}else {
			url = "redirect:/member/deactivatePage";
		}
		return url;
	}
	// 간편 계좌 등록
	@PostMapping("/doRegSimpleCard")
	public String regSimpleCard(SimpleCardVO simpleCardVO, RedirectAttributes redirectAttributes) {
		String result = simpleCardService.regSimpleCard(simpleCardVO);
		String url;
		redirectAttributes.addFlashAttribute("regSimpleCardResult",result);
		if(result == "success") {
			url = "redirect:/member/myPage";
		}else {
			url = "redirect:/member/regSimpleCard";
		}
		return url;
	}
	// 결제 하기
	@Transactional
	@PostMapping("/doPayment")
	public String doPayment(CardVO cardVO,@RequestParam("discountedTotalPrice") int money, RedirectAttributes redirectAttributes) {
		String msg = cardService.doPayment(cardVO, money);
		log.info(msg);
		// TODO : 결제 페이지로 이동하도록 수정
		String url = "redirect:/member/myPage";
		if(msg =="noBalance" || msg =="noCard") {
			redirectAttributes.addFlashAttribute("msg", msg);
			url = "redirect:/member/basketPayment";
		}
		return url;
	}
}
