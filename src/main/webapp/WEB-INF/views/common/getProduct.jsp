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
	.countBtn{
		position: relative; 
		height: 25px; 
		width: 25px; 
		display: block;
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
					<div class="prd-info-container" style="border-top:1px solid #ccc;margin-top: 20px">
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
						<del style="color: #888;" id="originPrice"></del><span>원</span>
						<div>
							<div id="discountedPrice" style="font-size: 20px;display: inline;"></div>
							<span>원</span>
						</div>
					</div>
					<div style="display: inline-block;">
						<span>수량 (잔여: ${product.stock }개)</span>
						<div style="display: table;margin-top: 10px;width: 80px">
							<input id="numInput" type="text" value="1" class="prd-quantity-input" maxlength="4" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
							<div style="display: table-cell; vertical-align: top;">
								<button id="plusBtn" class="countBtn">+</button>
								<button id="minusBtn" class="countBtn">-</button>
							</div>
						</div>
					</div>
					<div style="border-top: 1px solid #ccc; margin-top: 20px;width: 100%">
						<span>가격</span>
						<div style="width: 100%">
							<div id="totalPrice" style="height: 41.6px; font-size: 25px; display: inline;"></div>
							<span>원</span>
						</div>
					</div>
					<div style="margin-top: 20px">
						<c:choose>
							<c:when test="${product.stock eq 0}">
								<input class="btn prd-buy-info" style="width:100%;color: #346AFF;margin-top: 10px;"readonly="readonly" disabled="disabled" value="품절"/>
							</c:when>
							<c:otherwise>
								<button id="basketBtn" class="prd-buy-info" style="width:100%;color: #346AFF;margin-top: 10px;">장바구니 담기</button>
								<button id="directBtn" class="prd-buy-info" style="width:100%; background: #346aff;color: #fff;margin-top: 10px"> 구매하기 </button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="/shoppingmall/resources/js/common.js"></script>
<script type="text/javascript" src="/shoppingmall/resources/js/fileupload.js"></script>
<script>
	const pno = "<c:out value='${product.pno }'/>";
	const sellerId = "<c:out value='${product.sellerId }'/>";
	const sellerName = "<c:out value='${product.sellerName }'/>";
	const busiName = "<c:out value='${product.busiName }'/>";
	const category = "<c:out value='${product.category }'/>";
	const prdName = "<c:out value='${product.prdName }'/>";
	const discount = "<c:out value='${product.discount }'/>"; // 할인율
	const price = "<c:out value='${product.price }'/>"; // 원가
	const stock = "<c:out value='${product.stock }'/>"; // 재고 수
	const discountedPrice = makeFloorPrice( parseInt(price) * (1 - parseInt(discount)/100));
	// 수량 증가
	$("#plusBtn").on("click", function() {
		let num = $("#numInput").val();
		if(num ===  stock){
			return;
		}
		let increasedNum = parseInt(num)+1;
		$("#numInput").val(increasedNum);
		let totalMoney = discountedPrice * increasedNum;
		totalMoney = makeComma(totalMoney);
		$("#totalPrice").html(totalMoney);
	});
	// 수량 감소
	$("#minusBtn").on("click", function() {
		let num = $("#numInput").val();
		if(num > 1){
			let decreasedNum = parseInt(num)-1;
			$("#numInput").val(decreasedNum);
			let totalMoney = discountedPrice * decreasedNum;
			totalMoney = makeComma(totalMoney);
			$("#totalPrice").html(totalMoney);
		}
	});
	
	// 시작하자마자 화면에 상품 가격(원가, 할인가 등)채움
	function fillProductPrice() {
		$("#totalPrice").html(makeComma(discountedPrice));
		$("#discountedPrice").html(makeComma(discountedPrice));
		$("#originPrice").html(makeComma(price));
	}
	fillProductPrice();
	
	// 직접 수량을 입력한 경우
	$("#numInput").on("keyup change paste", function() {
		if(parseInt($(this).val()) > parseInt(stock)){
			$(this).val(stock);
		}
		if($(this).val() === "0"){
			$(this).val("1");
		}
		let totalMoney = $(this).val() * discountedPrice;
		totalMoney = makeComma(totalMoney);
		$("#totalPrice").html(totalMoney);
	});
	
	// 숫자에 콤마 표시 함수(정규식 이용)
	function makeComma(num) {
		num = num.toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
		return num;
	}
	// 1의 자리에서 올림
	function makeFloorPrice(num) {
		num = Number(num);
		let result = Math.floor(num/10)*10;
		return result;
	}
</script>

<!--  사진 보여주기  -->
<script>
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
<!-- 장바구니 담기 버튼을 눌렀을 때  ajax통신으로 쿠키 생성 및 등록-->
<script>
	$("#basketBtn").on("click", function() {
		let basketInfo = {
			pno : pno,
			sellerId : sellerId,
			sellerName : sellerName,
			busiName : busiName,
			category : category,
			prdName : prdName,
			count : $("#numInput").val(),
			price : price,
			discount : discount
		};
		console.log(basketInfo);
		commonService.addBasket(basketInfo, function() {
			alert("장바구니에 추가하였습니다");	
		});  
	});
	$("#directBtn").on("click", function() {
		let count = $("#numInput").val();
		console.log(discountedPrice);
		window.location.href = "/shoppingmall/member/directPayment?pno="+pno+"&count="+count;
	})
</script>
<%@include file="../includes/footer.jsp" %>