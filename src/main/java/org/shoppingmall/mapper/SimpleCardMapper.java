package org.shoppingmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.shoppingmall.domain.SimpleCardVO;

public interface SimpleCardMapper {
	// 간편 계좌 정보 가져오기
	public List<SimpleCardVO> getSimpleCardVO(String id);
	// 간편 계좌 등록
	public int insertSimpleCardVO(SimpleCardVO simpleCardVO);
	public int isSimpleCardVO(@Param("id") String id, @Param("cardNum") String cardNum, @Param("bankName") String bankName, @Param("name") String name);
}
