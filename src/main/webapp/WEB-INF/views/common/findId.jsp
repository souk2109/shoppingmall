<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="https://fonts.googleapis.com/css2?family=Prompt:wght@600&display=swap" rel="stylesheet">

<div class="container" align="center">
	<div class="row">
		<div class="col-md-6" style="margin: 0 auto;">
			<div class="panel-default">
				<div align="center">
					<font class="panel-title" size="20px" face="Prompt">아이디 찾기</font>
				</div>
				<div class="panel-body" style="margin-top: 20px;">
					<div class="form-group" align="left">
						<div class="col-sm-12">이름</div>
						<div class="col-sm-12">
							<input id="nameInput" class="form-control" placeholder="이름" autocomplete="off">
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
							<input id="findIdBtn" type="submit" value="아이디 찾기"
								style="border: hidden; margin-top: 20px; font-size: 18px; height: 54px; width: 100%; background-color: green; color: white;">
						</div>
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
				<span>아이디</span>
				<span id="cancelBtn" style="float: right;"><i class="fa fa-times" aria-hidden="true"></i></span>
			</div>
			<div class="modal-body">
				<span id="findedId"></span>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="/shoppingmall/resources/js/common.js"></script>
<script type="text/javascript">
	$("#findIdBtn").on("click", function() {
		let name = $("#nameInput").val().trim();
		let email = $("#emailInput").val().trim();
		if(!nameInput){
			alert('이름을 입력해주세요');
			return;
		}
		if(!emailInput){
			alert('이메일을 입력해주세요');
			return;
		}
		// 모달에 검색된 아이디 추가 후 보여주기
		commonService.findId(name, email, function(result) {
			console.log("result : "+result);
		});
		
		//$(".modal").modal("show");
	});
	$("#cancelBtn").on("click", function() {
		$(".modal").modal("hide");
	});
</script>
<%@include file="../includes/footer.jsp" %>