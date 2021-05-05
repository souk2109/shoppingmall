package org.shoppingmall.domain;

import javafx.beans.DefaultProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class BasketVO {
	private int pno;
	private String sellerId;
	private String sellerName;
	private String busiName;
	private String category;
	private String prdName;
	private int count; // 구매할 상품의 수량
	private int price;
	private float discount;
}
