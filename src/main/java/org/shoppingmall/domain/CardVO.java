package org.shoppingmall.domain;

import lombok.Data;
/*
 * 이름(name), 카드번호(accountNum) pk, 
 * 비밀번호(숫자4자리,pwd), 카드사(bankName, 하나, 국민..),
 * 잔액(balance)
 */
@Data
public class CardVO {
	private String name;
	private String cardNum; //카드 번호
	private int pwd;
	private String bankName; //은행명
	private String validateYear; //유효기간(년)
	private String validateMonth; //유효기간(달)
	private String cvc; //cvc
	private int balance;
}
