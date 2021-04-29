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
						<div class="form-group" align="left">
							<div class="col-sm-12">＊상호명</div>
							<div class="col-sm-12">
								<input id="busiName" name="busiName" type="text" class="form-control">
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
							<div class="col-sm-12">＊카드 번호</div>
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
		let id = $("#id").val().trim();
		let accountNum = $("#accountNum").val().trim();
		let busiName = $("#busiName").val().trim();
		if(!busiName){
			alert('상호명을 입력해주세요.');
		}else if(!accountNum){
			alert('계좌번호를 입력해주세요.');
		}
		else{
			memberService.getRecentSellerRequest(id, function(SellerRequest) {
				if(!SellerRequest){ //  마지막으로 요청한 정보가 없는 경우 (신규 신청)
					alert('정상적으로 요청 되었습니다.');
					registerForm.submit();
					return;
				}else{ // 이미 처리중, 거절, 승인 중  한 가지의 상태를 가진 경우
					let status = SellerRequest.status;
					if(status === '처리중'){
						alert('처리 중인 상태입니다.');
						return;
					}
					else if(status === '거절'){
						alert('정상적으로 요청 되었습니다.');
						registerForm.submit();
						return;
					}else if(status === '승인'){
						alert('이미 승인된 상태입니다.');
						return;
					}
				}
			});
		}
	});
</script>
<%@include file="../includes/footer.jsp" %>