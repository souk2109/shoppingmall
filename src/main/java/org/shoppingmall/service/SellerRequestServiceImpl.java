package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.AuthVO;
import org.shoppingmall.domain.CardVO;
import org.shoppingmall.domain.SellerRequestVO;
import org.shoppingmall.domain.SellerVO;
import org.shoppingmall.mapper.AuthMapper;
import org.shoppingmall.mapper.CardMapper;
import org.shoppingmall.mapper.SellerMapper;
import org.shoppingmall.mapper.SellerRequestMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class SellerRequestServiceImpl implements SellerRequestService{
	@Autowired
	private SellerRequestMapper sellerRequestMapper;
	@Autowired
	private AuthMapper authMapper;
	@Autowired
	private CardMapper cardMapper;
	@Autowired
	private SellerMapper sellerMapper;
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
	public List<SellerRequestVO> getSellerRequests(String id) {
		List<SellerRequestVO> sellerRequestVO = sellerRequestMapper.getSellerRequests(id);
		return sellerRequestVO;
	}

	@Override
	public List<SellerRequestVO> getAllSellerRequests() {
		return sellerRequestMapper.getAllSellerRequests();
	}

	// 판매자 신청 수락시
	// 1.tbl_seller_request의 successdate갱신, status를 1로 변경
	// 2. tbl_user_auth의 auth를 ROLE_SELLER 권한 부여
	// 3. 입력된 카드정보로 카드 등록 (실제 은행정보를 가져올 수 없으므로 등록시켜준다.)
	// 4. tbl_seller에 등록해준다.
	@Transactional
	@Override
	public String agreeSellerRequest(String id,String busiName, CardVO cardVO) {
		sellerRequestMapper.updateStatusAndUpdatedate(id,"승인");
		cardMapper.insertCardVO(cardVO);
		
		SellerVO sellerVO = new SellerVO();
		sellerVO.setBusiName(busiName);
		sellerVO.setIncome(0);
		sellerVO.setId(id);
		sellerVO.setName(cardVO.getName());
		sellerVO.setCardNum(cardVO.getCardNum());
		sellerMapper.insertSellerVO(sellerVO);
		
		AuthVO authVO = new AuthVO();
		authVO.setId(id);
		authVO.setAuth("ROLE_SELLER");
		authMapper.insertAuth(authVO);
		return "success";
	}

	@Override
	public String rejectSellerRequest(String id) {
		sellerRequestMapper.updateStatusAndUpdatedate(id, "거절");
		return "success";
	}

	@Override
	public SellerRequestVO getRecentSellerRequest(String id) {
		return sellerRequestMapper.getRecentSellerRequest(id);
	}

}
