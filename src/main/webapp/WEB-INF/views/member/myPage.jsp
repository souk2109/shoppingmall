<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link href="https://fonts.googleapis.com/css2?family=Prompt:wght@600&display=swap" rel="stylesheet">
<sec:authentication property="principal" var="loginUser"/>
<div class="container" align="center">
	<div align="center" class="panel-title" >
		<font size="6px" face="Prompt">마이 페이지</font>
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
					<c:when test="${loginUser.gender eq 'man'}">남성
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
					<c:when test="${empty loginUser.postalCode}">-
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
		
		<c:choose>
			<c:when test="${empty myCard}">
				<tr>
					<td>간편 카드</td>
					<td>-</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach items="${myCard}" var="card">
				<tr>
					<td>간편 카드</td>
					<td>${card.bankName} 
					${fn:substring(card.cardNum,0,4)} **** ${fn:substring(card.cardNum,8,12)} 
					${fn:substring(card.name,0,1)}*${fn:substring(card.name,2,3)}
				</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
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
					<th>상호명</th>
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
	<span class="top-bar-menu-item"><a href="/shoppingmall/member/regSimpleCard">간편 카드 등록하기</a></span>
	<span class="top-bar-menu-item"><a href="/shoppingmall/member/deactivatePage">탈퇴하기</a></span>
</div>
<script type="text/javascript" src="/shoppingmall/resources/js/member.js"></script>
<script>
	const id = '<c:out value='${loginUser.username}'/>';
	memberService.getSellerRequests(id, function(list) {
		console.log(list);
		if(list){
			let str = '';
			for(var i=0; i<list.length; i++){
				str += "<tr>";
				str += "<td>"+list[i].name+"</td>";
				str += "<td>"+list[i].busiName+"</td>";
				if(list[i].status === '승인'){
					str += "<td style='color:blue'>" + list[i].status + "</td>";
				}else{
					str += "<td style='color:red'>" + list[i].status + "</td>";
				}
				str += "<td>"+memberService.displayTime(list[i].regdate)+"</td>";
				if(list[i].status === '승인'){
					str += "<td>"+memberService.displayTime(list[i].updatedate)+"</td>";
				}else if(list[i].status === '거절'){
					str += "<td>X</td>";
				}
				else{
					str += "<td></td>";
				}
				str += "</tr>";
			}
			 
			$("#tbody").append(str);
		}
	});
</script>
<script>
	let pwdResult = "<c:out value='${pwdResult}'/>";
	let sellerApplyResult = "<c:out value='${sellerApplyResult}'/>";
	let regSimpleCardResult = "<c:out value='${regSimpleCardResult}'/>";
	if(pwdResult){
		if(pwdResult === 'success'){
			alert('비밀번호를 성공적으로 변경하였습니다.');
		}else{
			alert('비밀번호를 변경하는데 실패하였습니다.\n(현재 비밀번호가 틀림)');
		}
	}
	
	if(sellerApplyResult){
		if(sellerApplyResult === 'success'){
			alert('판매자 신청을 정상적으로 완료하였습니다.');
		}
	}
	
	if(regSimpleCardResult){
		if(regSimpleCardResult === 'success'){
			alert('간편 카드를 정상적으로 등록하였습니다.');
		}
	}
</script>

<script>
	/* let myCard = "<c:out value='${myCard}'/>";
	console.log(myCard); */
</script>
<!-- 탈퇴하기, 수정하기, 판매자 신청하기 -->
<%@include file="../includes/footer.jsp" %>