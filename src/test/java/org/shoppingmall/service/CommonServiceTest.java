package org.shoppingmall.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.shoppingmall.domain.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class CommonServiceTest {
	@Autowired
	private CommonService commonService;
	
	/*
	 * @Test public void registerTest() { UserVO userVO = new UserVO();
	 * userVO.setId("test1"); userVO.setPwd("1234"); userVO.setName("김진석");
	 * userVO.setGender("man"); userVO.setNickname("nick");
	 * userVO.setPostalCode("휴천동"); userVO.setEmail("se@dwe.com");
	 * userVO.setAge(23); int result = commonService.registerUser(userVO,
	 * "ROLE_TEST"); log.info("회원 등록 결과 :"+result); }
	 */
}
