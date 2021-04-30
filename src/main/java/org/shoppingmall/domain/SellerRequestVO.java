package org.shoppingmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class SellerRequestVO {
	private int num;
	private String name;
	private String id;
	private String busiName;
	private String cardNum;
	private int pwd;
	private String bankName; //은행명
	private String validateYear; //유효기간(년)
	private String validateMonth; //유효기간(달)
	private String cvc; //cvc
	private String status; // default로 '처리중'
	private Date regdate;
	private Date updatedate;
	private String email;
}
