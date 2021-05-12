package org.shoppingmall.service;

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

}
