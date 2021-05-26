package org.shoppingmall.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class ExceptionController {
	@ExceptionHandler(NoHandlerFoundException.class)
	public ModelAndView handleError404(HttpServletRequest request, Exception e) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("error/404");
		mav.addObject("message", "404오류");
		mav.addObject("url", request.getRequestURL());
		return mav;
	}
}
