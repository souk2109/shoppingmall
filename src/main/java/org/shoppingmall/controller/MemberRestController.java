package org.shoppingmall.controller;

import org.shoppingmall.domain.SellerRequestVO;
import org.shoppingmall.service.SellerRequestService;
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
	@Autowired SellerRequestService sellerRequestService;
	
	@PostMapping(value = "/getSellerRequestValidate")
	public ResponseEntity<String> getSellerRequestValidate(String id){
		String result = sellerRequestService.getSellerRequestValidate(id);
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
	@GetMapping(value = "/getSellerRequest/{id}", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<SellerRequestVO> getSellerRequest(@PathVariable("id") String id) {
		SellerRequestVO sellerRequestVO = sellerRequestService.getSellerRequestVO(id);
		return new ResponseEntity<SellerRequestVO>(sellerRequestVO, HttpStatus.OK);
	}
	 
}
