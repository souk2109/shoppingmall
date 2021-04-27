package org.shoppingmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.shoppingmall.domain.UserVO;

public interface UserMapper {
	public List<UserVO> getUsersList(); // 모든 사용자 정보를 가져옴
	public int insertUser(UserVO userVo); // 사용자를 등록함
	public int getValidateById(String id); // id를 가진 사용자의 수를 가져옴 (0이면 아이디 사용가능, 1이면 불가능)
	public UserVO getUser(String id); // id를 가진 사용자의 모든 정보와 권한을 가져옴
	public UserVO getUserById(String id); // id로 사용자의 모든 정보를 가져옴
	public void updatePwd(@Param("id") String id, @Param("pwd")String pwd);
	public int deleteUser(String id); // id로 사용자를 삭제
}
