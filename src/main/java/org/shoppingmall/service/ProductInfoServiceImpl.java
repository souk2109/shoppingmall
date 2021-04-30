package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.ProductInfoVO;
import org.shoppingmall.mapper.ProductInfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProductInfoServiceImpl implements ProductInfoService{
	@Autowired 
	private ProductInfoMapper productInfoMapper;
	
	@Override
	public int insertProductInfoVO(ProductInfoVO productInfoVO) {
		return productInfoMapper.insertProductInfo(productInfoVO);
	}

	@Override
	public List<ProductInfoVO> getProductInfoList(String loginedId) {
		return productInfoMapper.getProductInfoList(loginedId);
	}

	@Override
	public ProductInfoVO getProductInfo(int pno) {
		return productInfoMapper.getProductInfo(pno);
	}

	@Override
	public int modifyProductInfoVO(ProductInfoVO productInfoVO) {
		return productInfoMapper.updateProductInfo(productInfoVO);
	}

}
