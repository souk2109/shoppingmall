package org.shoppingmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.shoppingmall.domain.SellerRequestVO;

public interface SellerRequestMapper {
	public int insertSellerRequest(SellerRequestVO sellerRequestVO);
	public List<SellerRequestVO> getSellerRequestList();
	public List<SellerRequestVO> getAllSellerRequests();
	public void updateStatusAndUpdatedate(@Param("id") String id,@Param("status") String status);
	public void deleteSellerRequest(String id);
	public SellerRequestVO getRecentSellerRequest(String id);
	public List<SellerRequestVO> getSellerRequests(String id);
}
