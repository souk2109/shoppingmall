package org.shoppingmall.domain;

import lombok.Data;

@Data
public class ProductInfoVO {
	private int pno;
	private String sellerId;
	private String sellerName;
	private String busiName;
	private String category;
	private String prdName;
	private int stock;
	private int price;
	private float discount;
}
