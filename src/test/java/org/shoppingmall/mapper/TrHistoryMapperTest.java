package org.shoppingmall.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.shoppingmall.domain.AuthVO;
import org.shoppingmall.domain.TrHistoryVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class TrHistoryMapperTest {
	@Autowired
	private TrHistoryMapper mapper;
	
	@Test
	public void insertTest() {
		TrHistoryVO historyVO = new TrHistoryVO();
		historyVO.setSellerId("판매자아이디");
		historyVO.setSellerName("판매자이름");;
		historyVO.setClientId("손님아이디");
		historyVO.setClientName("손님이름");
		
		historyVO.setBusiName("누구네");
		historyVO.setPno(38);
		historyVO.setPrice(3000);
		historyVO.setCount(3);
		
		int result = mapper.insertTransactionHistory(historyVO);
		System.out.println("결과 : "+result);
	}
	
	@Test
	public void getTest() {
		mapper.getTransactionHistoryByNum(6);
	}
}
