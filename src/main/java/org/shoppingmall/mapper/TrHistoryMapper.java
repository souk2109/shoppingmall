package org.shoppingmall.mapper;

import java.util.List;

import org.shoppingmall.domain.TrHistoryVO;

public interface TrHistoryMapper {
	public int insertTransactionHistory(TrHistoryVO trHistoryVO);
	// 주문번호를 통한 거래내역
	public TrHistoryVO getTransactionHistoryByNum(int orderNum);
	
	// 특정 소비자의 거래내역
	public List<TrHistoryVO> getClientTransactionHistorys(String clientId);
}
