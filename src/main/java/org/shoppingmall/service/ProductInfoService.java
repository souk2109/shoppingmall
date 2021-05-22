package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.Criteria;
import org.shoppingmall.domain.ProductInfoVO;

public interface ProductInfoService {
	public int insertProductInfoVO(ProductInfoVO productInfoVO);
	public ProductInfoVO getProductInfo(int pno);
	public List<ProductInfoVO>getProductInfoList(String loginedId);
	public void modifyProductInfoVO(ProductInfoVO productInfoVO);
	public List<ProductInfoVO> getAllProductInfoList();
	public void minusProductStock(int pno, int count);
	public int getCount(Criteria criteria);
	public List<ProductInfoVO> getProductInfoListWithPaging(Criteria criteria);
}
