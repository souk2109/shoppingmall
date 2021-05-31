package org.shoppingmall.service;

import org.shoppingmall.domain.PostalDTO;
import org.shoppingmall.domain.UserVO;

// 로그인, 회원가입, 회원정보 변경 등을 다루는 서비스
public interface UserService {
	public int registerUser(UserVO userVO, String auth);
	
	public String getIdValidate(String id); // id 중복검사
	
	public String changePwd(String id, String oldPwd, String pwd);

	public UserVO getUserById(String id);

	public String deactivateUser(String id, String pwd);

	public String changeBasicAdress(String id, PostalDTO postalDTO);

	public String getId(String name, String email);

	public boolean isUser(String id, String email);
	
	// 랜덤한 새 비밀번호 만들기
	public String makeRandomPwd();
	
	//이메일발송
	public void sendEmail(String id, String email);
}