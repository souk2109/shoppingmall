package org.shoppingmall.service;

import org.shoppingmall.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private PasswordEncoder encoder;
	// TODO : 비밀번호 변경 성공 또는 실패 시 메세지 줘야함
	@Transactional
	@Override
	public String changePwd(String id, String oldPwd, String pwd) {
		String encodedPassword = userMapper.getUser(id).getPwd();
		boolean result = encoder.matches(oldPwd, encodedPassword);
		if(result) {
			userMapper.updatePwd(id, encoder.encode(pwd));
			return "success";
		}else {
			return "fail";
		}
		 
	}

}
