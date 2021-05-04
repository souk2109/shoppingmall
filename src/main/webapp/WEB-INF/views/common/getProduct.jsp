<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Prompt:wght@600&display=swap" rel="stylesheet">
<style>
	.prd-img{
	    float: left;
	  	width: 40%;
	    text-align: center;
	    margin: 0px auto;
	    margin-right: 10px;
	}
	.prd-info{
	    float: right;
	    width: 50%;
	    font-size: 12px;
	    margin: 0px auto;
	    margin-left: 10px;
	}
	.prd-info-container{
		position: relative;
    	padding: 0 0 10px;
    	border-bottom: 1px solid #ccc;
	}
	.prd-info-name{
		font-size: 18px;
    	font-weight: bold;
	}
	.prd-info-category{
		font-size: 12px;
	    padding-bottom: 6px;
	    display: inline-block;
	}
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
	.prd-buy-info{
	    display: block;
	    float: left;
	    cursor: pointer;
	    position: relative;
	    line-height: 40px;
	    width: 181px;
	    height: 42px;
	    background: transparent;
	    text-align: center;
	    font-weight: bold;
	    font-size: 16px;
	    border: 1px solid #346aff;
	}
	#sub-image ul{
		list-style:none;
		white-space:nowrap; 
    	overflow-x: auto;
    	text-align:center;
	}
	#sub-image ul li{
		display:inline-block; 
		padding: 10px 20px; 
		background: #ccc; 
		margin-right:10px;
	}
</style>
<div class="container" style="margin-bottom: 100px">
	<div class="row">
		<div class="col-md-10" style="margin: 0 auto;">
			<div class="panel-default">
				<div class="prd-img" align="center" style="height: 500px">
					<div>대표 이미지</div>
					<div id="main-image" style="width: 100%; height: 60%; padding: 20px;">
					</div>
					<div style="margin-top: 1px solid #346aff;">첨부 이미지</div>
					<div id="sub-image" style="width: 100%; height: 40%;">
						<ul></ul>
					</div>
				</div>
				<div class="prd-info">
					<div class="prd-info-container">
						<c:choose>
							<c:when test="${product.category eq 'clothes'}">
								<div class="prd-info-category">패션 의류/잡화</div>
							</c:when>
							<c:when test="${product.category eq 'food'}">
								<div class="prd-info-category">식품</div>
							</c:when>
							
						</c:choose>
						<div class="prd-info-name">${product.prdName }</div>
					</div>
					
					<div class="prd-info-container">
						<div class="prd-info-category">${product.discount }%</div>
						<del style="color: #888;">${product.price }원</del>
						<div>할인가 추가하기</div>
					</div>
					<div style="display: inline-block;">
						<span>수량</span>
						<div style="display: table;margin-top: 10px;width: 80px">
							<input id="numInput" type="text" value="1" class="prd-quantity-input" maxlength="6" autocomplete="off">
							<div style="display: table-cell; vertical-align: top;">
								<button id="plusBtn" style="position: relative;height:20px;width:20px ;display: block;">+</button>
								<button id="minusBtn" style="position: relative;height:20px;width:20px ;display: block;">-</button>
							</div>
						</div>
					</div>
					<div style="border-top: 1px solid #ccc; margin-top: 10px;width: 100%">
						<span>가격</span>
						<div style="width: 100%">
							<div style="height: 41.6px; font-size: 20px">3232<span>원</span></div>
						</div>
					</div>
					<button class="prd-buy-info" style="width:100%;color: #346AFF;margin-top: 10px;">장바구니</button>
					<button class="prd-buy-info" style="width:100%; background: #346aff;color: #fff;margin-top: 10px">구매하기</button>
				</div>
				 
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="/shoppingmall/resources/js/fileupload.js"></script>
<script>
	$("#plusBtn").on("click", function() {
		let num = $("#numInput").val();
		$("#numInput").val(parseInt(num)+1);
	});
	$("#minusBtn").on("click", function() {
		let num = $("#numInput").val();
		if(num > 1){
			$("#numInput").val(parseInt(num)-1);
		}
	});
</script>
<!--  사진 보여주기  -->
<script>
	const pno = "<c:out value='${product.pno }'/>";
	function startDisplay() {
		fileuploadService.getProductImages(pno, function(list) {
			showUploadedFile(list);
		});
	}
	
	startDisplay();
	
	function showUploadedFile(fileList) {
		if(!fileList || fileList.length == 0){
			return;
		}
		// 1. main이미지인 경우 main에 추가 sub-image
		// 2. 일반 이미지인 경우 sub이미지에 추가
		let mainImage = $("#main-image");
		let subImage = $("#sub-image ul");
		$(fileList).each(function(i, obj) {
			let fileCallPath = encodeURIComponent(obj.path+"/"+obj.uuid +"_" +obj.fileName);
			if(obj.main){
				let str = "<img src='/shoppingmall/display?fileName="+fileCallPath+"' style='width:100%;height:100%'>";
				mainImage.append(str);
			}else{
				let str ="";
				str += "<li>";
				str += "<img src='/shoppingmall/display?fileName="+fileCallPath+"'style='width:100px;height:100%'>";
				str += "</li>";
				subImage.append(str);
			}
		});
	};
</script>
<%@include file="../includes/footer.jsp" %>