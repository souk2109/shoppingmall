package org.shoppingmall.service;

import java.util.Objects;

import org.apache.commons.mail.HtmlEmail;
import org.shoppingmall.domain.AuthVO;
import org.shoppingmall.domain.PostalDTO;
import org.shoppingmall.domain.UserVO;
import org.shoppingmall.mapper.AuthMapper;
import org.shoppingmall.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;
@Log4j
@Service
public class UserServiceImpl implements UserService{
	@Autowired
	private AuthMapper authMapper;
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private PasswordEncoder encoder;
	
	// 이메일 보내는 사람의 gmail의 아이디와 비밀번호는 개인정보를 보호하기위해 config.properties에 설정하였다. 
	@Value("${gmail.id}")
	private String senderEmail;
	
	@Value("${gmail.password}")
	private String senderEmailPwd;
	
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
		boolean result =  checkPwdIsEqual(id, oldPwd);
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

	// TODO : 나중에 첨부파일까지 삭제하기 위해서 추가해줘야함.
	@Override
	public String deactivateUser(String id, String pwd) {
		if(checkPwdIsEqual(id, pwd)) {
			userMapper.deleteUser(id);
			return "success";
		}
		else {
			return "fail";
		}
	}
	
	// 입력한 비밀번호와 db이 비밀번호와 비교하는 메소드
	private boolean checkPwdIsEqual(String id, String inputPwd) {
		String encodedPassword = userMapper.getUser(id).getPwd();
		boolean result = encoder.matches(inputPwd, encodedPassword);
		return result;
	}

	@Override
	public String changeBasicAdress(String id, PostalDTO postalDTO) {
		int result =  userMapper.updateBasicAdress(id, postalDTO);
		if(result == 1) {
			return "success";
		}else {
			return "fail";
		}
	}

	@Override
	public String getId(String name, String email) {
		return userMapper.getId(name, email);
	}

	@Override
	public boolean isUser(String id, String email) {
		UserVO user = userMapper.getUserByIdAndEmail(id, email);
		if(Objects.isNull(user)) {
			return false;
		}else {
			return true;
		}
	}

	// 랜덤한 비밀번호 생성 후 암호화
	@Override
	public String makeRandomPwd() {
		String randomPwd = "";
		for (int i = 0; i < 10; i++) {
			randomPwd += (char) ((Math.random() * 26) + 97);
		}
		log.info("암호화 전 비밀번호 : "+randomPwd);
		return randomPwd;
	}

	@SuppressWarnings("deprecation")
	@Override
	public void sendEmail(String id, String email) {
		String randomPwd = makeRandomPwd();
		log.info("변경된 비밀번호 : "+randomPwd);
		String encodedRandomPwd = encodePassword(randomPwd);
		userMapper.updatePwd(id, encodedRandomPwd);
		String charSet = "utf-8";
		String hostSMTP = "smtp.gmail.com"; //네이버 이용시 smtp.naver.com
		String hostSMTPid = senderEmail;
		String hostSMTPpwd = senderEmailPwd;

		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "sender@gmail.com";
		String fromName = "쇼핑몰 사이트";
		String subject = "비밀번호 임시 비밀번호 발급 안내";
		String msg = "";
		subject = "쇼핑몰 임시 비밀번호 입니다.";
		msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
		msg += "<h3 style='color: blue;'>";
		msg += id + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
		msg += "<p>임시 비밀번호 : ";
		msg += randomPwd + "</p></div>";

		// 받는 사람 E-Mail 주소
		String mail = email;
		try {
			HtmlEmail htmlEmail = new HtmlEmail();
			htmlEmail.setDebug(true);
			htmlEmail.setCharset(charSet);
			htmlEmail.setSSL(true);
			htmlEmail.setHostName(hostSMTP);
			htmlEmail.setSmtpPort(465); //네이버 이용시 587

			htmlEmail.setAuthentication(hostSMTPid, hostSMTPpwd);
			htmlEmail.setTLS(true);
			htmlEmail.addTo(mail, charSet);
			htmlEmail.setFrom(fromEmail, fromName, charSet);
			htmlEmail.setSubject(subject);
			htmlEmail.setHtmlMsg(msg);
			htmlEmail.send();
		} catch (Exception e) {
			System.out.println("메일발송 실패 : " + e);
		}
	}
}
