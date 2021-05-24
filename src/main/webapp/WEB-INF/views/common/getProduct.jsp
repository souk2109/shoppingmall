<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="preconnect" href="https://fonts.gstatic.com">
<!-- 반쪽 별을 위한 링크 -->
<link rel="stylesheet" href="https://forkaweso.me/Fork-Awesome/assets/fork-awesome/css/fork-awesome.css">
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

    .graph { 
        position: relative; /* IE is dumb */
        width: 30%;
        border: 1px solid #B1D632; 
        padding: 2px; 
		font-size:11px;
		font-family:tahoma;
		margin-bottom:3px;
    }
    .graph .greenBar { 
        display: block;
        position: relative;
        background: #B1D632; 
        text-align: right; 
        color: white; 
        height: 2em; 
        line-height: 2em;            
    }
    .graph .blueBar { 
        display: block;
        position: relative;
        background: #6480e4; 
        text-align: right; 
        color: white;
        height: 2em; 
        line-height: 2em;            
    }
    .graph .greenBar span { position: absolute; left: 1em; }
    .graph .blueBar span { position: absolute; left: 1em; }
    
    .prdQuestionItem{
    	padding: 5px;
    	font-size: 12px;
    }
    .main-image{
    	width: 100%; 
    	height: 60%;
    }
    @media(max-width:740px){
		.main-image{
			width: 100%; 
    		height: 30%;
		}
	}
</style>
<div class="container" style="margin-bottom: 100px">
	<div class="row" style="border-bottom: 2px solid;">
		<div class="col-md-10" style="margin: 0 auto;">
			<div class="col-12" style="margin-bottom: 20px">
				<font size="30px" style="margin-left: 5px">상세 페이지</font>
			</div>
			<div class="panel-default">
				<div class="prd-img" align="center" style="height: 500px">
					<div id="main-image" class="main-image">
					</div>
					<div class="sub-image" id="sub-image" style="width: 100%; height: 40%;margin-top: 30px">
						<ul></ul>
						<div style="color: blue;font-size: 13px">이미지를 클릭하여 자세히 확인하세요!</div>
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
						<c:if test="${product.discount > 0 }">
							<div class="prd-info-category">${product.discount }%</div>
							<del style="color: #888;" id="originPrice"></del><span>원</span>
						</c:if>
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
								<button id="basketBtn" class="prd-buy-info" style="width:100%;color: #346AFF;margin-top: 10px;"><i class="fa fa-heart" aria-hidden="true"></i> 장바구니 담기</button>
								<button id="directBtn" class="prd-buy-info" style="width:100%; background: #346aff;color: #fff;margin-top: 10px"> 구매하기 </button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="row" style="margin-top: 20px;border-bottom: 1px solid #ddd;">
		<div class="col-md-10" style="margin: 0 auto;">
			<div class="col-12" style="margin-bottom: 20px">
				<h2>상품평</h2>
			</div>
			<div class="row" style="margin-bottom: 20px">
				<c:forEach items="${productQuestionList}" var="productQuestion" varStatus="status">
					<div class="col-md-6 col-sm-12">
						<h5>${productQuestion.question}</h5>
						<ul style="list-style: none;">
							<li style="width: 100%">
								<div id="firstItem${status.index }" class="graph" style="display: inline-block;">
								</div>
								<div style="display: inline-block;width: 60%">
									<span class="prdQuestionItem">${productQuestion.itemList[0].item}</span>
								</div>
							</li>
							<li style="width: 100%">
								<div id="secondItem${status.index }" class="graph" style="display: inline-block;">
								</div>
								<div style="display: inline-block;width: 60%">
									<span class="prdQuestionItem">${productQuestion.itemList[1].item}</span>
								</div>
							</li>
							<li style="width: 100%">
								<div id="thirdItem${status.index }" class="graph" style="display: inline-block;">
								</div>
								<div style="display: inline-block;width: 60%">
									<span class="prdQuestionItem">${productQuestion.itemList[2].item}</span>
								</div>
							</li>
						</ul>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<div class="row" style="margin-top: 20px;border-bottom: 1px solid #ddd;">
		<div class="col-md-10" style="margin: 0 auto;">
			<div class="col-12" style="margin-bottom: 20px">
				<h2 style="display: inline;margin-right: 5px">리뷰(${product.reviewNum })</h2>
				<span id="reviewAvgGrade"></span>
			</div>
			<div>
				<span>정렬</span>
				<select id="sortSelectbox">
					<option value="recentRegdateSort">최근 등록일순</option>
					<option value="lowGradeSort">별점 낮은순</option> 
					<option value="highGradeSort">별점 높은순</option>
				</select>
			</div>
			<div id="reviewContainer">
			</div>
		</div>
	</div>
</div>
<div class="fade modal" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content" align="center" style="text-align: center;">
			<div class="modal-header">
				<span>첨부 이미지</span>
				<span id="cancelBtn" style="float: right;"><i class="fa fa-times" aria-hidden="true"></i></span>
			</div>
			<div class="modal-body">
				<div id="modal-image"></div>
			</div>
			<div class="modal-footer"></div>
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

<!--  상품 사진 보여주기  -->
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
				str += "<li class='fileName' data-fileName=" + fileCallPath +">";
				str += "<img src='/shoppingmall/display?fileName="+fileCallPath+"' style='width:100px;height:100%'>";
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
		commonService.addBasket(basketInfo, function() {
			alert("장바구니에 추가하였습니다");	
		});  
	});
	$("#directBtn").on("click", function() {
		let count = $("#numInput").val();
		window.location.href = "/shoppingmall/member/directPayment?pno="+pno+"&count="+count;
	})
</script>
<!-- 상품평 관련 javascript -->
<script>
	let fQfirstItem = parseInt("<c:out value='${productQuestionList[0].itemList[0].grade}'/>");
	let fQsecondItem = parseInt("<c:out value='${productQuestionList[0].itemList[1].grade}'/>");
	let fQthirdItem = parseInt("<c:out value='${productQuestionList[0].itemList[2].grade}'/>");
	
	let sQfirstItem = parseInt("<c:out value='${productQuestionList[1].itemList[0].grade}'/>");
	let sQsecondItem = parseInt("<c:out value='${productQuestionList[1].itemList[1].grade}'/>");
	let sQthirdItem = parseInt("<c:out value='${productQuestionList[1].itemList[2].grade}'/>");
	
	
	let firstTotalGrade = fQfirstItem + fQsecondItem + fQthirdItem;
	let secondTotalGrade = sQfirstItem + sQsecondItem + sQthirdItem;
	
	// fQFI(firstQuestionfirstItem)
	let fQFIPercentage = ((fQfirstItem/firstTotalGrade)*100).toFixed(1);
	let fQSIPercentage = ((fQsecondItem/firstTotalGrade)*100).toFixed(1);
	let fQTIPercentage = ((fQthirdItem/firstTotalGrade)*100).toFixed(1);
	if(isNaN(fQFIPercentage)){
		fQFIPercentage = 0.0;
	}
	if(isNaN(fQSIPercentage)){
		fQSIPercentage = 0.0;
	}
	if(isNaN(fQTIPercentage)){
		fQTIPercentage = 0.0;
	}
	let sQFIPercentage = ((sQfirstItem/firstTotalGrade)*100).toFixed(1);
	let sQSIPercentage = ((sQsecondItem/firstTotalGrade)*100).toFixed(1);
	let sQTIPercentage = ((sQthirdItem/firstTotalGrade)*100).toFixed(1);
	if(isNaN(sQFIPercentage)){
		sQFIPercentage = 0.0;
	}
	if(isNaN(sQSIPercentage)){
		sQSIPercentage = 0.0;
	}
	if(isNaN(sQTIPercentage)){
		sQTIPercentage = 0.0;
	}
 	$("#firstItem0").append("<div class='greenBar' style='width: " + fQFIPercentage + "%;'>" + fQFIPercentage + "%</div>");
	$("#secondItem0").append("<div class='greenBar' style='width: " + fQSIPercentage + "%;'>" + fQSIPercentage + "%</div>");
	$("#thirdItem0").append("<div class='greenBar' style='width: " + fQTIPercentage + "%;'>" + fQTIPercentage + "%</div>");
	
	$("#firstItem1").append("<div class='blueBar' style='width: " + sQFIPercentage + "%;'>" + sQFIPercentage + "%</div>");
	$("#secondItem1").append("<div class='blueBar' style='width: " + sQSIPercentage + "%;'>" + sQSIPercentage + "%</div>");
	$("#thirdItem1").append("<div class='blueBar' style='width: " + sQTIPercentage + "%;'>" + sQTIPercentage + "%</div>");
</script>
<!-- 리뷰 관련 코드  -->
<script>
	function showReviewStar() {
		let totalReviewGrade = parseInt("<c:out value='${product.totalReviewGrade }'/>");
		let reviewNum =	parseInt("<c:out value='${product.reviewNum }'/>");
		let reviewAvgGrade = totalReviewGrade/reviewNum;
		if(isNaN(reviewAvgGrade)){
			reviewAvgGrade = 0;
		}
		let str = "";
		let full_star_num = Math.floor(reviewAvgGrade);
		let half_star_num = Math.round(reviewAvgGrade - full_star_num);
		let gray_star_num = 5 - full_star_num - half_star_num;
		for(var i=0;i<full_star_num; i++){
			str += "<i class='fa fa-star' style='color: #FFA500;padding:0px;font-size: 2em;'></i>";
		}
		if(half_star_num === 1){
			str += "<i class='fa fa-star-half-o' style='color: #FFA500;padding:0px;font-size: 2em;'></i>";
		}
		for(var i=0;i<gray_star_num; i++){
			str += "<i class='fa fa-star-o' style='color: #FFA500;padding:0px;font-size: 2em;'></i>";
		}
		$("#reviewAvgGrade").append(str);
	}
	showReviewStar();
	
	function showReviewImages() {
		$(".reviewImg").each(function(i, obj) {
			let rno = $(this).data("rno");
			commonService.getReviewImages(rno, function(list) {
				if(list){
					for(var i=0;i<list.length;i++){
						let fileCallPath = encodeURIComponent(list[i].path+"/" + list[i].uuid +"_" + list[i].fileName);
						let str = "<div class='reviewFileName' data-fileName=" + fileCallPath + " style='display: table-cell;width: 100px;padding:5px;border:1px solid #ccc'>";
						str += "<img src='/shoppingmall/reviewDisplay?fileName="+fileCallPath+"' style='height: 100px'>";
						str += "</div>";
						$(obj).append(str);
					}
				}
			});
		})
	}
	showReviewImages();
	
	// ajax를 통해 받아온 review list를  화면에 뿌려주는 함수
	function makeReviewLists(list) {
		$("#reviewContainer").html("");
		let str = "";
		for(var i=0; i<list.length;i++){
			str += "<div class='row' style='margin-bottom: 20px;border: 1px solid #ccc;padding-top: 10px'>";
			str += "<div class='col-12'>";
			for(var j=0;j<parseInt(list[i].grade);j++){
				str += "<i class='fa fa-star' style='color: #FFA500;padding:0px;font-size: 1.3em;'></i>";
			}
			for(var j=0;j<5-parseInt(list[i].grade);j++){
				str += "<i class='fa fa-star-o' style='color: #FFA500;padding:0px;font-size: 1.3em;'></i>";
			}
			str += "</div>";
			str += "<div class='col-12'>";
			str += "<span>" + list[i].productName + "</span>";
			str += "<span>, " + list[i].count + "개</span>";
			str += "</div>";
			str += "<div class='col-12'>";
			str += "<span>"+list[i].review+"</span>";
			str += "</div>";
			str += "<div class='col-12'>";
			let time = commonService.displayTime(list[i].regDate);
			str += "<span>" + time + "</span>";
			str += "</div>";
			str += "<div class='col-12'>"; 
			str += "<div style='display: table;margin-bottom: 10px'>";
			str += "<div class='reviewImg' data-rno=" + list[i].rno + ">";
			
			let rno = list[i].rno;
			commonService.getReviewImages(rno, function(attachList) {
				if(attachList){
					for(var k=0;k<attachList.length;k++){
						var fileCallPath = encodeURIComponent(attachList[k].path + "/" + attachList[k].uuid + "_" + attachList[k].fileName);
						str += "<div class='reviewFileName' data-fileName=" + fileCallPath + " style='display: table-cell;width: 100px;padding:5px;border:1px solid #ccc'>";
						str += "<img src='/shoppingmall/reviewDisplay?fileName="+fileCallPath+"' style='height: 100px'>";
						str += "</div>";
					}
				}
			});
			str += "</div>";
			str += "</div>";
			str += "</div>";
			str += "</div>";
		}
		$("#reviewContainer").append(str);
	}
	
	
	$("#sortSelectbox").change(function() {
		sortMethod = $(this).val();
		if(sortMethod === 'highGradeSort'){
			commonService.getReviewWithHighGrade(pno, function(list) {
				makeReviewLists(list);
			});
			return;
		}
		if(sortMethod === 'lowGradeSort'){
			commonService.getReviewWithLowGrade(pno, function(list) {
				makeReviewLists(list);
			});
			return;
		}
		if(sortMethod === 'recentRegdateSort'){
			commonService.getReviewWithRegdateDesc(pno, function(list) {
				makeReviewLists(list);
			});
			return;
		}
	});
	
	// 처음 화면에 들어오자마자 최신 등록일 순으로 리뷰를 보여준다.
	commonService.getReviewWithRegdateDesc(pno, function(list) {
		makeReviewLists(list);
	});
</script>
<script>
	function showImage(fileCallPath) {
		$("#modal-image")
			.html("<img src='/shoppingmall/display?fileName="+fileCallPath+"'>")
			.animate({width:'100%', height:'100%'}, 500);
	}
	function showReviewImage(fileCallPath) {
		$("#modal-image")
			.html("<img src='/shoppingmall/reviewDisplay?fileName="+fileCallPath+"'>")
			.animate({width:'100%', height:'100%'}, 500);
	}
	 
	$(".sub-image ul").on("click","li",function(){
		let fileName = $(this).data("filename");
		showImage(fileName.replace(new RegExp(/\\/g),"/"));
		$(".modal").modal("show");
	});
	
	$(document).on('click', ".reviewFileName", function() {
		let fileName = $(this).data("filename");
		showReviewImage(fileName.replace(new RegExp(/\\/g),"/"));
		$(".modal").modal("show");
	});
	$("#cancelBtn").on("click", function() {
		$(".modal").modal("hide");
	});
</script>
<%@include file="../includes/footer.jsp" %>