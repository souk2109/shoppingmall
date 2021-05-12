<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link href="https://fonts.googleapis.com/css2?family=Prompt:wght@600&display=swap" rel="stylesheet">
<sec:authentication property="principal" var="loginUser"/>

<script>
	const money = "<c:out value='${money}'/>";
	if(!money){
		window.location.href="/shoppingmall/member/orderInfo";
	}
	function makeComma(num) {
		num = num.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
		return num;
	}
</script>

<div class="container" align="center">
	<div class="row" style="margin-bottom: 30px" align="left">
		<div class="col-12"><i class="fa fa-shopping-bag fa-3x" aria-hidden="true"></i><font size="30px" style="margin-left: 5px">결제 성공</font></div>
	</div>
	
	<div class="row col-md-8 col-sm-12" style="margin-bottom: 30px; border: solid 2px #ccd;padding: 0px">
		<div class="col-12" style="border-bottom: solid 2px #ccd; padding: 5px;margin-bottom: 20px">
			<h4>결제 완료</h4>
		</div>
		<c:forEach items="${trHistoryList }" var="trHistory">
			<div class="col-10" style="border: solid 1px #ccd; padding: 5px;border-radius: 5px; margin: auto;margin-bottom: 20px">
				<div class="col-12" align="left" style="margin-bottom: 10px">
					<span>주문번호 : </span>
					<span>${trHistory.orderNum }</span>
				</div>
				<div class="col-12" align="left" style="margin-bottom: 10px">
					<span>상호명 : </span>
					<span>${trHistory.busiName }</span>
				</div>
				<div class="col-12" align="left" style="margin-bottom: 10px">
					<span>수량 : </span>
					<span>${trHistory.count }개</span>
				</div>
				<div class="col-12" align="left" style="margin-bottom: 10px">
					<span>금액 : </span>
					<span>
						<script>
							var price = "<c:out value='${trHistory.price }'/>";
							price = makeComma(price);
							document.write(price+" 원");
						</script>  
					</span>
				</div>
				<div class="col-12" align="left" style="margin-bottom: 10px">
					<span>결제 카드 : </span>
					<span>(${trHistory.paymentCardBankName })${trHistory.paymentCardNum } [${trHistory.paymentCardName }]</span>
				</div>
			</div>
		</c:forEach>
		<div class="col-10" style="padding: 5px; margin: auto;margin-bottom: 20px">
			<div class="col-12" align="left" style="margin-bottom: 10px">
				<div>
					<h5>총 결제금액 : 
						<script>
							price = makeComma(money);
							document.write(price+" 원");
						</script>  
					</h5>
				</div>
			</div>
		</div>
		<div class="col-12" style="padding: 5px; margin: auto;margin-bottom: 20px">
			<div style="margin-top: 20px">
				<span class="top-bar-menu-item">
					<a href="/shoppingmall/member/orderInfo">주문내역 보기</a>
				</span>
			</div>
		</div>
	</div>
	
</div>
<%@include file="../includes/footer.jsp" %>