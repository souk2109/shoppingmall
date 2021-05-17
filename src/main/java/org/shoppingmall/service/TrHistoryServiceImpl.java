package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.CardVO;
import org.shoppingmall.domain.ProductInfoVO;
import org.shoppingmall.domain.SellerVO;
import org.shoppingmall.domain.TrHistoryVO;
import org.shoppingmall.mapper.CardMapper;
import org.shoppingmall.mapper.ProductInfoMapper;
import org.shoppingmall.mapper.SellerMapper;
import org.shoppingmall.mapper.TrHistoryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;
@Log4j
@Service
public class TrHistoryServiceImpl implements TrHistoryService{
	@Autowired
	private TrHistoryMapper trHistoryMapper;
	
	@Autowired
	private CardMapper cardMapper;
	
	@Autowired
	private SellerMapper sellerMapper;
	
	@Override
	public int addTrHistory(TrHistoryVO trHistoryVO) {
		int result = trHistoryMapper.insertTransactionHistory(trHistoryVO);
		log.info(result);
		return result;
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

	// 사용자가 주문을 취소한 경우
	// 1. 구매내역에서 상태를 cancel로 변경
	// 2. 판매자의 계좌에서 돈 착감
	// 3. 구매자의 계좌에 돈 입금
	// 4. 판매자의 수입에서 착감
	@Transactional
	@Override
	public String cancelOrder(int orderNum) {
		 
		// 주문상태 '취소'로 변경
		TrHistoryVO trHistoryVO = trHistoryMapper.getTransactionHistory(orderNum);
		trHistoryMapper.updateStatusToCancel(orderNum, "cancel");
		
		int price = trHistoryVO.getPrice();
		String sellerId = trHistoryVO.getSellerId();
		
		// 판매자의 계좌에서 착감
		SellerVO sellerVO = sellerMapper.getSellerVO(sellerId);
		CardVO sellerCardVO = new CardVO();
		sellerCardVO.setBankName(sellerVO.getBankName());
		sellerCardVO.setName(sellerVO.getName());
		sellerCardVO.setCardNum(sellerVO.getCardNum());
		cardMapper.authWithdraw(sellerCardVO, price);
		
		// 구매자의 계좌에 입금
		CardVO clientCardVO = new CardVO();
		clientCardVO.setBankName(trHistoryVO.getPaymentCardBankName());
		clientCardVO.setName(trHistoryVO.getPaymentCardName());
		clientCardVO.setCardNum(trHistoryVO.getPaymentCardNum());
		cardMapper.deposit(clientCardVO, price);
		
		sellerMapper.withdraw(sellerId,price);
		return "success";
	}

	@Override
	public int getValidateCheck(int pno, int orderNum, String clientId) {
		return trHistoryMapper.getValidateCheck(pno, orderNum, clientId);
	}

}
