package org.shoppingmall.security;

import org.shoppingmall.domain.UserVO;
import org.shoppingmall.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.extern.log4j.Log4j;
@Log4j
public class CustomUserDetailsService implements UserDetailsService {
	@Autowired
	private UserMapper userMapper;
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserVO user = userMapper.getUser(username);
		log.info("CustomUserDetailsService : "+user);
		return user == null ? null : new CustomUserDetails(user);
	}

}
