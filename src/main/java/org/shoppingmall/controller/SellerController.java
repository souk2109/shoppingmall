package org.shoppingmall.controller;

import org.shoppingmall.domain.ProductInfoVO;
import org.shoppingmall.mapper.SellerRequestMapper;
import org.shoppingmall.security.CustomUserDetails;
import org.shoppingmall.service.ProductInfoService;
import org.shoppingmall.service.SellerRequestService;
import org.shoppingmall.service.SellerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/seller/*")
@Log4j
public class SellerController {
	@Autowired
	private SellerService sellerService;
	@Autowired
	private ProductInfoService productInfoService;
	
	@GetMapping("/regProduct")
	public void regProduct(Model model) {
		model.addAttribute("seller", sellerService.getSellerVO(getLoginedId()));
	}
	
	@GetMapping("/myProducts")
	public void myProducts(Model model) {
		model.addAttribute("products", productInfoService.getProductInfoList(getLoginedId()));
	}
	@GetMapping("/product")
	public void myProducts(int pno, Model model) {
		model.addAttribute("product", productInfoService.getProductInfo(pno));
	}
	
	
	@PostMapping("/doRegisteProduct")
	public String regProduct(ProductInfoVO productInfoVO) {
		productInfoService.insertProductInfoVO(productInfoVO);
		return "redirect:/seller/myProducts";
	}
	@PostMapping("/modifyProductInfoVO")
	public String modifyProductInfoVO(ProductInfoVO productInfoVO) {
		productInfoService.modifyProductInfoVO(productInfoVO);
		return "redirect:/seller/myProducts";
	}
	
	
	
	private String getLoginedId() {
		Authentication authentication =  SecurityContextHolder.getContext().getAuthentication();
		CustomUserDetails user = (CustomUserDetails)authentication.getPrincipal();
		return user.getUsername();
	}
}
