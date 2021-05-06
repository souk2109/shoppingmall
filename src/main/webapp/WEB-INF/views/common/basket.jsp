<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Prompt:wght@600&display=swap" rel="stylesheet">
<%-- <section class="cart-title">
	<h1 class="sr-only">장바구니</h1>
</section>
<i class="fa fa-shopping-cart"></i>dd
	${basketList }
	 --%>
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
<div class="container">
	<div class="row" style="margin-bottom: 30px">
		<div class="col-12"><i class="fa fa-shopping-cart fa-3x"></i><font size="30px" style="margin-left: 5px">장바구니</font></div>
	</div>
	<div class="row" style="background-color: white;">
		<div class="col-xs-6 col-sm-6">
			<div class="col-xs-12 col-sm-12">상품 정보</div>
			<div>
				<table class="table">
					<tr>
						<th>대표 사진</th>
						<th>수량</th>
						<th>가격</th>
						<th>비고</th>
					</tr>
					<c:forEach items="${basketList }" var="basket">
						<tr style="background-color: white;border-bottom: 1px solid #ccc;">
						<td style="width: 30%; height: 100px" class="mainImage" data-pno="${basket.pno}" data-path="${basket.productAttachVO.path}" 
							data-uuid="${basket.productAttachVO.uuid}" data-fileName="${basket.productAttachVO.fileName}"  
							data-main="${basket.productAttachVO.main}"  data-type="${basket.productAttachVO.fileType}">
						<td style="width: 20%" class="align-middle">
							<div style="display: table; margin-top: 10px; width: 80px">
								<input id="numInput" type="text" value="${basket.count }" class="prd-quantity-input" maxlength="4" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
								<div class="countBtn-container">
									<button id="plusBtn" class="countBtn">+</button>
									<button id="minusBtn" class="countBtn">-</button>
								</div>
							</div>
						</td>
						<td class="align-middle" style="width: 20%">${basket.price }</td>
						<td class="align-middle" style="width: 20%">a</td>
					</tr>
					</c:forEach>
					 
					
				</table>
			</div>
			 
			<!-- ${basketList } -->
		</div>
		<div class="col-xs-6 col-sm-6" style="background-color: green;">
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
