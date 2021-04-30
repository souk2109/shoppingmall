package org.shoppingmall.service;

import java.util.List;

import org.shoppingmall.domain.SimpleCardVO;

public interface SimpleCardService {

	String regSimpleCard(SimpleCardVO simpleCardVO);

	List<SimpleCardVO> getSimpleCardVO(String id);

}
