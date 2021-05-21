package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.ReviewOutputDTO;
import org.shoppingmall.domain.ReviewVO;

public interface ReviewService {

	int addReview(ReviewVO reviewVO);

	List<ReviewVO> getReviewList(int pno);
	
	List<ReviewOutputDTO> getReviewOutputList(int pno);

}