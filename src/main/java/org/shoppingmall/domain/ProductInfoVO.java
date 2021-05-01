package org.shoppingmall.domain;

import java.util.Date;
import java.util.List;

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
	private Date regDate;
	private List<ProductAttachVO> attachList;
}
