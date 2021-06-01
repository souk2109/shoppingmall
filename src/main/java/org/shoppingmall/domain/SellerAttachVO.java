package org.shoppingmall.domain;

import lombok.Data;

@Data
public class SellerAttachVO {
	private int num;
	private String id;
	private String uuid;
	private String path;
	private String fileName;
	private boolean fileType;
}
