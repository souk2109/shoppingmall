package org.shoppingmall.mapper;

import java.util.List;

import org.shoppingmall.domain.ProductAttachVO;

public interface ProductAttachMapper {
	public void insertProductAttachVO(ProductAttachVO attachVO);
	public void deleteProductAttachVO(String uuid);
	public List<ProductAttachVO> getAttachsByPno(int pno);
	public void deleteProductAttachsByPno(int pno);
	public ProductAttachVO getMainAttachVO(int pno);
}
