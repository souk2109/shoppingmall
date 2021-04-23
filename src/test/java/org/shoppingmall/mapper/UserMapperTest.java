package org.shoppingmall.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.shoppingmall.domain.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UserMapperTest {
	@Autowired
	private UserMapper mapper;
	
	@Test
	public void getListTest() {
		log.info(mapper.getUsersList());
	}
	
	@Test
	public void insertUserTest() {
		UserVO userVO = new UserVO();
		userVO.setId("user2");
		userVO.setPwd("1234");
		userVO.setName("kim");
		userVO.setGender("man");
		userVO.setNickname("nick");
		userVO.setPostalCode("휴천동");
		userVO.setEmail("se@dwe.com");
		//userVO.setAge(23);
		log.info(mapper.insertUser(userVO));
	}
}
