<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link href="https://fonts.googleapis.com/css2?family=Prompt:wght@600&display=swap" rel="stylesheet">
<sec:authentication property="principal" var="loginUser"/>
<style>

</style>
<div class="container" align="center">
	<div class="row">
		<div class="col-md-6" style="margin: 0 auto;">
			<div class="panel-default">
				<div align="center">
					<font class="panel-title" size="20px" face="Prompt">간편 카드 등록</font>
				</div>
				
				<div class="panel-body" style="margin-top: 20px;">
					<form id="registerForm" action="/shoppingmall/member/doRegSimpleCard" method="post">
						<div class="form-group" align="left">
							<div class="col-sm-12">＊이름</div>
							<div class="col-sm-12">
								<input id="name" name="name" type="text" class="form-control" autocomplete="off" autofocus="autofocus">
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">＊판매자 아이디</div>
							<div class="col-sm-12">
								<input id="id" name="id" type="text" class="form-control" readonly="readonly" value="${loginUser.username }">
							</div>
						</div>
						
						<div class="form-group" align="left">
							<div class="col-sm-12">＊카드 번호</div>
							<div class="col-sm-12">
								<input id="cardNum" name="cardNum" type="text" class="form-control" placeholder="카드번호 12자리" maxlength="12" autocomplete="off" onkeypress="inNumber();">
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">＊은행명</div>
							<div class="col-sm-12">
								<select aria-label="은행" id="bankName" name="bankName" style="width: 100%">
									<option value="">은행</option>
									<option value="하나">하나</option>
									<option value="국민">국민</option>
									<option value="기업">기업</option>
									<option value="농협">농협</option>
								</select> 
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">＊유효기간</div>
							<div class="col-sm-12" style="padding-left: 15px; padding-right: 15px;margin: 0 auto;">
								<div align="center" style="height: 45px; font-family: 'Nunito Sans', sans-serif">
									<input id="validateMonth" name="validateMonth" maxlength="2" type="text"  placeholder="월" autocomplete="off" style="width: 32%" onkeypress="inNumber();">
									<input id="validateYear" name="validateYear" maxlength="4" type="text"  placeholder="년" autocomplete="off" style="width: 32%" onkeypress="inNumber();">
									<input id="cvc" name="cvc" maxlength="3" type="password"  placeholder="cvc" autocomplete="off" style="width: 32%" onkeypress="inNumber();">
								</div>
								<div>예) 12 2025 123</div>
							</div>
						</div>
						
						<div class="form-group" align="left">
							<div class="col-sm-12">＊카드 비밀번호</div>
							<div class="col-sm-12">
								<input id="pwd" maxlength="4" name="pwd" type="password" class="form-control" placeholder="숫자 4자리" autocomplete="off" onkeypress="inNumber();">
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-12">
								<input id="registerBtn" type="submit"  value="등록하기" style="border:hidden; margin-top: 20px;font-size: 18px; height: 54px; width: 100%; background-color: green; color: white;">
							</div>
						</div>
						
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="/shoppingmall/resources/js/member.js"></script>
<script>
	let regSimpleCardResult = "<c:out value='${regSimpleCardResult}'/>";
	if(regSimpleCardResult){
		if(regSimpleCardResult === 'notFoundCard'){
			alert('잘못된 카드 정보입니다');
		}else if(regSimpleCardResult === 'overlapCard'){
			alert('이미 등록한 카드입니다');
		}
	}
	
	function inNumber(){
	    if(event.keyCode<48 || event.keyCode>57){
	       event.returnValue=false;
	    }
	}
</script>
<script>
$("#registerBtn").on("click", function(e) {
	let name = $("#name").val().trim();
	let cardNum = $("#cardNum").val().trim();
	let bankName = $("#bankName").val().trim();
	let validateMonth = $("#validateMonth").val().trim();
	let validateYear = $("#validateYear").val().trim();
	let cvc = $("#cvc").val().trim();
	let pwd = $("#pwd").val().trim();
	
	
	e.preventDefault();
	if(!name || !cardNum || !bankName || !validateMonth || !validateYear || !cvc || !pwd){
		alert('모두 작성해주세요');
	}else{
		$("#registerForm").submit();
	}
});
$("#name").val().trim()
$("#registerForm")
</script>
<%@include file="../includes/footer.jsp" %>