package org.shoppingmall.service;

import org.shoppingmall.domain.AuthVO;
import org.shoppingmall.domain.UserVO;
import org.shoppingmall.mapper.AuthMapper;
import org.shoppingmall.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserServiceImpl implements UserService{
	@Autowired
	private AuthMapper authMapper;
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private PasswordEncoder encoder;
	
	// userMapper 또는 authMapper에서의 메소드가 실패할 경우 RollBack한다.
	@Transactional
	@Override
	public int registerUser(UserVO userVO, String auth) {
		userVO.setPwd(encodePassword(userVO.getPwd()));
		userMapper.insertUser(userVO);
		AuthVO authVO = new AuthVO();
		authVO.setId(userVO.getId());
		authVO.setAuth(auth);
		return authMapper.insertAuth(authVO);
	}

	private String encodePassword(String rawPwd) {
		return encoder.encode(rawPwd);
	}

	@Override
	public String getIdValidate(String id) {
		int _result = userMapper.getValidateById(id);
		String result = _result == 0 ? "success" : "fail";
		return result;
	}
	
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

	@Override
	public UserVO getUserById(String id) {
		return userMapper.getUserById(id);
	}
}
