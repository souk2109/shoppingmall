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
		height: 20px; 
		width: 20px; 
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
</script>
<div class="container">
	<div class="row" style="margin-bottom: 30px">
		<div class="col-12"><i class="fa fa-shopping-cart fa-3x"></i><font size="30px" style="margin-left: 5px">장바구니</font></div>
	</div>
	<div class="row" style="background-color: white;">
		<div class="col-xs-8 col-sm-8">
			<div class="col-xs-12 col-sm-12">상품 정보</div>
			<div>
				<table class="table">
					<c:forEach items="${basketList }" var="basket">
						<tr style="background-color: white;border-bottom: 1px solid #ccc;">
							<!-- 상품 이미지 -->
							<td align="center" style="width: 30%; height: 100px" class="mainImage" data-pno="${basket.pno}" data-path="${basket.productAttachVO.path}" 
								data-uuid="${basket.productAttachVO.uuid}" data-fileName="${basket.productAttachVO.fileName}"  
								data-main="${basket.productAttachVO.main}"  data-type="${basket.productAttachVO.fileType}">
								<div align="center">${basket.prdName }</div>
							<!-- 수량 -->
							<td style="width: 20%" class="align-middle">
								<div style="display: table; margin-top: 10px; width: 80px">
									<input id="numInput" type="text" value="${basket.count }" class="prd-quantity-input" maxlength="4" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
									<div class="countBtn-container">
										<button id="plusBtn" class="countBtn">+</button>
										<button id="minusBtn" class="countBtn">-</button>
									</div>
								</div>
							</td>
							<!-- 가격 정보 -->
							<td class="align-middle" style="width: 30%">
								<script>
									price = "<c:out value='${basket.price }'/>";
									discount = "<c:out value='${basket.discount }'/>";
									discountedPrice = makeFloorPrice(parseInt(price)*(1-parseInt(discount)/100));
									discountedPrice = makeComma(discountedPrice);
								</script>
								<div>
									 <script>document.write(discount);</script><span>%</span>
								</div>
								<del>
									<script>document.write(price);</script><span>원</span>
								</del>
								<div>
									<script>document.write(discountedPrice);</script><span>원</span>
								</div>
							</td>
							<!-- x표시 -->
							<td class="align-middle" style="width: 20%">aa</td>
						</tr>
					</c:forEach>
					 
					
				</table>
			</div>
			 
			<!-- ${basketList } -->
		</div>
		<div class="col-xs-4 col-sm-4" style="background-color: green;">
			<div>결제 정보</div>
		<!-- ${basketList[0].productAttachVO } -->
		</div>
	</div>
</div>
<script>
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
	
</script>
<%@include file="../includes/footer.jsp" %>