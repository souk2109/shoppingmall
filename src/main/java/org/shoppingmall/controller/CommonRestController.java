package org.shoppingmall.controller;

import org.shoppingmall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping(value = "/common/*")
public class CommonRestController {
	@Autowired
	private UserService userService;
	
	@PostMapping(value = "/getIdValidate")
	public ResponseEntity<String> getIdValidate(String id){
		String result = userService.getIdValidate(id);
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
}
