package org.shoppingmall.domain;

import lombok.Data;
/*
 * id varchar(50) not null primary key,
	name varchar(50) not null,
	busiName varchar(50) not null,
    cardNum varchar(50) not null,
	income int not null
 * 
*/

@Data
public class SellerVO {
	private String id;
	private String name;
	private String busiName;
	private String cardNum;
	private int income;
}
