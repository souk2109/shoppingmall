package org.shoppingmall.service;

import org.shoppingmall.domain.SellerAttachVO;
import org.shoppingmall.mapper.SellerAttachMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class SellerAttachServiceImpl implements SellerAttachService{
	@Autowired
	private SellerAttachMapper sellerAttachMapper;
	@Override
	public SellerAttachVO getSellerAttachVO(int num) {
		return sellerAttachMapper.getSellerAttachVO(num);
	}

}
