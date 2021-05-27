package org.shoppingmall.controller;

import java.util.List;

import org.shoppingmall.domain.ProductAttachVO;
import org.shoppingmall.domain.ReviewAttachVO;
import org.shoppingmall.domain.ReviewVO;
import org.shoppingmall.domain.SellerRequestVO;
import org.shoppingmall.domain.SimpleCardVO;
import org.shoppingmall.service.ProductAttachService;
import org.shoppingmall.service.ReviewAttachService;
import org.shoppingmall.service.ReviewService;
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
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	@Autowired
	private ReviewAttachService reviewAttachService;
	
	@Autowired
	private ReviewService reviewService;
	
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
	
	@ResponseBody
	@GetMapping(value = "/getReviewImages/{rno}", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<List<ReviewAttachVO>> getReviewImages(@PathVariable("rno") int rno) {
		List<ReviewAttachVO> list = reviewAttachService.getReviewImages(rno);
		return new ResponseEntity<List<ReviewAttachVO>>(list, HttpStatus.OK);
	}
	
	@GetMapping(value = "/getReviewByOrderNum/{orderNum}", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<ReviewVO> getReviewByOrderNum(@PathVariable("orderNum") int orderNum) {
		ReviewVO reviewVO = reviewService.getReviewByOrderNum(orderNum);
		return new ResponseEntity<ReviewVO>(reviewVO, HttpStatus.OK);
	}
	 
}
