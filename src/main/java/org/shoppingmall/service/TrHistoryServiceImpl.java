package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.TrHistoryVO;
import org.shoppingmall.mapper.TrHistoryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TrHistoryServiceImpl implements TrHistoryService{
	@Autowired
	private TrHistoryMapper trHistoryMapper;
	
	@Override
	public int addTrHistory(TrHistoryVO trHistoryVO) {
		return trHistoryMapper.insertTransactionHistory(trHistoryVO);
	}

	@Override
	public List<TrHistoryVO> getClientTransactionHistorys(String clientId) {
		return trHistoryMapper.getClientTransactionHistorys(clientId);
	}

	@Override
	public List<TrHistoryVO> getSellerTransactionHistorys(String sellerId) {
		return trHistoryMapper.getSellerTransactionHistorys(sellerId);
	}

	@Override
	public TrHistoryVO getTransactionHistory(int orderNum) {
		return trHistoryMapper.getTransactionHistory(orderNum);
	}

	@Override
	public String modifyStatusToShipping(int orderNum, String prdStatus) {
		trHistoryMapper.updateStatusToShipping(orderNum, prdStatus);
		return "modifyStatusToShipping";
	}

	@Override
	public String modifyStatusToArrive(int orderNum, String prdStatus) {
		trHistoryMapper.updateStatusToArrive(orderNum, prdStatus);
		return "modifyStatusToArrive";
	}

	@Override
	public String modifyStatusToCancel(int orderNum, String prdStatus) {
		trHistoryMapper.updateStatusToCancel(orderNum, prdStatus);
		return "modifyStatusToCancel";
	}

}
