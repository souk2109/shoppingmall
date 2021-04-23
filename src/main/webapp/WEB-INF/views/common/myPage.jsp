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
					<c:when test="${loginUser.postalCode eq 'man'}">남자
					</c:when>
					<c:otherwise>
						여자
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
</div>

<!-- 탈퇴하기, 수정하기, 판매자 신청하기 -->
<%@include file="../includes/footer.jsp" %>