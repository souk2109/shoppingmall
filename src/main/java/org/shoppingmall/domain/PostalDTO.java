package org.shoppingmall.domain;

import lombok.Data;

@Data
public class PostalDTO {
	private String postalCode;
	private String roadAddress;
	private String detailAddress;
}
