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
	// 잔액이 부족하면 피드벡
	// 판매자의 카드로 입금
	@Override
	public String doPayment(CardVO cardVO, int money) {
		// 카드가 유효한 카드인지 확인
		if(cardMapper.isCardVO(cardVO)==0) {
			return "noCard";
		}else{
			// 잔액부족인 경우
			if(cardMapper.withdraw(cardVO, money) == 0) {
				return "noBalance";
			}else {
				return "";
			}
		}
	}
}
