package org.shoppingmall.mapper;

import org.apache.ibatis.annotations.Param;
import org.shoppingmall.domain.SellerVO;

public interface SellerMapper {
	public int insertSellerVO(SellerVO sellerVO);

	public SellerVO getSellerVO(String id);

	public int deposit(@Param("id")String id, @Param("money")int money);

	public int withdraw(@Param("sellerId")String sellerId, @Param("price")int price);
}
