package org.shoppingmall.mapper;

import java.util.List;

import org.shoppingmall.domain.ReviewOutputDTO;
import org.shoppingmall.domain.ReviewVO;

public interface ReviewMapper {
	public int insertReviewVO(ReviewVO reviewVO);

	public List<ReviewVO> getReviewList(int pno);

	public List<ReviewOutputDTO> getReviewOutputList(int pno);

	public List<ReviewOutputDTO> getReviewWithHighGrade(String pno);

	public List<ReviewOutputDTO> getReviewWithRegdateDesc(String pno);

	public List<ReviewOutputDTO> getReviewWithLowGrade(String pno);

	public ReviewVO getReviewByOrderNum(int orderNum);
}
