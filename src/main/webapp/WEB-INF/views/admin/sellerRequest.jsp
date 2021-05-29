<%@include file="../includes/header.jsp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<div align="center" class="panel-title" style="margin-top: 30px;margin-bottom: 100px">
	<font size="6px" face="Prompt">판매 신청자 상세 정보</font>
	<table class="table" style="width: 60%; text-align: center; margin-top: 20px" >
		<tr>
			<th>항목</th>
			<th>개인정보</th>
		</tr>
		<tr>
			<td>아이디</td>
			<td>${user.id}</td>
		</tr>
		<tr>
			<td>이름</td>
			<td>${user.name}</td>
		</tr>
		
		<tr>
			<td>생년월일</td>
			<td>${user.birthday}</td>
		</tr>
		<tr>
			<td>성별</td>
			<td>
				<c:choose>
					<c:when test="${user.gender eq 'man'}">남성
					</c:when>
					<c:otherwise>
						여성
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>${user.email}</td>
		</tr>
		<tr>
			<td>회원가입 날짜</td>
			<td> 
				<fmt:formatDate value="${user.regDate}" pattern="yyyy년 MM월 dd일"/>
			</td>
		</tr>
		<tr>
			<td>은행</td>
			<td> 
				${sellerRequest.bankName}
			</td>
		</tr>
		<tr>
			<td>카드 번호</td>
			<td> 
				${sellerRequest.cardNum}
			</td>
		</tr>
		<tr>
			<td>신청일</td>
			<td> 
				<fmt:formatDate value="${sellerRequest.regdate}" pattern="yyyy년 MM월 dd일 HH:mm:ss"/>
			</td>
		</tr>
		<tr>
			<td>사업자 등록증</td>
			<td> 
				이부분 사진!
			</td>
		</tr>
	</table>
	
	<div id="agreeBtn" class="col-sm-6 btn" style="border-color:black; color: black; margin-top: 20px; font-size: 18px; background-color: white">수락하기</div>
	<div id="rejectBtn" class="col-sm-6 btn" style="border-color:black; color: black; margin-top: 20px; font-size: 18px; background-color: white">거절하기</div>
</div>

<!--  승인 시 카드 생성..(미리 만들어진 카드를 사용할 수 없기 떄문에 임시방편)  -->
<form id="submotForm" method="post">
	<input type="hidden" name="id" value="${user.id }">
	<input type="hidden" name="name" value="${sellerRequest.name}">
	<input type="hidden" name="cardNum" value="${sellerRequest.cardNum}">
	<input type="hidden" name="validateYear" value="${sellerRequest.validateYear}">
	<input type="hidden" name="validateMonth" value="${sellerRequest.validateMonth}">
	<input type="hidden" name="cvc" value="${sellerRequest.cvc}">
	<input type="hidden" name="pwd" value="${sellerRequest.pwd}">
	<input type="hidden" name="busiName" value="${sellerRequest.busiName}">
	<input type="hidden" name="bankName" value="${sellerRequest.bankName}">
	<sec:csrfInput/>
</form>


<script type="text/javascript" src="/shoppingmall/resources/js/admin.js"></script>
<script>
	$("#agreeBtn").on("click", function(e) {
		e.preventDefault();
		$("#submotForm").attr("action","/shoppingmall/admin/agreeSellerRequest");
		alert('정상적으로 판매자 신청을 승인하였습니다.');
		$("#submotForm").submit();
	});
	$("#rejectBtn").on("click", function(e) {
		e.preventDefault();
		$("#submotForm").attr("action","/shoppingmall/admin/rejectSellerRequest");
		alert('정상적으로 판매자 신청을  거절하였습니다.');
		$("#submotForm").submit();
	});
</script>

<%@include file="../includes/footer.jsp"%>
