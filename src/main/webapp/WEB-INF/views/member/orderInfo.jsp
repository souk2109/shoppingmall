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
${trHistoryList[0] }
<div class="container" align="center">
	<div class="row" style="margin-bottom: 30px" align="left">
		<div class="col-12"><i class="fa fa-shopping-bag fa-3x" aria-hidden="true"></i><font size="30px" style="margin-left: 5px">주문내역</font></div>
	</div>
	 
	<div class="row col-md-8 col-sm-12" style="margin-bottom: 30px; border: solid 2px #ccd;padding: 0px">
		<div class="col-12" style="border-bottom: solid 2px #ccd; padding: 5px;margin-bottom: 20px">
			<h4>주문내역</h4>
		</div>
		<c:forEach items="${trHistoryList }" var="history">
			<div class="col-10" style="border: solid 1px #ccd; padding: 5px;border-radius: 5px; margin: auto;margin-bottom: 20px">
				<div style="font-size: 20px;font-weight: bold;">
					<fmt:formatDate value="${history.buyDate }" pattern="yyyy.MM.dd주문"/>
				</div>
				<div class="col-12" align="left" style="margin-bottom: 10px">
					<span>주문번호 : </span>
					<span>${history.orderNum }</span>
				</div>
				<div class="col-12" align="left" style="margin-bottom: 10px">
					<c:if test="${history.prdStatus eq 'ready'}">
						<font style="font-weight: bold;">상품 준비중</font>
					</c:if>
				</div>
				<div class="prdImg" data-pno="${history.pno }"></div>
				<div class="col-12" align="left" style="margin-bottom: 10px">
					<span>상호명 : </span>
					<span>${history.busiName }</span>
				</div>
				<div class="col-12" align="left" style="margin-bottom: 10px">
					<span>상품명 : </span>
					<span>${history.productName }</span>
				</div>
				<div class="col-12" align="left" style="margin-bottom: 10px">
					<span>수량 : </span>
					<span>${history.count }개</span>
				</div>
				<div class="col-12" align="left" style="margin-bottom: 10px">
					<span>금액 : </span>
					<span>${history.price }원</span>
				</div>
				<div class="col-12" align="left" style="margin-bottom: 10px">
					<span>결제 카드 : </span>
					<span>(${history.paymentCardBankName })${history.paymentCardNum } [${history.paymentCardName }]</span>
				</div>
				<div class="col-12" align="left" style="margin-bottom: 10px">
					<span>결제 시간 : </span>
					<span><fmt:formatDate value="${history.buyDate }" pattern="yyyy년 MM월 dd일 hh시 mm분"/></span>
				</div>
				<c:if test="${history.prdStatus eq 'ready'}">
					<div class="col-12" align="left" style="margin-bottom: 10px">
						<input class="btn" value="취소/변경하기">
					</div>
				</c:if>
			</div>
		</c:forEach>
	</div>
</div>
<script type="text/javascript" src="/shoppingmall/resources/js/member.js"></script>
<script>
	$(".prdImg").each(function(i, obj) {
		let pno = $(this).data("pno");
		memberService.getProductMainImage(pno, function(attachInfo) {
			if(!attachInfo){
				let str = "이미지 없음";
				$(obj).append(str);
				return;
			}
			let fileCallPath = encodeURIComponent(attachInfo.path+"/"+attachInfo.uuid +"_" +attachInfo.fileName);
			console.log(fileCallPath);
			let str = "<img src='/shoppingmall/display?fileName="+fileCallPath+"' style='height: 100px'>";
			$(obj).append(str);
		});
	})
	 
</script>
 
<%@include file="../includes/footer.jsp"%>