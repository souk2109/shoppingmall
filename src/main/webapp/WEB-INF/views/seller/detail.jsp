<%@include file="../includes/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script>
	//올림 함수
	function makeFloorPrice(num) {
		num = Number(num);
		let result = Math.floor(num/10)*10;
		return result;
	}
	// 숫자에 콤마 표시 함수(정규식 이용)
	function makeComma(num) {
		num = num.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
		return num;
	}
</script>
<div class="container" align="center">
	<div class="row" style="margin-bottom: 30px" align="left">
		<div class="col-12"><font size="30px" style="margin-left: 5px">거래 상세보기</font></div>
	</div>
	<div class="row col-md-8 col-sm-12" style="margin-bottom: 30px;padding: 0px">
		<div class="col-10" style="border: solid 1px #ccd; padding: 5px; border-radius: 5px; margin: auto; margin-bottom: 20px">
			<div style="font-size: 20px; font-weight: bold; margin-bottom: 5px">
				<h4>No.${trHistory.orderNum }</h4>
			</div>
			<div id="prdImg" data-pno="${trHistory.pno }"></div>
			<div class="col-12" align="left" style="margin-bottom: 10px">
				<c:choose>
					<c:when test="${trHistory.prdStatus eq 'ready'}">
						<font style="font-weight: bold;">상품 준비중</font>
					</c:when>
					<c:when test="${trHistory.prdStatus eq 'shipping'}">
						<font style="font-weight: bold;">배송중</font>
					</c:when>
					<c:when test="${trHistory.prdStatus eq 'arrive'}">
						<font style="font-weight: bold;">상품 도착</font>
					</c:when>
				</c:choose>
			</div>
			<div class="prdImg" data-pno="${trHistory.pno }"></div>
			<div class="col-12" align="left" style="margin-bottom: 10px">
				<span>상호명 : </span> <span>${trHistory.busiName }</span>
			</div>
			<div class="col-12" align="left" style="margin-bottom: 10px">
				<span>상품명 : </span> <span>${trHistory.productName }</span>
			</div>
			<div class="col-12" align="left" style="margin-bottom: 10px">
				<span>수량 : </span> <span>${trHistory.count }개</span>
			</div>
			<div class="col-12" align="left" style="margin-bottom: 10px">
				<span>총 금액 : </span> 
				<span><script>document.write(makeComma(${trHistory.price}));</script>원</span>
			</div>
			<div class="col-12" align="left" style="margin-bottom: 10px">
				<span>결제 카드 : </span> <span>(${trHistory.paymentCardBankName })${trHistory.paymentCardNum }
					[${trHistory.paymentCardName }]</span>
			</div>
			<div class="col-12" align="left" style="margin-bottom: 10px">
				<span>구매자 ID : </span> <span>${trHistory.clientId }</span>
			</div>
			<div class="col-12" align="left" style="margin-bottom: 10px">
				<span>구매자 이름 : </span> <span>${trHistory.clientName }</span>
			</div>
			<div class="col-12" align="left" style="margin-bottom: 10px">
				<span>결제 시간 : </span> <span><fmt:formatDate
						value="${trHistory.buyDate }" pattern="yyyy.MM.dd hh:mm" /></span>
			</div>
			<c:choose>
				<c:when test="${trHistory.prdStatus eq 'ready'}">
					<button id="shippingBtn" style="width:70%; background: #346aff;color: #fff;font-size: 13px">배송 중</button>
				</c:when>
				<c:when test="${trHistory.prdStatus eq 'shipping'}">
					<button id="arriveBtn" style="width:70%; background: #346aff;color: #fff;font-size: 13px">배송 완료</button>
				</c:when>
				<c:when test="${trHistory.prdStatus eq 'arrive'}">
					<button style="width:70%; background: #ccc;color:#000000;font-size: 13px" disabled="disabled">배송 완료</button>
				</c:when>
				<c:when test="${trHistory.prdStatus eq 'cancel'}">
					<button style="width:70%; background: #ccc;color:#000000;font-size: 13px" disabled="disabled">구매 취소</button>
				</c:when>
			</c:choose>
			<div style="margin: 20px">
				<h6>상품 배송 후 <u>'배송중'</u>을 선택해주세요.</h6>
				<h6>상품 배송 완료 후 <u>'배송완료'</u>를 선택해주세요.</h6>
			</div>
		</div>
	</div>
</div>
<form id="formObj" action="/shoppingmall/seller/modifyDetail" method="post">
</form>
<script type="text/javascript" src="/shoppingmall/resources/js/member.js"></script>
<script>
	getMainImage();
	function getMainImage() {
		let pno = $("#prdImg").data("pno");
		memberService.getProductMainImage(pno, function(attachInfo) {
			if(!attachInfo){
				let str = "이미지 없음";
				$("#prdImg").append(str);
				return;
			}
			let fileCallPath = encodeURIComponent(attachInfo.path+"/"+attachInfo.uuid +"_" +attachInfo.fileName);
			console.log(fileCallPath);
			let str = "<img src='/shoppingmall/display?fileName="+fileCallPath+"' style='height: 100px'>";
			$("#prdImg").append(str);
		});
	}
	 
	$("#shippingBtn").on("click", function(e) {
		e.preventDefault();
		let result = confirm("'배송 중'으로 변경하시겠습니까?");
		let orderNum = "<c:out value='${trHistory.orderNum }'></c:out>";
		if(result){
			$("#formObj").append("<input type='hidden' name='orderNum' value=" + orderNum + ">");
			$("#formObj").append("<input type='hidden' name='prdStatus' value='shipping'>");
			$("#formObj").submit();
		}
	});
	
	$("#arriveBtn").on("click", function(e) {
		e.preventDefault();
		let result = confirm("'배송 완료'로 변경하시겠습니까?");
		let orderNum = "<c:out value='${trHistory.orderNum }'></c:out>";
		if(result){
			$("#formObj").append("<input type='hidden' name='orderNum' value=" + orderNum + ">");
			$("#formObj").append("<input type='hidden' name='prdStatus' value='arrive'>");
			$("#formObj").submit();
		}
	});
</script>
<%@include file="../includes/footer.jsp"%>