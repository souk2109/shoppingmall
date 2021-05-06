package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.ProductAttachVO;
import org.shoppingmall.mapper.ProductAttachMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class ProductAttachServiceImpl implements ProductAttachService{
@Autowired
private ProductAttachMapper productAttachMapper;
	@Override
	public List<ProductAttachVO> getProductImages(int pno) {
		return productAttachMapper.getAttachsByPno(pno);
	}
	@Override
	public ProductAttachVO getProductMainImage(int pno) {
		return productAttachMapper.getMainAttachVO(pno);
	}

}
