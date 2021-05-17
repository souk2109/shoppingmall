package org.shoppingmall.service;

import org.shoppingmall.domain.ProductQuestionItemVO;
import org.shoppingmall.mapper.ProductQuestionItemMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductQuestionItemServiceImpl implements ProductQuestionItemService{
	@Autowired
	private ProductQuestionItemMapper productQuestionItemMapper; 
	
	@Override
	public void addProductQuestionItem(ProductQuestionItemVO firstItemVO) {
		productQuestionItemMapper.insertProductQuestionItem(firstItemVO);
	}

}
