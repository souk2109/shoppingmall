package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.ProductQuestionVO;

public interface ProductQuestionService {
	public int insertProductQuestion(ProductQuestionVO productQuestionVO);
	public List<ProductQuestionVO> getProductQuestionList(int pno);
}
