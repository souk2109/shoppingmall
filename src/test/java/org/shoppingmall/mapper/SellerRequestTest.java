package org.shoppingmall.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.shoppingmall.domain.AuthVO;
import org.shoppingmall.domain.SellerRequestVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class SellerRequestTest {
	@Autowired
	private SellerRequestMapper mapper;
	@Test
	public void insertRequestTest() {
		SellerRequestVO requestVO = new SellerRequestVO();
		requestVO.setId("user1");
		requestVO.setAccountNum(1232);
		requestVO.setEmail("zzdw");
		requestVO.setName("rqd");
		int result = mapper.insertSellerRequest(requestVO);
		if(result == 1) {
			log.info("요청 성공");
		}
	}
	@Test
	public void getListTest() {
		log.info(mapper.getSellerRequestList());
	}
}
