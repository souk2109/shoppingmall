package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.SimpleCardVO;
import org.shoppingmall.mapper.CardMapper;
import org.shoppingmall.mapper.SimpleCardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SimpleCardServiceImpl implements SimpleCardService {
	@Autowired
	private SimpleCardMapper simpleCardMapper;
	@Autowired
	private CardMapper cardMapper;
	
	@Override
	public String regSimpleCard(SimpleCardVO simpleCardVO) {
		// 유효한 카드인지 확인
		if(cardMapper.isCardVO(simpleCardVO) == 1) {
			// 이미 등록한 카드인지 확인
			// 이미 등록한 카드이면 (등록 불가능)
			if(simpleCardMapper.isSimpleCardVO(simpleCardVO.getId(), simpleCardVO.getCardNum()) == 1) {
				return "overlapCard";
			}
			// 이미 등록한 카드가 아니면 (등록가능)
			else {
				simpleCardMapper.insertSimpleCardVO(simpleCardVO);
				return "success";
			}
		}
		// 유효한 카드가 아니면
		else {
			return "notFoundCard";
		}
		 
	}

	@Override
	public List<SimpleCardVO> getSimpleCardVO(String id) {
		return simpleCardMapper.getSimpleCardVO(id);
	}

}
