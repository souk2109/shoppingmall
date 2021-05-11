<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Prompt:wght@600&display=swap" rel="stylesheet">
<style>
	.prd-quantity-input{
		vertical-align: top;
	    text-align: center;
	    border: 0;
	    width: 40px;
	    height: 40px;
	    background: transparent;
	    font-size: 16px;
	    font-weight: bold;
	    border-right: 1px solid #eee;
	    box-sizing: border-box;
	    color: #111;
	    line-height: 25px;
	    padding: 11px 0 9px 0;
	}
	.countBtn{
		position: relative; 
		height: 25px; 
		width: 25px; 
		display: block;
	}
	.countBtn-container{
		display: table-cell; 
		vertical-align: top;
	}
</style>
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
	let price;
	let discount;
	let discountedPrice;
	let count;
	let totalPrdPrice = 0;
</script>
<div class="container">
	<div class="row" style="margin-bottom: 30px">
		<div class="col-12"><i class="fa fa-shopping-cart fa-3x"></i><font size="30px" style="margin-left: 5px;">장바구니</font></div>
	</div>
	<div class="row" style="margin-bottom: 30px">
		<div class="col-xs-8 col-sm-8">
			<div class="col-sm-12" style="border-left: 6px solid #ccd;margin-bottom: 10px">상품 정보</div>
			<div>
				<table class="table prd-info">
					<c:forEach items="${basketList }" var="basket">
						<tr style="background-color: white;border-bottom: 1px solid #ccc;" data-price="${basket.price }" data-discount="${basket.discount }" data-stock="${basket.stock }" data-pno="${basket.pno}">
							<!-- 상품 이미지 -->
							<td align="center" style="width: 30%; height: 100px; cursor: pointer;padding: 0px;" class="mainImage" data-pno="${basket.pno}" data-path="${basket.productAttachVO.path}" 
								data-uuid="${basket.productAttachVO.uuid}" data-fileName="${basket.productAttachVO.fileName}"  
								data-main="${basket.productAttachVO.main}"  data-type="${basket.productAttachVO.fileType}">
								<div align="center">${basket.prdName }</div>
							</td>
							<!-- 수량 -->
							<td style="width: 20%;padding: 0px" class="align-middle">
								<div style="display: table; margin-top: 10px; width: 80px">
									<input type="text" value="${basket.count }" class="prd-quantity-input" maxlength="4" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
									<div class="countBtn-container">
										<button class="plusBtn countBtn">+</button>
										<button class="minusBtn countBtn">-</button>
									</div>
								</div>
								<div style="font-size: 12px;color: red;font-weight: bold;">수량:${basket.stock }개</div>
							</td>
							<!-- 가격 정보 -->
							<td class="align-middle" style="width: 25%;padding: 0px">
								<script>
									price = "<c:out value='${basket.price }'/>";
									discount = "<c:out value='${basket.discount }'/>";
									count = "<c:out value='${basket.count }'/>";
									discountedPrice = makeFloorPrice(parseInt(price)*(1-parseInt(discount)/100));
								</script>
								<div>
									 <script>document.write(discount);</script><span>%</span>
								</div>
								<del style="font-size: 14px">
									<div style="display: inline;">
										<script>document.write(makeComma(price));</script><span style="font-size: 12px;"></span>
									</div>
									<span>원</span>
								</del>
								<div>
									<div style="display: inline;">
										<script>document.write(makeComma(discountedPrice));</script>
									</div>
									<span>원</span>
								</div>
							</td>
							<!-- 해당 상품의 n개 가격과 삭제를 위한 x표시 -->
							<td class="align-middle" style="width: 25%;padding: 0px">
								<div class="totalPrice" style="display: inline;">
									<script>document.write(makeComma(discountedPrice*count));</script>
								</div>
								<span style="font-size: 12px;">원</span>
								<button class="btn btn-circle removeBtn" data-pno="${basket.pno }">
									<i style="float: right;margin-right: 5px" class="fa fa-times"></i>
								</button>
								 
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<div class="col-xs-4 col-sm-4">
			<div class="col-sm-12"  style="border-left: 6px solid #ccd;margin-bottom: 10px">결제 정보</div>
			<div>
				<table class="table">
					<c:forEach items="${basketList }" var="basket">
						<script>
							price = "<c:out value='${basket.price }'/>";
							discount = "<c:out value='${basket.discount }'/>";
							count = "<c:out value='${basket.count }'/>";
							discountedPrice = makeFloorPrice(parseInt(price)*(1-parseInt(discount)/100));
							totalPrdPrice += count * discountedPrice;
						</script>
						<tr id="${basket.pno }">
							<td>${basket.prdName }
								<span id="count${basket.pno}"><script>document.write("("+count+")");</script></span>
							</td>
							<td align="right">
								<div style="display: inline;" id="totalPrice${basket.pno}">
									<script>document.write(makeComma(discountedPrice*count));</script>
								</div>
								<span>원</span>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
			<div class="col-12" style="border-left: 6px solid #ccd;margin-bottom: 10px;margin-top: 40px;">
					<div>총 결제 금액</div>
			</div>
			<div class="col-12"  style="font-size: 25px; font-weight: bold;text-align:center">
				<div id="totalPrdPrice" style="display: inline;">
					<script>document.write(makeComma(totalPrdPrice));</script>
				</div>
				<span>원</span>
			</div>
			<div class="col-12">
				<div id="orderBtn" class="btn btn-primary">주문하기</div>
			</div>
		<!-- ${basketList[0].productAttachVO } -->
		</div>
	</div>
</div>
<script type="text/javascript" src="/shoppingmall/resources/js/common.js"></script>
<script>
	$("#orderBtn").on("click", function() {
		if(0 === getTotalPrice()){
			alert('장바구니가 비어있습니다.');
			return;
		}
		window.location.href = "/shoppingmall/member/basketPayment";
	});
	// 이미지 클릭시 해당 상품 페이지로 이동
	$(".mainImage").on("click", function() {
		let pno = $(this).data("pno");
		window.location.href="/shoppingmall/common/getProduct?pno=" + pno;
	});
	
	// 메인 이미지를 불러옴
	$(".mainImage").each(function(i, obj) {
		let jobj= $(obj);
		let pno = $(this).data("pno");
		let uuid = $(this).data("uuid");
		if(uuid){
			let path = $(this).data("path");
			let fileName = $(this).data("filename");
			let fileCallPath = encodeURIComponent(path+"/"+uuid +"_" +fileName);
			let str = "<img src='/shoppingmall/display?fileName="+fileCallPath+"' style='height: 100px'>";
			jobj.append(str);
		}else{
			let str = "<div>대표 이미지 없음</div>";
			jobj.append(str);
		}
	});
	
	// 수량 증가 버튼 클릭 시
	$(".plusBtn").on("click", function() {
		let num = $(this).closest("tr").find(".prd-quantity-input").val(); // 현재 구매할 상품 개수
		let stock = $(this).closest("tr").data("stock"); // 현재 상품의 재고
		let pno = $(this).closest("tr").data("pno"); 
		// 수량은 재고보다 클 수가 없다.
		if(parseInt(num) ===  parseInt(stock)){
			return;
		}
		
		let increasedNum = parseInt(num)+1; // 증가된 개수
		let cprice = $(this).closest("tr").data("price"); // 현재 상품의 가격
		let cdiscount = $(this).closest("tr").data("discount"); // 현재 상품의 할인 %
		 
		$(this).closest("tr").find(".prd-quantity-input").val(increasedNum);
		let ctotalPrice = increasedNum * makeFloorPrice(cprice * (1-cdiscount/100));
		 
		console.log(pno);
		$(this).closest("tr").find(".totalPrice").html(makeComma(ctotalPrice));
		$("#count"+pno).text(increasedNum);
		$("#totalPrice"+pno).text(makeComma(ctotalPrice));
		getTotalPrice();
		// 수량 쿠키에서 변경
		commonService.updateBasket(pno, increasedNum);
	});
	
	// 수량 감소 버튼 클릭 시
	$(".minusBtn").on("click", function() {
		let pno = $(this).closest("tr").data("pno"); 
		let num = $(this).closest("tr").find(".prd-quantity-input").val(); // 현재 구매할 상품 개수
		if(num ===  "1"){
			return;
		}
		let decreasedNum = parseInt(num)-1; // 감소된 개수
		let cprice = $(this).closest("tr").data("price"); // 현재 상품의 가격
		let cdiscount = $(this).closest("tr").data("discount"); // 현재 상품의 할인 %
		
		$(this).closest("tr").find(".prd-quantity-input").val(decreasedNum);
		let ctotalPrice = decreasedNum * makeFloorPrice(cprice * (1-cdiscount/100));
		console.log(decreasedNum);
		$(this).closest("tr").find(".totalPrice").html(makeComma(ctotalPrice));
		
		$("#count"+pno).text(decreasedNum);
		$("#totalPrice"+pno).text(makeComma(ctotalPrice));
		getTotalPrice();
		commonService.updateBasket(pno, decreasedNum);
	});
	
	// 직접 수량을 입력한 경우
	$(".prd-quantity-input").on("keyup change paste", function() {
		let pno = $(this).closest("tr").data("pno"); 
		let stock = $(this).closest("tr").data("stock"); // 현재 상품의 재고
		let cprice = $(this).closest("tr").data("price"); // 현재 상품의 가격
		let cdiscount = $(this).closest("tr").data("discount"); // 현재 상품의 할인 %
		if(parseInt($(this).val()) > parseInt(stock)){
			$(this).val(stock);
		}
		if($(this).val() === "0"){
			$(this).val("1");
		}
		
		let ctotalPrice = $(this).val() * makeFloorPrice(cprice * (1-cdiscount/100));
		$(this).closest("tr").find(".totalPrice").html(makeComma(ctotalPrice));
		
		$("#count"+pno).text($(this).val());
		$("#totalPrice"+pno).text(makeComma(ctotalPrice));
		getTotalPrice();
		commonService.updateBasket(pno, $(this).val());
	});
	
	// input상자가 공백인 상태에서 focusout한 경우 1로 수량 증가
	$(".prd-quantity-input").on("focusout", function() {
		if($(this).val() === ""){
			let pno = $(this).closest("tr").data("pno"); 
			let stock = $(this).closest("tr").data("stock"); // 현재 상품의 재고
			let cprice = $(this).closest("tr").data("price"); // 현재 상품의 가격
			let cdiscount = $(this).closest("tr").data("discount"); // 현재 상품의 할인 %
			$(this).val("1");
			let ctotalPrice = $(this).val()*makeFloorPrice(cprice * (1-cdiscount/100));
			$(this).closest("tr").find(".totalPrice").html(makeComma(ctotalPrice));
			$("#count"+pno).text("1");
			$("#totalPrice"+pno).text(makeComma(ctotalPrice));
			getTotalPrice();
		}
	});
	
	// 총 금액을 더하는 함수
	function getTotalPrice() {
		let totalPrice = 0;
		$(".prd-info tr").each(function(i, obj) {
			let cPrice = $(obj).data("price");
			let cCount = $(this).find("input").val();
			let cDiscount = $(obj).data("discount");
			totalPrice += makeFloorPrice(cPrice * (1-cDiscount/100)) * cCount;
		});
		$("#totalPrdPrice").html(makeComma(totalPrice));
		return totalPrice;
	}
	
	$(".removeBtn").on("click", function() {
		$(this).closest("tr").remove();
		let pno = $(this).closest("tr").data("pno");
		$("#"+pno).remove();
		getTotalPrice();
		// 쿠키에서 해당 항목 삭제
		commonService.removeBasket(pno);
	});
</script>
<%@include file="../includes/footer.jsp" %>