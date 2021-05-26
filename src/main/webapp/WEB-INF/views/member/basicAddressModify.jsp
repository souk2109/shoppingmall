<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<link href="https://fonts.googleapis.com/css2?family=Prompt:wght@600&display=swap" rel="stylesheet">

<sec:authentication property="principal" var="loginUser"/>
<div class="container" align="center" style="margin-bottom: 100px">
	<div align="left" class="row" style="margin-bottom: 30px">
		<div class="col-12 title-font">기본 배송지 수정하기</div>
	</div>
	<div class="row">
		<div class="col-md-6" style="margin: 0 auto;">
			<div class="panel-default">
				<div class="panel-body" style="margin-top: 20px;">
					<form id="modifyForm" action="/shoppingmall/member/doModifyBasicAddress" method="post">
						<div class="form-group" align="left">
							<div class="col-sm-12">기본 배송지</div>
							<div class="col-sm-12">
								<div style="margin-top: 10px;margin-bottom: 10px">
									<input type="text" id="postalCode" name="postalCode" class="form-control" placeholder="우편번호" style="width: 50%;display: inline;" readonly="readonly">
							    	<input type="button" class="form-control" onclick="startDaumPostcode()" value="우편번호 검색" style="width: 45%;display: inline;float: right;">
							    </div>
							    <input type="text" id="roadAddress" name="roadAddress" class="form-control" placeholder="도로명주소" readonly="readonly" style="margin-bottom: 10px">
							    <input type="text" id="detailAddress" name="detailAddress" class="form-control" placeholder="상세주소" autocomplete="new-password">
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-12">
								<input id="modifyBtn" type="submit"  value="변경하기" style="border:hidden; margin-top: 20px;font-size: 18px; height: 54px; width: 100%; background-color: green; color: white;">
							</div>
						</div>
						 <input type="hidden" name="id" value="${loginUser.username }">
						 <sec:csrfInput/>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="/shoppingmall/resources/js/member.js"></script>
<!-- 다음 우편번호 검색 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function startDaumPostcode() {
		new daum.Postcode({
		oncomplete: function(data) {
			document.getElementById("postalCode").value = data.zonecode;
			document.getElementById("roadAddress").value = data.roadAddress;
		}
		}).open();
	}
</script>
<script type="text/javascript">

$("#modifyBtn").on("click", function(e) {
	e.preventDefault();
	let postalCode = $("#postalCode").val();
	let detailAddress = $("#detailAddress").val();
	
	if(!postalCode || !detailAddress){
		alert('모든 항목을 입력해주세요.');
	}else{
		$("#modifyForm").submit();
	}
})
</script>
<%@include file="../includes/footer.jsp" %>