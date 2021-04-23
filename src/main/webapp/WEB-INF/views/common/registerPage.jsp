<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link href="https://fonts.googleapis.com/css2?family=Prompt:wght@600&display=swap" rel="stylesheet">
<div class="container" align="center">
	<div class="row">
		<div class="col-md-6" style="margin: 0 auto;">
			<div class="panel-default">
				<div align="center">
					<font class="panel-title" size="20px" face="Prompt">회원가입</font>
				</div>
				
				<div class="panel-body" style="margin-top: 20px;">
					<form id="registerForm" action="/shoppingmall/common/doRegister" method="post">
						<div class="form-group" align="left">
							<div class="col-sm-12">＊아이디</div>
							<div class="col-sm-12">
								<input id="id" name="id" type="text" class="form-control" placeholder="아이디" autofocus autocomplete="off">
								<button id="reduplicationCheck" class="btn" style="color: green; font-size: 13px">중복체크</button>
							</div>
							<div class="col-sm-12" id="idComment"></div>
						</div>

						<div class="form-group" align="left">
							<div class="col-sm-12">＊비밀번호</div>
							<div class="col-sm-12">
								<input id="pwd" name="pwd" type="password" class="form-control" placeholder="비밀번호" autocomplete="off">
								<div id="pwdComment" style="color: red"></div>
							</div>
						</div> 
						
						<div class="form-group" align="left">
							<div class="col-sm-12">＊비밀번호 재입력</div>
							<div class="col-sm-12">
								<input id="rePwd" type="password" class="form-control" placeholder="비밀번호" autocomplete="off">
								<div id="rePwdComment" style="color: red"></div>
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">＊이름</div>
							<div class="col-sm-12">
								<input id="name" name="name" type="text" class="form-control" placeholder="이름" autocomplete="new-password">
								<div id="nameComment"></div>
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">＊닉네임</div>
							<div class="col-sm-12">
								<input id="nickname" name="nickname" type="text" class="form-control" placeholder="닉네임" autocomplete="off">
								<div id="nicknameComment"></div>
							</div>
						</div>
						
						<div class="form-group" align="left">
							<div class="col-sm-12">＊생년월일</div>
							<input id="birthday" type="hidden" name="birthday">
							<div class="col-sm-12">
								<div class="col-sm-3">
									<input id="year" type="text" placeholder="년" maxlength="4" autocomplete="off">
								</div>
								
								<div class="col-sm-4">
									<span>
										<select aria-label="월" id="month">
											<option value="">월</option>
											<option value="01">1</option>
											<option value="02">2</option>
											<option value="03">3</option>
											<option value="04">4</option>
											<option value="05">5</option>
											<option value="06">6</option>
											<option value="07">7</option>
											<option value="08">8</option>
											<option value="09">9</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
										</select>
									</span> 
								</div>
								
								<div class="col-sm-3 box">
									<input id="date" type="text" placeholder="일" aria-label="일" maxlength="2" autocomplete="off">
								</div>
								<div id="birthdayComment" class="col-sm-12"></div>
							</div>
						</div>
						
						<div class="form-group" align="left">
							<div class="col-sm-12">＊성별</div>
							<div class="col-sm-12">
								<div class="radio custom-control">
									<label><input name="gender" type="radio" checked value="man">남성</label>
								</div>
								<div class="radio custom-control">
									<label><input name="gender" type="radio" value="woman">여성</label>
								</div>
							</div>
						</div>
						
						<div class="form-group" align="left">
							<div class="col-sm-12">＊이메일</div>
							<div class="col-sm-12">
								<input id="email" name="email" type="email" class="form-control" placeholder="이메일" autocomplete="off">
								<div id="emailComment"></div>
							</div>
						</div>
						
						<div class="form-group" align="left">
							<div class="col-sm-12">우편번호</div>
							<div class="col-sm-12">
								<input id="postalCode" name="postalCode" type="text" class="form-control" placeholder="우편번호" autocomplete="new-password">
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-12">
								<input id="registerBtn" type="submit"  value="회원가입" style="border:hidden; margin-top: 20px;font-size: 18px; height: 54px; width: 100%; background-color: green; color: white;">
							</div>
						</div>
						
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="/shoppingmall/resources/js/common.js"></script>
<script type="text/javascript">
	let submitCheck = 0;

	let pwdCheck = 0; // ok
	let idCheck = 0; 
	let nameCheck = 0; // ok
	let nicknameCheck = 0; // ok
	let birthdayCheck = 0; // ok
	let emailCheck = 0; // ok
	
	// 유효한 생년월일인지 체크
	function birthdayValidate() {
		// 생년월일은 현재시간으로 100년전 부터 10년전에 태어난 사람만 허용하기 위해 변수로 선언
		let now = new Date();
		let hundredYearsAgoTime = now.getTime() - (365 * 24 * 60 * 60 * 1000 * 100);
		let minBirthdayDate = new Date(hundredYearsAgoTime);
		
		let tenYearsAgoTime = now.getTime() - (365 * 24 * 60 * 60 * 1000 * 10);
		let maxBirthdayDate = new Date(tenYearsAgoTime);
		
		let yearVal = $("#year").val().trim();
		let monthVal = $("#month").val();
		let dateVal = $("#date").val().trim();
		
		let birthdayInput = new Date(yearVal, monthVal, dateVal);

		if(birthdayInput > minBirthdayDate && birthdayInput < maxBirthdayDate && dateVal < 32 && dateVal > 0){
			$("#birthday").val(yearVal + "-" + monthVal +"-" + dateVal);
			return true;
		}else{
			return false;
		}
	}
	
	$("#registerBtn").on("click", function(e) {
		e.preventDefault();
		
		let idVal = $("#id").val().trim();
		if(!idVal){
			$("#idComment").attr("style","color : red; font-size:13px;");
			$("#idComment").html("아이디를 입력해주세요");
		}
		
		let pwdVal = $("#pwd").val().trim();
		if(!pwdVal){
			$("#rePwdComment").attr("style","color : red; font-size:13px;");
			$("#rePwdComment").html("비밀번호를 입력해주세요");
		}
		
		let nameVal = $("#name").val().trim();
		if(!nameVal){
			$("#nameComment").attr("style","color : red; font-size:13px;");
			$("#nameComment").html("이름을 입력해주세요");
			nameCheck = 0;
		}else{
			nameCheck = 1;
		}
		
		let nicknameVal = $("#nickname").val().trim();
		if(!nicknameVal){
			$("#nicknameComment").attr("style","color : red; font-size:13px;");
			$("#nicknameComment").html("닉네임을 입력해주세요");
			nicknameCheck = 0;
		}else{
			nicknameCheck = 1;
		}
		
		if(birthdayValidate()){
			birthdayCheck = 1;
			$("#birthdayComment").html("");
		}else{
			birthdayCheck = 0;
			$("#birthdayComment").attr("style","color : red; font-size:13px;");
	    	$("#birthdayComment").html("정확한 생년월일을 입력해주세요");
		}
		
		let emailVal = $("#email").val().trim();
		if(!emailVal){
			$("#emailComment").attr("style","color : red; font-size:13px;");
			$("#emailComment").html("이메일을 입력해주세요");
			emailCheck = 0;
		}else{
			emailCheck = 1;
		}
		
		submitCheck = pwdCheck * idCheck * nameCheck * nicknameCheck * birthdayCheck * emailCheck;
		if(submitCheck === 1){
			registerForm.submit();
		}
		else{
			console.log("pwdCheck : "+pwdCheck + ", idCheck : "+idCheck);
			console.log("nameCheck : "+nameCheck + ", nicknameCheck : "+nicknameCheck);
			console.log("birthdayCheck : "+birthdayCheck + ", emailCheck : "+emailCheck);
			console.log("---------------");
			alert('모든 항목들을 작성해주세요');
		}
	});
	
	// 중복체크 
	// db로 부터 ajax통신으로 아이디 중복체크 결과를 받아온다.
	// 성공시 idCheck를 1로 변경
	$("#reduplicationCheck").on("click", function(e) {
		e.preventDefault();
		// 이부분 if else 지우고 ajax success, fail로 판단
		let idVal = $("#id").val().trim();
		commonService.getIdValidate(idVal, function(result) {
			if(result === "success"){
				$("#idComment").attr("style","color : blue; font-size:13px;");
		    	$("#idComment").html("사용가능한 id입니다");
		    	idCheck = 1;
			}else{
				$("#idComment").attr("style","color : red; font-size:13px;");
		   		$("#idComment").html("이미 사용중인 id입니다");
			}
		});
		
	});
	
	// id를 입력 및 중복체크 여부 확인
	$("#id").on("change keyup paste input", function() {
		idCheck = 0;
		let idVal = $("#id").val().trim();
		if(!idVal){
			$("#idComment").attr("style","color : red; font-size:13px;");
	    	$("#idComment").html("id를 입력해주세요");
	    }else{
	    	$("#idComment").attr("style","color : red; font-size:13px;");
	    	$("#idComment").html("중복체크를 해주세요");
	    }
	});
	
	// 패스워드 일치 여부
	$("#rePwd").on("change keyup paste input", function() {
		let pwdVal = $("#pwd").val().trim();
		let rePwdVal = $(this).val().trim();
	    if(rePwdVal === pwdVal) {
	    	$("#rePwdComment").attr("style","color : blue; font-size:13px;");
	    	$("#rePwdComment").html("일치");
	    	pwdCheck = 1;
	    }else{
	    	$("#rePwdComment").attr("style","color : red; font-size:13px;");
	    	$("#rePwdComment").html("비밀번호 불일치");
	    	pwdCheck = 0;
	    }
	    if(rePwdVal.length === 0 && pwdVal.length > 0){
	    	$("#rePwdComment").attr("style","color : red; font-size:13px;");
	    	$("#rePwdComment").html("비밀번호를 재입력해주세요");
	    }else if(rePwdVal.length === 0 && pwdVal.length === 0){
	    	$("#rePwdComment").attr("style","color : red; font-size:13px;");
	    	$("#rePwdComment").html("비밀번호를 입력해주세요");
	    }
	});
	
	$("#pwd").on("change keyup paste input", function() {
		let pwdVal = $(this).val().trim();
	    let rePwdVal = $("#rePwd").val().trim();
	    $("#pwdComment").html("");
	    if(rePwdVal === pwdVal) {
	    	$("#rePwdComment").attr("style","color : blue; font-size:13px;");
	    	$("#rePwdComment").html("일치");
	    	pwdCheck = 1;
	    }else{
	    	$("#rePwdComment").attr("style","color : red; font-size:13px;");
	    	$("#rePwdComment").html("비밀번호 불일치");
	    	pwdCheck = 0;
	    }
	    if(pwdVal.length === 0){
	    	$("#rePwdComment").attr("style","color : red; font-size:13px;");
	    	$("#rePwdComment").html("비밀번호를 입력해주세요");
	    }
	});
	
	// 이름을 입력하지 않을 경우 comment 메세지
	$("#name").on("change keyup paste input", function() {
		let nameVal = $(this).val().trim();
		if(!nameVal){
			$("#nameComment").attr("style","color : red; font-size:13px;");
	    	$("#nameComment").html("이름을 입력해주세요");
	    }else{
	    	$("#nameComment").html("");
	    }
	});
	
	// 닉네임을 입력하지 않을 경우 comment 메세지
	$("#nickname").on("change keyup paste input", function() {
		let nicknameVal = $(this).val().trim();
		if(!nicknameVal){
			$("#nicknameComment").attr("style","color : red; font-size:13px;");
	    	$("#nicknameComment").html("닉네임을 입력해주세요");
	    }else{
	    	$("#nicknameComment").html("");
	    }
	});
	
	// 이메일을 입력하지 않을 경우 comment 메세지
	$("#email").on("change keyup paste input", function() {
		let emailVal = $(this).val().trim();
		if(!emailVal){
			$("#emailComment").attr("style","color : red; font-size:13px;");
	    	$("#emailComment").html("이메일을 입력해주세요");
	    }else{
	    	$("#emailComment").html("");
	    }
	});
	
</script>


<%@include file="../includes/footer.jsp" %>