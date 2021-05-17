package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.ProductQuestionVO;
import org.shoppingmall.mapper.ProductQuestionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ProductQuestionServiceImpl implements ProductQuestionService{
	@Autowired
	private ProductQuestionMapper productQuestionMapper;
	@Override
	public int insertProductQuestion(ProductQuestionVO productQuestionVO) {
		int result = productQuestionMapper.insertProductQuestion(productQuestionVO);
		log.info(result);
		return result;
	}
	@Override
	public List<ProductQuestionVO> getProductQuestionList(int pno) {
		return productQuestionMapper.getProductQuestionList(pno);
	}

}
