package org.shoppingmall.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.shoppingmall.domain.BasketVO;
import org.shoppingmall.domain.ProductAttachVO;
import org.shoppingmall.domain.ReviewAttachVO;
import org.shoppingmall.service.ProductAttachService;
import org.shoppingmall.service.ReviewAttachService;
import org.shoppingmall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping(value = "/common/*")
public class CommonRestController {
	@Autowired
	private UserService userService;
	@Autowired
	private ReviewAttachService reviewAttachService;
	
	@PostMapping(value = "/getIdValidate")
	public ResponseEntity<String> getIdValidate(String id){
		String result = userService.getIdValidate(id);
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	 
	@PostMapping(value = "/addBasket", consumes = "application/json",produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> addBasket(@RequestBody BasketVO basketVO, HttpServletResponse response){
		Cookie cookie = new Cookie("p" + String.valueOf(basketVO.getPno()), String.valueOf(basketVO.getCount()));
		cookie.setPath("/");
		cookie.setMaxAge(60*60*24*7);
		response.addCookie(cookie);
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	@PostMapping(value = "/removeBasket", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> removeBasket(int pno, HttpServletResponse response, HttpServletRequest request){
		String tagetCookieName = "p"+pno;
		
		Cookie cookie = new Cookie(tagetCookieName, null);
		cookie.setMaxAge(0);
		cookie.setPath("/");
		response.addCookie(cookie);
		
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	@PostMapping(value = "/updateBasket", produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> updateBasket(int pno, int count, HttpServletResponse response, HttpServletRequest request){
		String tagetCookieName = "p"+pno;
		
		Cookie cookie = new Cookie(tagetCookieName, String.valueOf(count));
		cookie.setMaxAge(60*60*24*7);
		cookie.setPath("/");
		response.addCookie(cookie);
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}

	@ResponseBody
	@GetMapping(value = "/getReviewImages/{rno}", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE })
	public ResponseEntity<List<ReviewAttachVO>> getReviewImages(@PathVariable("rno") int rno) {
		List<ReviewAttachVO> list = reviewAttachService.getReviewImages(rno);
		return new ResponseEntity<List<ReviewAttachVO>>(list, HttpStatus.OK);
	}
}
