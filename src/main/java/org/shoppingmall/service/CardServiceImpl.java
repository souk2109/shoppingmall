package org.shoppingmall.service;

import org.shoppingmall.domain.CardVO;
import org.shoppingmall.mapper.CardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
@Log4j
@Service
public class CardServiceImpl implements CardService{
	@Autowired
	private CardMapper cardMapper;
	
	// 결제시 구매자의 카드에서 출금 (ok)
	// 판매자의 카드로 입금
	@Override
	public int doPayment(CardVO cardVO, int money) {
		log.info(cardVO);
		log.info(money);
		return cardMapper.withdraw(cardVO, money);
	}
}
