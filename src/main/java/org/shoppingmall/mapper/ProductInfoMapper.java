package org.shoppingmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.shoppingmall.domain.ProductInfoVO;

public interface ProductInfoMapper {
	public int insertProductInfo(ProductInfoVO productInfoVO);
	public ProductInfoVO getProductInfo(int pno);
	public List<ProductInfoVO> getProductInfoList(String sellerId);
	public int updateProductInfo(ProductInfoVO productInfoVO);
	public int getLastPnoByUserid(String sellerId);
	public List<ProductInfoVO> getAllProductInfoList();
	public void minusProductStock(@Param("pno") int pno,@Param("count") int count);
}
