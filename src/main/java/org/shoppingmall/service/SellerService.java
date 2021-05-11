package org.shoppingmall.service;

import org.shoppingmall.domain.SellerVO;

public interface SellerService {
	public SellerVO getSellerVO(String id);
	public int deposit(String id, int money);
}
