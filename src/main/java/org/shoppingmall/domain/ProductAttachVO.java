package org.shoppingmall.domain;
import lombok.Data;

@Data
public class ProductAttachVO {
	private String id;
	private String uuid;
	private String path;
	private String fileName;
	private boolean fileType;
	private int pno;
	private boolean main; // 대표이미지 여부
}
