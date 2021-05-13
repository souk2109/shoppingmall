package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.TrHistoryVO;

public interface TrHistoryService {
	public int addTrHistory(TrHistoryVO trHistoryVO);

	public List<TrHistoryVO> getClientTransactionHistorys(String clientId);
}
