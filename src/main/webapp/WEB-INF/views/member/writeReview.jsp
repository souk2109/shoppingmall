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
	    height: 200px;
	    /* display: flex; */
	    flex-flow: row;
	    justify-content: center;
	    align-items: center;
	    margin-top: 20px;
	    overflow: scroll;
	}
	.uploadResult ul li{
		margin: 10px;
		list-style: none;
		padding: 10px;
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
					<div class="col-12">
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
		
		<form action="/shoppingmall/member/registerReview" method="post" id="registerForm" class="col-12">
			<div class="col-12" align="left" style="border-bottom:1px solid #ddd;display: table;margin-bottom: 20px">
				<div class="col" style="display: table-cell;vertical-align: top;width: 30%;padding: 10px">
					<h4>리뷰</h4>
				</div>
				<c:forEach items="${questionList }" var="questionVO">
					<div class="col" style="vertical-align: top;padding: 10px">
						<div style="font-weight: bold;">${questionVO.question }</div>
						<c:forEach items="${questionVO.itemList }" var="itemVO">
							<div style="margin-left: 5px;margin-bottom: 4px">
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
					<textarea class="form-control" name="review" form="registerForm" rows="5" placeholder="솔직한 리뷰를 남겨주세요." style="resize: none;"></textarea>
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
					<input id="registerBtn" class="btn" type="submit" style="width:100%; background:#69EEA8;color: #fff;" value="등록하기">
				</div>
			</div>
			<input type="hidden" name="pno" value="${trHistoryVO.pno }">
			<input type="hidden" name="orderNum" value="${trHistoryVO.orderNum }">
			<input type="hidden" name="id" value="${loginUser.username }">
		</form>
	</div>
</div>
<script type="text/javascript" src="/shoppingmall/resources/js/fileupload.js"></script>
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
const id = '<c:out value='${loginUser.username}'/>';

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
let star_num;
$(".star").on("click", function() {
	let _num = $(this).data("star");
	let num = parseInt(_num);
	star_num = num;
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
	//사진 파일 등록하기
	$("input[type='file']").change(function(e) {
		var formData = new FormData();
		var inputFile = $("input[name='attachFile']");
		var files = inputFile[0].files;
		console.log(files);
		for(var i=0; i< files.length; i++){
			if(!checkExtension(files[i].name, files[i].size)){
				if ($.browser.msie) {
					// 브라우저가 ie인 경우 초기화
					$("#attachFile").replaceWith($("#attachFile").clone(true) );
				} else {
					// 다른 브라우저인 경우 input[type=file] init.
					$("#attachFile").val("");
				}
				return false;
			}
			formData.append("attachFile", files[i]);
		}
		fileuploadService.uploadReviewImage(formData, function(result) {
			console.log(result);
			showUploadedFile(result);
		});
	});
	
	// 이미지인지 체크
	const regex = new RegExp("(.*?)\.(jpg|gif|png|jpeg|bmp)$");
	const maxSize = 5242880; // 5MB
	
	function checkExtension(fileName, fileSize) {
		if(fileSize >= maxSize){
			alert('파일 사이즈가 5MB를 초과합니다.');
			return false;
		}
		if(!regex.test(fileName)){
			alert('해당 종류의 파일은 업로드가 불가능합니다.');
			return false;
		}
		return true;
	}
	// 썸네일 보여주기
	var uploadResult =  $(".uploadResult");
	function showUploadedFile(fileList) {
		if(!fileList || fileList.length == 0){
			return;
		}
		let uploadUL = $(".uploadResult ul");
		uploadUL.html('');
		var str = '';
		$(fileList).each(function(i, obj) {
			var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid +"_" +obj.fileName);
			str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' data-main='0'>";
			str += "<div>";
			str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-circle'>";
			str += "<i class='fa fa-times'></i>";
			str += "</button><br>";
			str += "<img class='imgLi' src='/shoppingmall/reviewDisplay?fileName="+fileCallPath+"' style='width:100px;height:100px'>";
			str += "</div>";
			str += "</li>";
		});
		uploadUL.append(str);
	};
</script>
<script>
$("#registerBtn").on("click", function(e) {
	e.preventDefault();
	let str = '';
	let firstItemVal = $('input[name="firstItem"]:checked').val();
	let secondItemVal = $('input[name="secondItem"]:checked').val();
	if(!star_num){
		alert('별을 선택해주세요');
		return;
	}
	if(!firstItemVal || !secondItemVal){
		alert('모든 질문에 체크해주세요');
		return;
	}
	$(".uploadResult ul li").each(function(i, obj) {
		let jobj= $(obj);
		str += "<input type='hidden' name='attachList["+i+"].id' value='"+ id +"'>";
		str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
		str +=	"<input type='hidden' name='attachList["+i+"].path' value='"+jobj.data("path")+"'>";
		str +=	"<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
		str +=	"<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
	});
	str +=	"<input type='hidden' name='grade' value='"+star_num+"'>";
	console.log(str);
	$("#registerForm").append(str).submit();	
});
</script>
<%@include file="../includes/footer.jsp"%>
