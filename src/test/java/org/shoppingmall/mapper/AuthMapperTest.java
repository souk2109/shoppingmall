package org.shoppingmall.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.shoppingmall.domain.AuthVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class AuthMapperTest {
	@Autowired
	private AuthMapper mapper;
	
	@Test
	public void getListTest() {
		AuthVO auth = new AuthVO();
		auth.setId("user1");
		auth.setAuth("ROLE_USER");
		log.info(mapper.insertAuth(auth));
	}
}
