package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.SellerRequestVO;
import org.shoppingmall.mapper.SellerRequestMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SellerRequestServiceImpl implements SellerRequestService{
	@Autowired
	private SellerRequestMapper sellerRequestMapper;
	@Override
	public String insertSellerRequest(SellerRequestVO sellerRequestVO) {
		int result = sellerRequestMapper.insertSellerRequest(sellerRequestVO);
		return result == 1 ? "result" : "fail";
	}

	@Override
	public List<SellerRequestVO> getSellerRequestList() {
		return sellerRequestMapper.getSellerRequestList();
	}

	@Override
	public String getSellerRequestValidate(String id) {
		int _result = sellerRequestMapper.getValidateById(id);
		String result = _result == 0 ? "success" : "fail";
		return result;
	}

	@Override
	public SellerRequestVO getSellerRequestVO(String id) {
		SellerRequestVO sellerRequestVO = sellerRequestMapper.getSellerRequestVO(id);
		return sellerRequestVO;
	}

}
