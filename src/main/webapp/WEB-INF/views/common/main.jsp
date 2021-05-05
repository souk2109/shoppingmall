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
	let price;
	let discount;
	let discountedPrice;
</script>
<style>
	.product{
		margin-bottom: 20px;
		width: 32%;
		display: inline-block;
		font-size: 12px;
		border: 1px solid;
		padding: 10px;
		border-radius: 10px;
	}
	.img-container{
		overflow: hidden;
		width:100%;
		height: 80px;
	}
	
</style>
<div align="center">
	<font class="panel-title" size="20px" face="Prompt">Products</font>
</div>
${product[0] }




<div style="width: 80%; margin: 0px auto;">
	<c:forEach items="${products}" var="product">
		<div class="product" align="center">
			<div align="center" class="mainImage img-container" data-pno="${product.pno}" data-path="${product.attachList[0].path}" 
				data-uuid="${product.attachList[0].uuid}" data-fileName="${product.attachList[0].fileName}"  
				data-main="${product.attachList[0].main}"  data-type="${product.attachList[0].fileType}">
			</div>
			
			<div style="padding: 10px">
				<div class="name">${product.prdName }</div>
				<div class="price-area">
					<div class="price-wrap">
						<div class="price">
							<strong><span class="discount-percentage">${product.discount }%</span></strong>
							<del>
								<fmt:formatNumber value="${product.price }" type="number" />원 
							</del>
							<em class="sale ">
								<strong class="price-value">
									<script>
										price = "<c:out value='${product.price }'/>";
										discount = "<c:out value='${product.discount }'/>";
										discountedPrice = makeFloorPrice(parseInt(price)*(1-parseInt(discount)/100));
										discountedPrice = makeComma(discountedPrice);
										document.write(discountedPrice);
									</script>
								</strong>원
							</em>
						</div>
					</div>
				</div>
				<div class="other-info">
					<div class="rating-star">
						<span class="star"><em class="rating" style="width: 90%">4.5</em></span>
						<span class="rating-total-count">(7932)</span>
					</div>
				</div>
				<button class="btn btn-info detailBtn" data-pno="${product.pno}">상세보기</button>
			</div>
		</div>
	</c:forEach>
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
			let str = "<img src='/shoppingmall/display?fileName="+fileCallPath+"' style='max-width: 100%; height: 100%;display: block;'>";
			jobj.append(str);
		}else{
			let str = "<div>대표 이미지 없음</div>";
			jobj.append(str);
		}
	});
	
	$(".detailBtn").on("click", function(e) {
		e.preventDefault();
		let pno = $(this).data("pno");
		window.location.href = "/shoppingmall/common/getProduct?pno="+pno;
	});
</script>

<%@include file="../includes/footer.jsp"%>