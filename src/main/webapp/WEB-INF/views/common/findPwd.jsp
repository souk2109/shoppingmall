<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="https://fonts.googleapis.com/css2?family=Prompt:wght@600&display=swap" rel="stylesheet">

<div class="container" align="center">
	<div class="row">
		<div class="col-md-6" style="margin: 0 auto;">
			<div class="panel-default">
				<div align="center">
					<font class="panel-title" size="20px" face="Prompt">비밀번호 찾기</font>
				</div>
				<div class="panel-body" style="margin-top: 20px;">
					<div class="form-group" align="left">
						<div class="col-sm-12">아이디</div>
						<div class="col-sm-12">
							<input id="idInput" class="form-control" placeholder="아이디" autocomplete="off">
						</div>
					</div>
					<div class="form-group" align="left">
						<div class="col-sm-12">이메일</div>
						<div class="col-sm-12">
							<input id="emailInput" class="form-control" placeholder="이메일" autocomplete="off">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-12">
							<input id="findPwdBtn" type="submit" value="비밀번호 찾기"
								style="border: hidden; margin-top: 20px; font-size: 18px; height: 54px; width: 100%; background-color: green; color: white;">
						</div>
					</div>
					
					<div align="center" style="font-size: 14px; margin-top: 30px; margin-bottom: 30px" class="col-sm-12">
						<span class="top-bar-menu-item"><a href="/shoppingmall/common/findId">아이디 찾기</a></span>
						<span class="top-bar-menu-item"><a href="/shoppingmall/common/login">로그인</a></span>
            			<span class="top-bar-menu-item"><a href="/shoppingmall/common/register">회원가입</a></span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="fade modal" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content" align="center" style="text-align: center;">
			<div class="modal-header">
				<span id="message"></span>
				<span id="cancelBtn" style="float: right;"><i class="fa fa-times" aria-hidden="true"></i></span>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="/shoppingmall/resources/js/common.js"></script>
<script type="text/javascript">
	$("#findPwdBtn").on("click", function() {
		let id = $("#idInput").val().trim();
		let email = $("#emailInput").val().trim();
		if(!id){
			alert('아이디를 입력해주세요');
			return;
		}
		if(!email){
			alert('이메일을 입력해주세요');
			return;
		}
		// 모달에 검색된 아이디 추가 후 보여주기
		commonService.findUser(id, email, function(result) {
			if(result === 'Found'){
				$("#message").append('<span>이메일로 새로운 비밀번호를 발송하였습니다.</span><br><span>해당 비밀번호로 로그인 후 비밀번호를 변경해주세요.</span>');
			}else{
				$("#message").text('일치하는 회원이 없습니다.');
			}
			$(".modal").modal("show");
		});
	});
	
	$("#cancelBtn").on("click", function() {
		$(".modal").modal("hide");
	});
</script>
<%@include file="../includes/footer.jsp" %>