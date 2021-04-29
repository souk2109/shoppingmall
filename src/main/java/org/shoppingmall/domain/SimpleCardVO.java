package org.shoppingmall.domain;

import lombok.Data;

// 간편 결제 카드정보를 저장
@Data
public class SimpleCardVO {
	private String id;
	private String name;
	private String cardNum;
	private String validateMonth;
	private String validateYear;
	private String cvc; //cvc
	private int pwd;
	private String bankName;
}
