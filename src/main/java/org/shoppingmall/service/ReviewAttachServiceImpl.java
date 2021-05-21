package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.ReviewAttachVO;
import org.shoppingmall.mapper.ReviewAttachMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReviewAttachServiceImpl implements ReviewAttachService{
	@Autowired
	private ReviewAttachMapper reviewAttachMapper;
	
	@Override
	public List<ReviewAttachVO> getReviewImages(int rno) {
		return reviewAttachMapper.getReviewAttachVO(rno);
	}

}
