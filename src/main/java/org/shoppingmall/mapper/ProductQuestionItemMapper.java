package org.shoppingmall.mapper;

import org.shoppingmall.domain.ProductQuestionItemVO;

public interface ProductQuestionItemMapper {

	public int insertProductQuestionItem(ProductQuestionItemVO firstItemVO);

	public int increaseItemGrade(int ino);

}
