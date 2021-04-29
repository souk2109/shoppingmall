package org.shoppingmall.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.shoppingmall.domain.CardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class CardMapperTest {
	@Autowired
	private CardMapper cardMapper;
	
	@Test
	public void getCardVO() {
		CardVO cardVO = new CardVO();
		cardVO.setName("user1");
		cardVO.setPwd(1234);
		cardVO.setCardNum("123456781234");
		cardVO.setBankName("하나");
		cardVO.setValidateMonth("03");
		cardVO.setValidateYear("2022");
		cardVO.setCvc("123");
		int result = cardMapper.isCardVO(cardVO);
		if(result == 1) {
			System.out.println("존재함");
		}else {
			System.out.println("존재하지 않음");
		}
	}
	
	@Test
	public void deposit() {
		CardVO cardVO = new CardVO();
		cardVO.setName("user1");
		cardVO.setPwd(1234);
		cardVO.setCardNum("123456781234");
		cardVO.setBankName("하나");
		cardMapper.deposit(cardVO, 2000);
	}
}
