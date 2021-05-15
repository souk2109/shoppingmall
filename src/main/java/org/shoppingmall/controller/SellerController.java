package org.shoppingmall.controller;

import java.util.List;

import org.shoppingmall.domain.ProductInfoVO;
import org.shoppingmall.domain.TrHistoryVO;
import org.shoppingmall.mapper.SellerRequestMapper;
import org.shoppingmall.security.CustomUserDetails;
import org.shoppingmall.service.ProductInfoService;
import org.shoppingmall.service.SellerRequestService;
import org.shoppingmall.service.SellerService;
import org.shoppingmall.service.TrHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/seller/*")
@Log4j
public class SellerController {
	@Autowired
	private SellerService sellerService;
	@Autowired
	private ProductInfoService productInfoService;
	@Autowired
	private TrHistoryService trHistoryService;
	
	@GetMapping("/regProduct")
	public void regProduct(Model model) {
		model.addAttribute("seller", sellerService.getSellerVO(getLoginedId()));
	}
	
	@GetMapping("/myProducts")
	public void myProducts(Model model) {
		model.addAttribute("products", productInfoService.getProductInfoList(getLoginedId()));
	}
	
	@GetMapping("/modProduct")
	public void modifyProduct(int pno, Model model) {
		model.addAttribute("product", productInfoService.getProductInfo(pno));
	}
	
	@PostMapping("/doRegisteProduct")
	public String regProduct(ProductInfoVO productInfoVO) {
		productInfoService.insertProductInfoVO(productInfoVO);
		log.info(productInfoVO);
		return "redirect:/seller/myProducts";
	}
	
	@PostMapping("/modifyProductInfoVO")
	public String modifyProductInfoVO(ProductInfoVO productInfoVO) {
		productInfoService.modifyProductInfoVO(productInfoVO);
		log.info(productInfoVO);
		return "redirect:/seller/myProducts";
	}
	
	@GetMapping("/sellerInfo")
	public void sellerInfo(Model model) {
		CustomUserDetails user = (CustomUserDetails)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<TrHistoryVO> trHistoryList = trHistoryService.getSellerTransactionHistorys(user.getUsername());
		model.addAttribute("trHistoryList", trHistoryList);
	}
	@GetMapping("/detail")
	public void sellerInfo(int orderNum, Model model) {
		TrHistoryVO trHistory = trHistoryService.getTransactionHistory(orderNum);
		model.addAttribute("trHistory", trHistory);
	}
	@PostMapping("/modifyDetail")
	public String modifyDetail(int orderNum, String prdStatus,RedirectAttributes redirectAttributes) {
		log.info("prdStatus : " + prdStatus);
		String result = "";
		if("shipping".equals(prdStatus)) {
			result = trHistoryService.modifyStatusToShipping(orderNum, prdStatus);
		}
		else if("arrive".equals(prdStatus)) {
			result = trHistoryService.modifyStatusToArrive(orderNum, prdStatus);
		}
		
		redirectAttributes.addFlashAttribute("modifyDetailResult", result);
		return "redirect:/seller/sellerInfo";
	}
	private String getLoginedId() {
		Authentication authentication =  SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails user = (CustomUserDetails)authentication.getPrincipal();
		return user.getUsername();
	}
}
