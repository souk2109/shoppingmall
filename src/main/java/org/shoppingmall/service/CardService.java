package org.shoppingmall.service;

import org.shoppingmall.domain.CardVO;

public interface CardService {
	public String doPayment(CardVO cardVO, int money);
}
