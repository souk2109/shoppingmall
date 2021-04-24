<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link href="https://fonts.googleapis.com/css2?family=Prompt:wght@600&display=swap" rel="stylesheet">
<sec:authentication property="principal" var="loginUser"/>
<div class="container" align="center">
	<div class="row">
		<div class="col-md-6" style="margin: 0 auto;">
			<div class="panel-default">
				<div align="center">
					<font class="panel-title" size="20px" face="Prompt">판매자 신청</font>
				</div>
				
				<div class="panel-body" style="margin-top: 20px;">
					<form id="registerForm" action="/shoppingmall/member/doSellerApply" method="post">
						<div class="form-group" align="left">
							<div class="col-sm-12">＊이름</div>
							<div class="col-sm-12">
								<input id="name" name="name" type="text" class="form-control" readonly="readonly" value="${loginUser.name }">
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">＊판매자 아이디</div>
							<div class="col-sm-12">
								<input id="id" name="id" type="text" class="form-control" readonly="readonly" value="${loginUser.username }">
							</div>
						</div>
					
						<!--  이부분 사진으로  -->
						<div class="form-group" align="left">
							<div class="col-sm-12">＊사업자 등록증 첨부</div>
							<div class="col-sm-12">
								<input id="busiPicture" name="busiPicture" type="file" class="form-control" autocomplete="off">
							</div>
						</div>
						
						<div class="form-group" align="left">
							<div class="col-sm-12">＊계좌 번호</div>
							<div class="col-sm-12">
								<input id="accountNum" name="accountNum" type="text" class="form-control" placeholder="-없이 번호만 입력해주세요" autocomplete="off">
							</div>
						</div>
						
						<div class="form-group" align="left">
							<div class="col-sm-12">＊이메일</div>
							<div class="col-sm-12">
								<input id="email" name="email" type="email" class="form-control" readonly="readonly" value="${loginUser.email }">
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-12">
								<input id="registerBtn" type="submit"  value="신청하기" style="border:hidden; margin-top: 20px;font-size: 18px; height: 54px; width: 100%; background-color: green; color: white;">
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
	$("#registerBtn").on("click", function(e) {
		e.preventDefault();
		let id = $("#id").val();
		let result;
		memberService.getSellerRequestValidate(id, function(validateResult) {
			result = validateResult;
			if(result === "success"){
				alert('정상적으로 요청 되었습니다.');
				registerForm.submit();
			}else{
				window.location.href = '/shoppingmall/member/myPage';
				alert('이미 요청한 사용자 입니다.\n(판매자 등록 요청은 한 번만 가능합니다.)');
			}
		});
	});
</script>
<%@include file="../includes/footer.jsp" %>