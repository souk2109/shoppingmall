package org.shoppingmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class SellerRequestVO {
	private int num;
	private String name;
	private String id;
	private int accountNum;
	private String email;
	private String status; // default로 '처리중'
	private Date regdate;
	private Date updatedate;
}
