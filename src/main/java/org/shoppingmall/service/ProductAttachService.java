package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.ProductAttachVO;

public interface ProductAttachService {

	public List<ProductAttachVO> getProductImages(int pno);
	public ProductAttachVO getProductMainImage(int pno);
}
