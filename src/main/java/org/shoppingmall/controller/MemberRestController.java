package org.shoppingmall.controller;

import java.util.List;

import org.shoppingmall.domain.ProductAttachVO;
import org.shoppingmall.domain.SellerRequestVO;
import org.shoppingmall.domain.SimpleCardVO;
import org.shoppingmall.service.ProductAttachService;
import org.shoppingmall.service.SellerRequestService;
import org.shoppingmall.service.SimpleCardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/member/*")
@Log4j
public class MemberRestController {
	@Autowired 
	SellerRequestService sellerRequestService;
	
	@Autowired
	private SimpleCardService simpleCardService;
	
	@Autowired
	private ProductAttachService productAttachService;
	
	@GetMapping(value = "/getRecentSellerRequest/{id}", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<SellerRequestVO> getRecentSellerRequest(@PathVariable("id") String id) {
		SellerRequestVO sellerRequestVO = sellerRequestService.getRecentSellerRequest(id);
		return new ResponseEntity<SellerRequestVO>(sellerRequestVO, HttpStatus.OK);
	}
	
	@GetMapping(value = "/getSellerRequests/{id}", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<List<SellerRequestVO>> getSellerRequest(@PathVariable("id") String id) {
		List<SellerRequestVO> sellerRequestVO = sellerRequestService.getSellerRequests(id);
		return new ResponseEntity<List<SellerRequestVO>>(sellerRequestVO, HttpStatus.OK);
	}
	@GetMapping(value = "/getSimpleCards/{id}", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<List<SimpleCardVO>> getSimpleCards(@PathVariable("id") String id) {
		List<SimpleCardVO> simpleCardList = simpleCardService.getSimpleCardVO(id);
		return new ResponseEntity<List<SimpleCardVO>>(simpleCardList, HttpStatus.OK);
	}
	@GetMapping(value = "/getProductMainImage/{pno}", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<ProductAttachVO> getProductMainImage(@PathVariable("pno") int pno) {
		ProductAttachVO productAttachVO = productAttachService.getProductMainImage(pno);
		return new ResponseEntity<ProductAttachVO>(productAttachVO, HttpStatus.OK);
	}
	 
}
