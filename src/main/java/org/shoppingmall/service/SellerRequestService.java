package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.CardVO;
import org.shoppingmall.domain.SellerRequestVO;

public interface SellerRequestService {
	public String insertSellerRequest(SellerRequestVO sellerRequestVO);
	public List<SellerRequestVO> getSellerRequestList();
	public List<SellerRequestVO> getAllSellerRequests();
	public String agreeSellerRequest(String id,String busiName, CardVO cardVO);
	public String rejectSellerRequest(String id);
	public SellerRequestVO getRecentSellerRequest(String id);
	public List<SellerRequestVO> getSellerRequests(String id);
}
