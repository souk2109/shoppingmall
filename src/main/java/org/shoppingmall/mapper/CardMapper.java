package org.shoppingmall.mapper;

import org.apache.ibatis.annotations.Param;
import org.shoppingmall.domain.CardVO;
import org.shoppingmall.domain.SimpleCardVO;

/*
	카드사와 카드 번호와 비밀번호 일치 여부, 입금(잔액 빼기), 출금(잔액 더하기)
	카드 테이블 (tbl_card) 
	이름(name),
	카드번호(accountNum) pk,
	비밀번호(숫자4자리,pwd),
	카드사(bankName, 하나, 국민..),
	잔액(balance)
*/
public interface CardMapper {
	public int isCardVO(CardVO cardVO); // cardVO로 유효한 카드가 있는지 확인 (1이면 존재)
	public int isCardVO(SimpleCardVO simpleCardVO); // SimpleCardVO로 유효한 카드가 있는지 확인 (1이면 존재)
	public int deposit(@Param("cardVO")CardVO cardVO, @Param("money") int money); // 입금
	public int withdraw(CardVO cardVO, @Param("money") int money); // 출금
}
