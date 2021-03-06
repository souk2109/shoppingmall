package org.shoppingmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.shoppingmall.domain.TrHistoryVO;

public interface TrHistoryMapper {
	public int insertTransactionHistory(TrHistoryVO trHistoryVO);
	// 주문번호를 통한 거래내역
	public TrHistoryVO getTransactionHistoryByNum(int orderNum);
	
	// 특정 소비자의 거래내역
	public List<TrHistoryVO> getClientTransactionHistorys(String clientId);
	
	// 판매자의 거래내역
	public List<TrHistoryVO> getSellerTransactionHistorys(String sellerId);
	
	// 주문번호를 통한 거래내역 조회
	public TrHistoryVO getTransactionHistory(int orderNum);
	
	public int updateStatusToShipping(@Param("orderNum")int orderNum, @Param("prdStatus")String prdStatus);
	public int updateStatusToArrive(@Param("orderNum")int orderNum, @Param("prdStatus")String prdStatus);
	public int updateStatusToCancel(@Param("orderNum")int orderNum, @Param("prdStatus")String prdStatus);
	
	// 상품번호, 주문번호, id를 통해 거래내역이 있는지 확인
	public int getValidateCheck(@Param("pno")int pno, @Param("orderNum")int orderNum, @Param("clientId")String clientId);
	
	public int updateReviewStatusByOrderNum(int orderNum);
}
