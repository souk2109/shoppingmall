package org.shoppingmall.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;

@Data
public class Criteria {
	private int pageNum;
	private int amount;
	
	private String category;
	private String keyword;
	
	public Criteria() {
		this(1,12);
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

	public String[] getCategoryArr() {
		return category == null? new String[]{}: category.split("");
	}
	
	// 간단하게 uri 생성
	public String getListLink() {
		UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.getPageNum())
				.queryParam("amount", this.getAmount())
				.queryParam("category", this.getCategory())
				.queryParam("keyword", this.getKeyword());

		return uriComponentsBuilder.toUriString();
	}
}
