package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.ProductInfoVO;

public interface ProductInfoService {
	public void insertProductInfoVO(ProductInfoVO productInfoVO);
	public ProductInfoVO getProductInfo(int pno);
	public List<ProductInfoVO>getProductInfoList(String loginedId);
	public void modifyProductInfoVO(ProductInfoVO productInfoVO);
}
