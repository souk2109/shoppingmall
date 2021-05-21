package org.shoppingmall.mapper;

import java.util.List;

import org.shoppingmall.domain.ReviewAttachVO;

public interface ReviewAttachMapper {

	int insertReviewAttachVO(ReviewAttachVO reviewAttachVO);

	List<ReviewAttachVO> getReviewAttachVO(int rno);
	
}
