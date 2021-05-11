package org.shoppingmall.service;

import org.shoppingmall.domain.SellerVO;
import org.shoppingmall.mapper.SellerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SellerServiceImpl implements SellerService {
	@Autowired
	private SellerMapper sellerMapper;

	@Override
	public SellerVO getSellerVO(String id) {
		return sellerMapper.getSellerVO(id);
	}

	@Override
	public int deposit(String id, int money) {
		return sellerMapper.deposit(id, money);
	}
	

}
