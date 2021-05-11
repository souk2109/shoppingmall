package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.CardVO;
import org.shoppingmall.domain.SellerRequestVO;
import org.shoppingmall.domain.SellerVO;

public interface SellerRequestService {
	public String insertSellerRequest(SellerRequestVO sellerRequestVO);
	public List<SellerRequestVO> getSellerRequestList();
	public List<SellerRequestVO> getAllSellerRequests();
	public String agreeSellerRequest(SellerVO sellerVO, CardVO cardVO);
	public String rejectSellerRequest(String id);
	public SellerRequestVO getRecentSellerRequest(String id);
	public List<SellerRequestVO> getSellerRequests(String id);
}
