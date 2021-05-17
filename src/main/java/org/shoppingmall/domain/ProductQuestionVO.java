package org.shoppingmall.domain;

import java.util.List;

import lombok.Data;

@Data
public class ProductQuestionVO {
	private int qno;
	private int pno;
	private String question;
	private List<ProductQuestionItemVO> itemList;
}
