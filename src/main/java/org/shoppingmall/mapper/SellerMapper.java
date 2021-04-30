package org.shoppingmall.mapper;

import org.shoppingmall.domain.SellerVO;

public interface SellerMapper {
	public int insertSellerVO(SellerVO sellerVO);

	public SellerVO getSellerVO(String id);
}
