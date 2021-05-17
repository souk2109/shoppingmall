package org.shoppingmall.mapper;

import java.util.List;

import org.shoppingmall.domain.ProductQuestionVO;

public interface ProductQuestionMapper {
	public List<ProductQuestionVO> getProductQuestionList(int pno);
	public int insertProductQuestion(ProductQuestionVO productQuestionVO);
}
