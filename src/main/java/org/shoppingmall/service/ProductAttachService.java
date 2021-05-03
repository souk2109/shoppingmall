package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.ProductAttachVO;

public interface ProductAttachService {

	List<ProductAttachVO> getProductImages(int pno);

}
