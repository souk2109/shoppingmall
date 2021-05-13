package org.shoppingmall.domain;

import java.util.Date;

import lombok.Data;

// 거래내역을 정보를 담을 객체
@Data
public class TrHistoryVO {
	private int orderNum; // 주문번호
	private String sellerId; // 판매자 아이디
	private String sellerName; // 판매자 이름
	private String sellerCardNum; // 판매자 카드번호
	
	private String clientId; // 구매자 아이디
	private String clientName; // 구매자 이름
	
	private String paymentCardNum; // 결제한 카드번호
	private String paymentCardBankName; // 결제한 카드 은행 명
	private String paymentCardName; // 카드 주인 이름
	private String productName; // 상품명
	private String busiName; // 상호명
	private int pno; // 상품번호
	private int price; // 상품 결제 금액
	private String prdStatus; // 상품의 상태(배송중 등..)
	private Date buyDate; // 구매 날짜
	private int count; // 구매 수량
}
