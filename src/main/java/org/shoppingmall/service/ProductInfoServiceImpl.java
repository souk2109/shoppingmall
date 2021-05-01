package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.ProductInfoVO;
import org.shoppingmall.mapper.ProductAttachMapper;
import org.shoppingmall.mapper.ProductInfoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ProductInfoServiceImpl implements ProductInfoService{
	@Autowired 
	private ProductInfoMapper productInfoMapper;
	@Autowired
	private ProductAttachMapper productAttachMapper; 
	
	@Transactional
	@Override
	public void insertProductInfoVO(ProductInfoVO productInfoVO) {
		productInfoMapper.insertProductInfo(productInfoVO);
		if(productInfoVO.getAttachList() == null || productInfoVO.getAttachList().size() <= 0) {
			return;
		}
		int pno = productInfoMapper.getLastPnoByUserid(productInfoVO.getSellerId());
		productInfoVO.getAttachList().forEach(attach -> {
			attach.setPno(pno);
			productAttachMapper.insertProductAttachVO(attach);
		});
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
