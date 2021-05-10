package org.shoppingmall.service;

import org.shoppingmall.domain.CardVO;

public interface CardService {
	public int doPayment(CardVO cardVO, int money);
}
