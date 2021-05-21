package org.shoppingmall.domain;
import java.util.Date;

import lombok.Data;

@Data
public class ReviewOutputDTO {
	private int rno;
	private String nickname;
	private float grade;
	private String review;
	private int count;
	private String productName;
	private Date arriveTime;
	private Date regDate;
}
