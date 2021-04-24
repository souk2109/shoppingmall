package org.shoppingmall.mapper;

import java.util.List;

import org.shoppingmall.domain.SellerRequestVO;

public interface SellerRequestMapper {
	public int insertSellerRequest(SellerRequestVO sellerRequestVO);
	public List<SellerRequestVO> getSellerRequestList();
	public int getValidateById(String id);
	public SellerRequestVO getSellerRequestVO(String id);
}
