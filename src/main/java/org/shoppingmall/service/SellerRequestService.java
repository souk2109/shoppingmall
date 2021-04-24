package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.SellerRequestVO;

public interface SellerRequestService {
	public String insertSellerRequest(SellerRequestVO sellerRequestVO);
	public List<SellerRequestVO> getSellerRequestList();
	public String getSellerRequestValidate(String id);
	public SellerRequestVO getSellerRequestVO(String id);
}
