package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.TrHistoryVO;

public interface TrHistoryService {
	public int addTrHistory(TrHistoryVO trHistoryVO);

	public List<TrHistoryVO> getClientTransactionHistorys(String clientId);

	public List<TrHistoryVO> getSellerTransactionHistorys(String sellerId);

	public TrHistoryVO getTransactionHistory(int orderNum);

	public String modifyStatusToShipping(int orderNum, String prdStatus);

	public String modifyStatusToArrive(int orderNum, String prdStatus);

	public String cancelOrder(int orderNum);

}
