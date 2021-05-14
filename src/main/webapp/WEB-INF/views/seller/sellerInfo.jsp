<%@include file="../includes/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script>
	// 숫자에 콤마 표시 함수(정규식 이용)
	function makeComma(num) {
		num = num.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
		return num;
	}
</script>
<div class="container" align="center">
	<div class="row" style="margin-bottom: 30px" align="left">
		<div class="col-12"><i class="fa fa-shopping-bag fa-3x" aria-hidden="true"></i><font size="30px" style="margin-left: 5px">거래내역</font></div>
	</div>
	<div class="row" style="margin-bottom: 30px" align="center">
		<div class="col-xs-12 col-sm-12">
			<div>
				<table class="table prd-info">
					<tr align="center" style="font-size: 13px">
						<th>번호</th>
						<th>품명</th>
						<th>상품상태</th>
						<th>결제시간</th>
						<th>금액</th>
						<th>조회</th>
					</tr>
					<c:forEach items="${trHistoryList }" var="history">
						<tr style="background-color: white;border-bottom: 1px solid #ccc;" align="center" data-orderNum="${history.orderNum }">
							<td class="align-middle" style="width: 10%; height: 100px;padding: 0px;">
								${history.orderNum }
							</td>
							<td class="align-middle" style="width: 20%; height: 100px;padding: 0px;">
								${history.productName }
							</td>
							<!-- 가격 정보 -->
							<td class="align-middle" style="width: 15%;padding: 0px;">
								<c:choose>
									<c:when test="${history.prdStatus eq 'ready'}">
										<font style="font-weight: bold;" color="red">준비중</font>
									</c:when>
									<c:when test="${history.prdStatus eq 'shipping'}">
										<font style="font-weight: bold;" color="blue">배송중</font>
									</c:when>
									<c:when test="${history.prdStatus eq 'arrive'}">
										<font style="font-weight: bold;">상품 도착</font>
									</c:when>
								</c:choose>
							</td>
							<!-- 해당 상품의 n개 가격과 삭제를 위한 x표시 -->
							<td class="align-middle" style="width: 15%;padding: 0px">
								<fmt:formatDate value="${history.buyDate }" pattern="yyyy.MM.dd hh:mm" />
							</td>
							<td class="align-middle" style="width: 15%;padding: 0px">
								<script>
									document.write(makeComma(${history.price}))
								</script>
								<span>원</span>
							</td>
							<td class="align-middle" style="width: 15%;padding: 0px">
								<button class="detailBtn" style="width:70%; background: #346aff;color: #fff;font-size: 13px"> 상세보기 </button>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="/shoppingmall/resources/js/member.js"></script>
<script>
	$(".detailBtn").on("click", function() {
		let orderNum = $(this).closest("tr").data("ordernum");
		window.location.href = "/shoppingmall/seller/detail?orderNum="+orderNum;
	});
</script>
 
<%@include file="../includes/footer.jsp"%>