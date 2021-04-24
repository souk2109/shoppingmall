package org.shoppingmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class SellerRequestVO {
	private String name;
	private String id;
	private int accountNum;
	private String email;
	private int status; // default로 0
	private Date regdate;
	private Date successdate;
}
