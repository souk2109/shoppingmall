package org.shoppingmall.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.shoppingmall.domain.BasketVO;
import org.shoppingmall.domain.CardVO;
import org.shoppingmall.domain.PostalDTO;
import org.shoppingmall.domain.ProductAttachVO;
import org.shoppingmall.domain.ProductInfoVO;
import org.shoppingmall.domain.ProductQuestionVO;
import org.shoppingmall.domain.ReviewVO;
import org.shoppingmall.domain.SellerRequestVO;
import org.shoppingmall.domain.SellerVO;
import org.shoppingmall.domain.SimpleCardVO;
import org.shoppingmall.domain.TrHistoryVO;
import org.shoppingmall.security.CustomUserDetails;
import org.shoppingmall.service.CardService;
import org.shoppingmall.service.ProductAttachService;
import org.shoppingmall.service.ProductInfoService;
import org.shoppingmall.service.ProductQuestionService;
import org.shoppingmall.service.ReviewService;
import org.shoppingmall.service.SellerRequestService;
import org.shoppingmall.service.SellerService;
import org.shoppingmall.service.SimpleCardService;
import org.shoppingmall.service.TrHistoryService;
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

	@Autowired
	private SellerService sellerService;

	@Autowired
	private TrHistoryService trHistoryService;

	@Autowired
	private ProductQuestionService productQuestionService;

	@Autowired
	private ReviewService reviewService;
	
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
	
	// ?????? ?????? ????????? (??????????????? ?????? ????????? ??????)
	@GetMapping("/directPayment")
	public void directPayment(int pno,int count, Model model) {
		ProductInfoVO productInfoVO = productInfoService.getProductInfo(pno);
		model.addAttribute("productInfoVO", productInfoVO);
		model.addAttribute("count", count);
	}
	
	// ???????????? ?????? ?????? ????????? (??????????????? ?????? ????????? ??????)
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
	// ????????? ?????? ??????
	@Transactional
	@PostMapping("/doSellerApply")
	public String doSellerApply(SellerRequestVO sellerRequestVO) {
		log.info("sellerRequestVO:" + sellerRequestVO); 
		sellerRequestService.insertSellerRequest(sellerRequestVO);
		log.info("????????? ?????? ??????");
		return "redirect:/member/myPage";
	}
	
	// ???????????? ?????? ??????
	@PostMapping("/doModifyPwd")
	public String doModifyPwd(String id, String oldPwd,String pwd, RedirectAttributes redirectAttributes) {
		String result = userService.changePwd(id, oldPwd, pwd);
		log.info("???????????? ?????? ?????? : "+result);
		redirectAttributes.addFlashAttribute("pwdResult", result);
		return "redirect:/member/myPage";
	}

	// ???????????? ??????
	@PostMapping("/doDeactivate")
	public String doModifyPwd(String id, String pwd, RedirectAttributes redirectAttributes) {
		String result = userService.deactivateUser(id, pwd);
		String url;
		redirectAttributes.addFlashAttribute("deactivateResult", result);
		if(result == "success") {
			// ???????????? ????????? ??????
			SecurityContextHolder.clearContext();
			url = "redirect:/common/main";
		}else {
			url = "redirect:/member/deactivatePage";
		}
		return url;
	}
	// ?????? ?????? ??????
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
	// ?????? ??????
	@Transactional
	@PostMapping("/doBasketPayment")
	public String doPayment(CardVO cardVO, PostalDTO postalDTO, @RequestParam("discountedTotalPrice") int money, RedirectAttributes redirectAttributes, HttpServletRequest request) {
		String msg = cardService.doPayment(cardVO, money);
		String url = ""; 
		if(msg =="noBalance" || msg =="noCard") {
			redirectAttributes.addFlashAttribute("msg", msg);
			url = "redirect:/member/basketPayment";
			return url;
		}
//		???????????? ???????????? ????????? ??????????????? ???.
//		1. ???????????? ?????? ????????? ???????????? ???????????? ???????????? ????????? ????????? ??????????????? ??????.
//		2. ?????????????????? ????????? ????????? ???.
		CustomUserDetails user = (CustomUserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Cookie[] cookieList = request.getCookies();
		if(cookieList!=null && cookieList.length != 0) {
			List<TrHistoryVO> trHistoryList = new ArrayList<TrHistoryVO>();
			for(Cookie cookie : cookieList) {
				String cName = cookie.getName();
				if(cName.startsWith("p")) {
					String count = cookie.getValue(); // ????????? ????????? ??????
					int pno = Integer.parseInt(cName.substring(1));
					// seller?????? id??? ??????????????? ????????????
					ProductInfoVO productInfoVO = productInfoService.getProductInfo(pno);
					String sellerId = productInfoVO.getSellerId(); // ????????? ?????????
					int price = productInfoVO.getPrice();
					float discount = productInfoVO.getDiscount();
					String busiName = productInfoVO.getBusiName();
					
					SellerVO sellerVO = sellerService.getSellerVO(sellerId);
					String sellerCardNum = sellerVO.getCardNum(); // ????????? ????????????
					String sellerName = sellerVO.getName(); // ????????? ??????
					String bankName = sellerVO.getBankName(); // ????????? ??????
					int totalPrice = Integer.parseInt(count) * ((int)(Math.floor(price * (1-discount/100)))/10*10);
					log.info("?????? : " +totalPrice);
					// ???????????? ????????? ????????? ??????.
					productInfoService.minusProductStock(pno, Integer.parseInt(count));
					
					CardVO sellerCardVO = new CardVO();
					sellerCardVO.setCardNum(sellerCardNum);
					sellerCardVO.setName(sellerName);
					sellerCardVO.setBankName(bankName);
					cardService.deposit(sellerCardVO, totalPrice);
					
					// tbl_seller????????? ???????????? ??????(income)?????? ??????????????? ??????.
					sellerService.deposit(sellerId, totalPrice);
					redirectAttributes.addFlashAttribute("money", money);
					url = "redirect:/member/afterPayment";
					TrHistoryVO historyVO = new TrHistoryVO();
					historyVO.setSellerId(sellerId);
					historyVO.setSellerName(sellerName);
					historyVO.setSellerCardNum(sellerCardNum);
					historyVO.setClientId(user.getUsername());
					historyVO.setClientName(user.getName());
					historyVO.setPaymentCardBankName(cardVO.getBankName());
					historyVO.setPaymentCardName(cardVO.getName());
					historyVO.setPaymentCardNum(cardVO.getCardNum());
					historyVO.setBusiName(busiName);
					historyVO.setPno(pno);
					historyVO.setPrice(totalPrice);
					historyVO.setCount(Integer.parseInt(count));
					historyVO.setProductName(productInfoVO.getPrdName());
					
					// ????????? ????????? ??????
					historyVO.setPostalCode(postalDTO.getPostalCode());
					historyVO.setRoadAddress(postalDTO.getRoadAddress());
					historyVO.setDetailAddress(postalDTO.getDetailAddress());
					
					trHistoryList.add(historyVO);
					trHistoryService.addTrHistory(historyVO);
				}
			}
			redirectAttributes.addFlashAttribute("trHistoryList", trHistoryList);
		}
		return url;
	}
	@PostMapping("/doDirectPayment")
	@Transactional
	public String doDirectPayment(CardVO cardVO, int pno, int count , PostalDTO postalDTO, RedirectAttributes redirectAttributes) {
		ProductInfoVO productInfoVO = productInfoService.getProductInfo(pno);
		int price = productInfoVO.getPrice();
		float discount = productInfoVO.getDiscount();
		int totalPrice = count * ((int)(Math.floor(price * (1-discount/100)))/10*10);
		String busiName = productInfoVO.getBusiName();
		String msg = cardService.doPayment(cardVO, totalPrice); // ???????????? ???????????? ??????
		String url = ""; 
		if(msg =="noBalance" || msg =="noCard") {
			redirectAttributes.addFlashAttribute("msg", msg);
			url = "redirect:/member/basketPayment";
			return url;
		}
		CustomUserDetails user = (CustomUserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String clientId = user.getUsername();
		String clientName = user.getName();
		String sellerId = productInfoVO.getSellerId();
		SellerVO sellerVO = sellerService.getSellerVO(sellerId);
		String sellerCardNum = sellerVO.getCardNum(); // ????????? ????????????
		String sellerName = sellerVO.getName(); // ????????? ??????
		String bankName = sellerVO.getBankName(); // ????????? ??????
		
		CardVO sellerCardVO = new CardVO();
		sellerCardVO.setCardNum(sellerCardNum);
		sellerCardVO.setName(sellerName);
		sellerCardVO.setBankName(bankName);
		cardService.deposit(sellerCardVO, totalPrice);
		
		
		// tbl_seller????????? ???????????? ??????(income)?????? ??????????????? ??????.
		sellerService.deposit(sellerId, totalPrice);
		redirectAttributes.addFlashAttribute("money", totalPrice);
		url = "redirect:/member/afterPayment";
		
		// ???????????? ????????? ????????? ??????.
		productInfoService.minusProductStock(pno, count);
		
		TrHistoryVO historyVO = new TrHistoryVO();
		historyVO.setSellerId(sellerId);
		historyVO.setSellerName(sellerName);
		historyVO.setSellerCardNum(sellerCardNum);
		historyVO.setClientId(clientId);
		historyVO.setClientName(clientName);
		historyVO.setPaymentCardBankName(cardVO.getBankName());
		historyVO.setPaymentCardName(cardVO.getName());
		historyVO.setPaymentCardNum(cardVO.getCardNum());
		historyVO.setBusiName(busiName);
		historyVO.setPno(pno);
		historyVO.setPrice(totalPrice);
		historyVO.setCount(count);
		historyVO.setProductName(productInfoVO.getPrdName());
		
		// ????????? ????????? ??????
		historyVO.setPostalCode(postalDTO.getPostalCode());
		historyVO.setRoadAddress(postalDTO.getRoadAddress());
		historyVO.setDetailAddress(postalDTO.getDetailAddress());
		
		List<TrHistoryVO> trHistoryList = new ArrayList<TrHistoryVO>();
		trHistoryList.add(historyVO);
		trHistoryService.addTrHistory(historyVO);
		redirectAttributes.addFlashAttribute("trHistoryList", trHistoryList);
		 
		return url;
	}
	
	@GetMapping("/orderInfo")
	public void orderInfo(Model model) {
		CustomUserDetails user = (CustomUserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<TrHistoryVO> trHistoryList = trHistoryService.getClientTransactionHistorys(user.getUsername());
		model.addAttribute("trHistoryList", trHistoryList);
	}
	
	@PostMapping("/cancelOrder")
	public String cancelOrder(int orderNum, RedirectAttributes redirectAttributes) {
		trHistoryService.cancelOrder(orderNum);
		redirectAttributes.addFlashAttribute("result", "cancelSuccess");
		return "redirect:/member/orderInfo";
	}
	
	@GetMapping("/afterPayment")
	public void afterPayment() {
		
	}
	@GetMapping("/basicAddressModify")
	public void basicAddressModify() {
		
	}
	@GetMapping("/writeReview")
	public void writeReview(int pno, int orderNum, String clientId, Model model) {
		int result = trHistoryService.getValidateCheck(pno, orderNum, clientId);
		if(result == 0) {
			model.addAttribute("validateCheck", "false");
			return;
		}
		List<ProductQuestionVO> questionList = productQuestionService.getProductQuestionList(pno);
		TrHistoryVO trHistoryVO = trHistoryService.getTransactionHistory(orderNum);
		model.addAttribute("questionList", questionList);
		model.addAttribute("trHistoryVO", trHistoryVO);
	}
	
	@PostMapping("/registerReview")
	public String registerReview(ReviewVO reviewVO) {
		CustomUserDetails user = (CustomUserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		// ???????????? ????????? ??????
		reviewVO.setNickname(user.getNickname());
		log.info(reviewVO);
		// ????????? ????????? ???????????? ??????, ??????????????? ???????????? ?????? ??????, ???????????? ????????? ?????? ????????? ??????
		reviewService.addReview(reviewVO);
		return "redirect:/member/orderInfo";
	}
	
	// ?????? ????????? ?????? ??????
	@PostMapping("/doModifyBasicAddress")
	public String doModifyBasicAddress(String id, PostalDTO postalDTO, RedirectAttributes redirectAttributes) {
		CustomUserDetails user = (CustomUserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		user.setPostalCode(postalDTO.getPostalCode());
		user.setRoadAddress(postalDTO.getRoadAddress());
		user.setDetailAddress(postalDTO.getDetailAddress());
		log.info("postalDTO : "+postalDTO);
		String result = userService.changeBasicAdress(id, postalDTO);
		log.info("?????? ????????? ?????? ?????? : "+result);
		redirectAttributes.addFlashAttribute("adressResult", result);
		return "redirect:/member/myPage";
	}
}
