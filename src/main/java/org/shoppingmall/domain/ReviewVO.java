package org.shoppingmall.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;
@Data
public class ReviewVO {
	private int rno;
	private int pno;
	private int orderNum;
	private String id;
	private float grade;
	private String review;
	private int firstItem;
	private int secondItem;
	private Date regDate;
	private Date updateDate;
	private List<ReviewAttachVO> attachList;
}
