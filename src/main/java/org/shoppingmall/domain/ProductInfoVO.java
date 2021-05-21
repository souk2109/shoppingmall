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
	
	private int totalReviewGrade; // 리뷰 별점 누적 합계
	private int reviewNum; // 총 리뷰 개수
}
