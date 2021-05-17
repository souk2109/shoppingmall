<%@include file="../includes/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<sec:authentication property="principal" var="loginUser"/>
<style>
	.star{
		padding: 0px;
	}
	
	.uploadResult ul{
		border: 1px solid;
	    height: 130px;
	    display: flex;
	    flex-flow: row;
	    justify-content: center;
	    align-items: center;
	    margin-top: 20px
	}
</style>
<div class="container" align="center">
	<div class="row" style="margin-bottom: 30px" align="left">
		<div class="col-12"><font size="30px" style="margin-left: 5px">상품 리뷰</font></div>
	</div>
	<div class="row col-md-10 col-sm-12" style="margin-bottom: 30px;padding: 0px;">
		<div class="col-12" align="left" style="border-bottom: 1px solid #ddd;">
			<div class="col">
				<h4>상품 리뷰</h4>
			</div>
			<div class="col" style="margin-bottom: 20px;">
				<h5>이 상품의 품질에 대해서 얼마나 만족하시나요?</h5>
			</div>
		</div>
		<div class="col-12" align="left" style="border-bottom:1px solid #ddd;margin-bottom: 20px">
			<div class="col" style="display: table;">
				<div style="display: table-cell;width: 140px;padding: 10px" id="prdImg" align="center" data-pno="${trHistoryVO.pno }"></div>
				<div style="display: table-cell;vertical-align: middle;">
					<div>
						<span>${trHistoryVO.productName },</span>
						<span>${trHistoryVO.count }개</span>
					</div>
					<div id="starContainer" data-grade>
						<i class="fas fa-star fa-2x star btn" style="color: gray; background-color: white;padding: 0px;" data-star="1"></i>
						<i class="fas fa-star fa-2x star btn" style="color: gray; background-color: white;padding: 0px;" data-star="2"></i>
						<i class="fas fa-star fa-2x star btn" style="color: gray; background-color: white;padding: 0px;" data-star="3"></i>
						<i class="fas fa-star fa-2x star btn" style="color: gray; background-color: white;padding: 0px;" data-star="4"></i>
						<i class="fas fa-star fa-2x star btn" style="color: gray; background-color: white;padding: 0px;" data-star="5"></i>
					</div>
				</div>
			</div>
		</div>
		<div class="col-12" align="left" style="border-bottom:1px solid #ddd;display: table;margin-bottom: 20px">
			<div class="col" style="display: table-cell;vertical-align: top;width: 30%;padding: 10px">
				<h4>리뷰</h4>
			</div>
			<c:forEach items="${questionList }" var="questionVO">
				<div class="col" style="vertical-align: top;padding: 10px">
					<div>${questionVO.question }</div>
					<c:forEach items="${questionVO.itemList }" var="itemVO">
						<div style="margin-left: 5px">
							<!-- 첫번째 질문 항목인 경우 -->
							<c:choose>
								<c:when test="${questionVO.qno eq questionList[0].qno}">
									<input type="radio" name="firstItem" value="${itemVO.ino }">
									<span>${itemVO.item }</span>
								</c:when>
								<c:otherwise>
									<input type="radio" name="secondItem" value="${itemVO.ino }">
									<span>${itemVO.item }</span>
								</c:otherwise>
							</c:choose>
						</div>
					</c:forEach>
				</div>
			</c:forEach>
		</div>
		<div class="col-12" align="left" style="border-bottom:1px solid #ddd;display: table;margin-bottom: 20px">
			<div class="col" style="display: table-cell;vertical-align: top;width: 30%;padding: 10px">
				<h4>상세리뷰</h4>
			</div>
			<div class="col" style="display: table-cell;vertical-align: top;padding: 10px">
				<textarea class="form-control" rows="5" placeholder="솔직한 리뷰를 남겨주세요." style="resize: none;"></textarea>
			</div>
		</div>
		<div class="col-12" align="left" style="border-bottom:1px solid #ddd;display: table;margin-bottom: 20px">
			<div class="col" style="display: table-cell;vertical-align: top;width: 30%;padding: 10px">
				<h4>사진첨부</h4>
			</div>
			<div class="col" style="display: table-cell;vertical-align: top;padding: 10px">
				<div>
					<input id="attachFile" name="attachFile" type="file" multiple="multiple" class="form-control">
				</div>
				<div>
					<div id="uploadResult" class="uploadResult" align="center">
						<ul style="border-color: #ccc">
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div class="col-12" align="left" style="border-bottom:1px solid #ddd;display: table;margin-bottom: 20px">
			<div class="col" style="display: table-cell;vertical-align: top;width: 50%;padding: 10px">
				<input id="cancelBtn" class="btn" type="button" style="width:100%; background: #FFFFFF;color:#000000;border: 1px solid #ccc;" value="취소하기">
			</div>
			<div class="col" style="display: table-cell;vertical-align: top;width: 50%;padding: 10px">
				<input class="btn" type="button" style="width:100%; background:#69EEA8;color: #fff;" value="등록하기">
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		let validateCheck = "<c:out value='${validateCheck }'/>";
		console.log(validateCheck);
		if(validateCheck === 'false'){
			alert('구매한 상품만 리뷰가 가능합니다.');
			window.location.href = "/shoppingmall/member/orderInfo";
		}
	});
</script>
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
		let str = "<img src='/shoppingmall/display?fileName="+fileCallPath+"' style='height: 100px;'>";
		$("#prdImg").append(str);
	});
}
$(".star").on("click", function() {
	console.log("클릭함");
	let _num = $(this).data("star");
	let num = parseInt(_num);
	$("#starContainer").data("grade","232");
	$(".star").each(function(i, obj) {
		let now_star = parseInt($(obj).data("star"));
		console.log(now_star);			
		if(now_star <= num){
			$(obj).attr("style","color:yellow;background-color:white;padding: 0px;");
			console.log(num + "보다 작다");			
		}else{
			$(obj).attr("style","color:gray;background-color:white;padding: 0px;");
		}
	});
});
$("#cancelBtn").on("click", function() {
	window.location.href="/shoppingmall/member/orderInfo";
});
</script>

<!-- 첨부 사진관련 스크립트 -->
<script>
	
</script>
<%@include file="../includes/footer.jsp"%>
