package org.shoppingmall.domain;

import lombok.Data;

@Data
public class ProductQuestionItemVO {
	private int ino; // pk
	private int qno;
	private int pno;
	private String item;
	private int grade;
}
