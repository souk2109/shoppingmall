package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.ReviewAttachVO;

public interface ReviewAttachService {

	List<ReviewAttachVO> getReviewImages(int rno);
}
