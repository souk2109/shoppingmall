<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<link href="https://fonts.googleapis.com/css2?family=Prompt:wght@600&display=swap" rel="stylesheet">

<sec:authentication property="principal" var="loginUser"/>
<div class="container" align="center">
	<div class="row">
		<div class="col-md-6" style="margin: 0 auto;">
			<div class="panel-default">
				<div align="center">
					<font class="panel-title" size="20px" face="Prompt">비밀번호 변경하기</font>
				</div>
				
				<div class="panel-body" style="margin-top: 20px;">
					<form id="modifyForm" action="/shoppingmall/member/doModifyPwd" method="post">
						<input type="hidden" name="id" value="${loginUser.username }">
						<div class="form-group" align="left">
							<div class="col-sm-12">현재 비밀번호</div>
							<div class="col-sm-12">
								<input id="oldPwd" name="oldPwd" type="text" class="form-control" placeholder="현재 사용중인 비밀번호">
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">새 비밀번호</div>
							<div class="col-sm-12">
								<input id="pwd" name="pwd" type="password" class="form-control" placeholder="새 비밀번호" autocomplete="off">
								<div id="pwdComment" style="color: red"></div>
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">새 비밀번호 확인</div>
							<div class="col-sm-12">
								<input id="rePwd" name="rePwd" type="password" class="form-control" placeholder="새 비밀번호" autocomplete="off">
								<div id="rePwdComment" style="color: red"></div>
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-12">
								<input id="modifyBtn" type="submit"  value="변경하기" style="border:hidden; margin-top: 20px;font-size: 18px; height: 54px; width: 100%; background-color: green; color: white;">
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="/shoppingmall/resources/js/member.js"></script>
<script type="text/javascript">
let pwdCheck = 0;
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

$("#modifyBtn").on("click", function(e) {
	e.preventDefault();
	if(pwdCheck === 1){
		$("#modifyForm").submit();
	}else{
		alert('비밀번호를 정확히 입력해주세요');
	}
})
</script>
<%@include file="../includes/footer.jsp" %>