<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link href="https://fonts.googleapis.com/css2?family=Prompt:wght@600&display=swap" rel="stylesheet">
<sec:authentication property="principal" var="loginUser"/>
<div class="container" align="center">
	<div align="center" class="panel-title" >
		<font size="6px" face="Prompt">내정보</font>
	</div>
	
	<table class="table" style="width: 60%; text-align: center; margin-top: 20px" >
		<tr>
			<th>항목</th>
			<th>개인정보</th>
		</tr>
		<tr>
			<td>아이디</td>
			<td>${loginUser.username}</td>
		</tr>
		<tr>
			<td>이름</td>
			<td>${loginUser.name}</td>
		</tr>
		<tr>
			<td>별명</td>
			<td>${loginUser.nickname}</td>
		</tr>
		<tr>
			<td>생년월일</td>
			<td>${loginUser.birthday}</td>
		</tr>
		<tr>
			<td>성별</td>
			<td>
				<c:choose>
					<c:when test="${loginUser.postalCode eq 'man'}">남성
					</c:when>
					<c:otherwise>
						여성
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>${loginUser.email}</td>
		</tr>
		<tr>
			<td>우편번호</td>
			<td>
				<c:choose>
					<c:when test="${empty loginUser.postalCode}">비어있음
					</c:when>
					<c:otherwise>
						${loginUser.postalCode}
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td>생성일</td>
			<td> 
				<fmt:formatDate value="${loginUser.regDate}" pattern="yyyy년 MM월 dd일"/>
			</td>
		</tr>
		<tr>
			<td>자주 사용하는 계좌</td>
			<td> 
				만들자
			</td>
		</tr>
	</table>
	
	<a href="/shoppingmall/member/pwdModify">
		<div class="col-sm-6 btn" style="border: hidden; color: white; margin-top: 20px; font-size: 18px; background-color: #CCCCCC;">비밀번호 변경하기</div>
	</a>
	
	<div align="center" class="panel-title" style="margin-top: 30px">
		<font size="6px" face="Prompt">판매자 신청 현황</font>
		<table class="table" style="width: 60%; text-align: center; margin-top: 20px; font-size: 12px" >
			<thead>
				<tr>
					<th>이름</th>
					<th>상태</th>
					<th>신청일</th>
					<th>승인일</th>
				</tr>
			</thead>
			<tbody id="tbody">
				
			</tbody>
		</table>
	</div>
</div>
<div align="center" style="font-size: 14px; margin-top: 30px; margin-bottom: 30px" class="col-sm-12">
	<span class="top-bar-menu-item"><a href="/shoppingmall/member/sellerApply">판매자 신청</a></span>
	<span class="top-bar-menu-item"><a href="#">계좌 등록하기</a></span>
	<span class="top-bar-menu-item"><a href="#">탈퇴하기</a></span>
	
</div>
<script type="text/javascript" src="/shoppingmall/resources/js/member.js"></script>
<script>
	const id = '<c:out value='${loginUser.username}'/>';
	memberService.getSellerRequest(id, function(sellerRequestVO) {
		if(sellerRequestVO){
			let str = "<tr>";
			str += "<td>"+sellerRequestVO.name+"</td>";
			if(sellerRequestVO.status === 0){
				str += "<td style='color:red'>" + "처리중" + "</td>";
			}else if(sellerRequestVO.status === 1){
				str += "<td style='color:blue'>" + "승인" + "</td>";
			}
			str += "<td>"+memberService.displayTime(sellerRequestVO.regdate)+"</td>";
			if(sellerRequestVO.status === 1){
				str += "<td>"+memberService.displayTime(sellerRequestVO.successdate)+"</td>";
			}else{
				str += "<td></td>";
			}
			str += "</tr>";
			$("#tbody").append(str);
			console.log(sellerRequestVO);
		}
	});
</script>
<!-- 탈퇴하기, 수정하기, 판매자 신청하기 -->
<%@include file="../includes/footer.jsp" %>