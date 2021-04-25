package org.shoppingmall.controller;

import java.util.List;

import org.shoppingmall.domain.SellerRequestVO;
import org.shoppingmall.service.SellerRequestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/admin/*")
@Log4j
public class AdminRestController {
	@Autowired
	private SellerRequestService sellerRequestService;
	
	@GetMapping(value = "/getAllSellerRequests", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<List<SellerRequestVO>> getAllSellerRequests() {
		List<SellerRequestVO> list = sellerRequestService.getAllSellerRequests();
		return new ResponseEntity<List<SellerRequestVO>>(list, HttpStatus.OK);
	}
}




