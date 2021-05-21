package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.ReviewAttachVO;
import org.shoppingmall.domain.ReviewOutputDTO;
import org.shoppingmall.domain.ReviewVO;
import org.shoppingmall.mapper.ProductInfoMapper;
import org.shoppingmall.mapper.ProductQuestionItemMapper;
import org.shoppingmall.mapper.ReviewAttachMapper;
import org.shoppingmall.mapper.ReviewMapper;
import org.shoppingmall.mapper.TrHistoryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;
@Log4j
@Service
public class ReviewServiceImpl implements ReviewService{
	@Autowired
	private ReviewMapper reviewMapper;
	
	@Autowired
	private ReviewAttachMapper reviewAttachMapper;
	
	@Autowired
	private TrHistoryMapper trHistoryMapper;
	
	@Autowired
	private ProductQuestionItemMapper productQuestionItemMapper;
	@Autowired
	private ProductInfoMapper productInfoMapper;
	
	@Transactional
	@Override
	public int addReview(ReviewVO reviewVO) {
		reviewMapper.insertReviewVO(reviewVO);
		
		// 해당 상품의 전체적인 별점 평균값과 총 리뷰 수를 갱신한다 .
		int pno = reviewVO.getPno();
		int grade = (int) reviewVO.getGrade();
		productInfoMapper.increaseReviewNumAndTotalReviewGrade(pno, grade);
		
		int rno = reviewVO.getRno();
		int orderNum = reviewVO.getOrderNum();
		
		trHistoryMapper.updateReviewStatusByOrderNum(orderNum);
		productQuestionItemMapper.increaseItemGrade(reviewVO.getFirstItem());
		productQuestionItemMapper.increaseItemGrade(reviewVO.getSecondItem());
		
		if(reviewVO.getAttachList() == null) {
			return rno;
		}
		reviewVO.getAttachList().forEach(attach->{
			ReviewAttachVO reviewAttachVO = new ReviewAttachVO();
			reviewAttachVO.setId(reviewVO.getId());
			reviewAttachVO.setRno(rno);
			reviewAttachVO.setUuid(attach.getUuid());
			reviewAttachVO.setPath(attach.getPath());
			reviewAttachVO.setFileName(attach.getFileName());
			reviewAttachMapper.insertReviewAttachVO(reviewAttachVO);
		});
		return rno;
	}

	@Override
	public List<ReviewVO> getReviewList(int pno) {
		return reviewMapper.getReviewList(pno);
	}

	@Override
	public List<ReviewOutputDTO> getReviewOutputList(int pno) {
		return reviewMapper.getReviewOutputList(pno);
	}

}
