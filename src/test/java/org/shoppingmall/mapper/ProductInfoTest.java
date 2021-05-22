package org.shoppingmall.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.shoppingmall.domain.Criteria;
import org.shoppingmall.domain.ProductInfoVO;
import org.shoppingmall.domain.ProductQuestionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class ProductInfoTest {
	@Autowired
	private ProductInfoMapper mapper;
	
	@Test
	public void getListTest() {
		Criteria criteria = new Criteria();
		criteria.setKeyword("1");
		criteria.setCategory("clothes");
		List<ProductInfoVO> list = mapper.getProductInfoListWithPaging(criteria );
		list.forEach(vo -> {
			log.info(vo);
		});
	}
}
