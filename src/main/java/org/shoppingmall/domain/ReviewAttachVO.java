package org.shoppingmall.domain;

import lombok.Data;

@Data
public class ReviewAttachVO {
	private int rno;
	private String id;
	private String uuid;
	private String path;
	private String fileName;
	private boolean fileType;
}
