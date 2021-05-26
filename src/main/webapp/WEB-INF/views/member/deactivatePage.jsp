<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link href="https://fonts.googleapis.com/css2?family=Prompt:wght@600&display=swap" rel="stylesheet">
<sec:authentication property="principal" var="loginUser"/>
<!-- TODO : 
	1. 비밀번호 미입력시 입력 요청 메세지 
	2. '정말 삭제하시겠습니까?' -> 확인 : form 전송, 취소: return;
	3. 비밀번호 일치 -> 삭제 후 main으로 이동(로그아웃 된 채로) '정상적으로 회원탈퇴하였습니다.' 알림
	4. 비밀번호 불일치 -> deactivatePage로 다시 이동 후 '비밀번호가 일치하지 않습니다.' 알림
 -->
<div class="container" align="center">
	<div class="row">
		<div class="col-md-8" style="margin: 0 auto;">
			<div class="panel-default">
				<div align="center">
					<font class="panel-title" size="20px" face="Prompt">회원탈퇴</font>
				</div>
				
				<div class="panel-body" style="margin-top: 20px;">
					<div class="col-sm-12" style="border: 1px solid;font-size: 15px; margin-bottom: 20px">
						<div align="left" style="margin-top: 10px">
							<strong>탈퇴 후 회원정보가 모두 삭제됩니다.</strong>
							<div>메일주소, 계좌번호, 프로필 사진 등 회원정보가 모두 삭제되며, 삭제된 데이터는 복구되지 않습니다.</div><br>
							<strong>탈퇴 후에도 작성된 리뷰는 그대로 남아 있습니다.</strong>
							<div> 각 상품에 등록한 리뷰 및 댓글은 탈퇴 후에도 남아있습니다.
							 	삭제를 원하시는 리뷰 및 댓글은 탈퇴 전 반드시 삭제하시기 바랍니다.
							</div>
							<div>(탈퇴 후에는 임의 삭제 요청을 받지 않습니다.)</div><br>
						</div><br>
						<div align="center" style="border-top: 1px solid;">
							<div style="color: red;">탈퇴 후 안내사항을 숙지하지 못해 발생할 수 있는 불이익은 책임지지 않습니다.</div><br>
							<input type="checkbox" id="deactivateAgree">
							<label><strong> 안내사항을 모두 동의하며, 이의제기를 하지않습니다.</strong></label>
						</div>
					</div>
					 
					<form id="deactivateForm" action="/shoppingmall/member/doDeactivate" method="post">
						<input id="id" name="id" type="hidden" value="${loginUser.username }">

						<div class="form-group" align="left">
							<div class="col-sm-12">비밀번호</div>
							<div class="col-sm-12">
								<input id="pwd" name="pwd" type="password" class="form-control" placeholder="비밀번호" autocomplete="off">
							</div>
						</div> 
						<div class="form-group" align="left">
							<div class="col-sm-12">비밀번호 확인</div>
							<div class="col-sm-12">
								<input id="rePwd" name="rePwd" type="password" class="form-control" placeholder="비밀번호 확인" autocomplete="off">
							</div>
						</div> 
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-12">
								<input id="deactivateBtn" type="submit"  value="탈퇴하기" style="border:hidden; margin-top: 20px;font-size: 18px; height: 54px; width: 100%; background-color: #00CCFF; color: white;">
							</div>
						</div>
						<sec:csrfInput/>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<div align="center" style="font-size: 14px; margin-top: 30px; margin-bottom: 30px" class="col-sm-12">
	<span class="top-bar-menu-item"><a href="/shoppingmall/common/main">메인 페이지</a></span>
</div>
<script type="text/javascript" src="/shoppingmall/resources/js/member.js"></script>

<script>
	let deactivateResult = "<c:out value='${deactivateResult}'/>";
	if (deactivateResult === "fail") {
		alert('비밀번호가 틀려 회원탈퇴에 실패하였습니다.');
	}
</script>

<script>
	$("#deactivateBtn").on("click", function(e) {
		e.preventDefault();
		let pwd = $("#pwd").val();
		let rePwd = $("#rePwd").val();
		let deactivateAgree = $("#deactivateAgree").is(":checked");
		
		if(!deactivateAgree){
			alert('안내사항 동의에 체크해주세요');
		}
		else if(!$("#pwd").val()){
			alert('비밀번호를 입력해주세요');
		}
		else if(pwd !== rePwd){
			alert('입력된 두 비밀번호가 일치하지 않습니다');
		}
		else{
			let deactivateCkeck = confirm('정말 삭제하시겠습니까?');
			if(deactivateCkeck){
				$("#deactivateForm").submit();
			}else{
				return;
			}
		}
	});
</script>

<%@include file="../includes/footer.jsp" %>