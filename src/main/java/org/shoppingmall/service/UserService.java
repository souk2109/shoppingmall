package org.shoppingmall.service;

import org.shoppingmall.domain.UserVO;

// 로그인, 회원가입, 회원정보 변경 등을 다루는 서비스
public interface UserService {
	public int registerUser(UserVO userVO, String auth);
	
	public String getIdValidate(String id); // id 중복검사
	
	public String changePwd(String id, String oldPwd, String pwd);

	public UserVO getUserById(String id);

	public String deactivateUser(String id, String pwd);
}
