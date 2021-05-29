<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link href="https://fonts.googleapis.com/css2?family=Prompt:wght@600&display=swap" rel="stylesheet">
<sec:authentication property="principal" var="loginUser"/>
<style>
	.uploadResult ul{
		border: 1px solid;
		height:200px;
		display: flex;
		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	.uploadResult ul li{
		list-style: none;
		padding: 10px;
	}
	.uploadResult ul li image{
		width: 20px;
	}
</style>
<div class="container" align="center">
	<div class="row">
		<div class="col-md-6" style="margin: 0 auto;">
			<div class="panel-default">
				<div align="center">
					<font class="panel-title" size="20px" face="Prompt">상품 등록</font>
				</div>
				
				<div class="panel-body" style="margin-top: 20px;">
					<form id="registerForm" action="/shoppingmall/seller/doRegisteProduct" method="post" enctype="multipart/form-data">
						<div class="form-group" align="left">
							<div class="col-sm-12">＊이름</div>
							<div class="col-sm-12">
								<input id="sellerName" name="sellerName" type="text" class="form-control" readonly="readonly" value="${loginUser.name }">
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">＊판매자 아이디</div>
							<div class="col-sm-12">
								<input id="sellerId" name="sellerId" type="text" class="form-control" readonly="readonly" value="${loginUser.username }">
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">＊상호명</div>
							<div class="col-sm-12">
								<input id="busiName" name="busiName" type="text" class="form-control" readonly="readonly" autocomplete="off" value="${seller.busiName }">
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">＊카테고리</div>
							<div class="col-sm-12">
								<select aria-label="카테고리" id="category" name="category" style="width: 100%">
									<option value="">선택</option>
									<option value="beauty">뷰티</option>
									<option value="life">생활용품</option>
									<option value="food">식품</option>
									<option value="clothes">패션 의류/잡화</option>
								</select> 
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">＊상품명</div>
							<div class="col-sm-12">
								<input id="prdName" name="prdName" type="text" class="form-control" placeholder="상품명"  autocomplete="off">
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">＊재고</div>
							<div class="col-sm-12">
								<input id="stock" name="stock" type="text" class="form-control" onkeypress="inNumber();" placeholder="수량"  autocomplete="off">
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">＊가격</div>
							<div class="col-sm-12">
								<input id="price" name="price" type="text" class="form-control" onkeypress="inNumber();" placeholder="가격"  autocomplete="off">
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">할인(%)</div>
							<div class="col-sm-12">
								<input id="discount" name="discount" type="text" class="form-control" placeholder="ex, 3.2"  autocomplete="off">
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">파일첨부</div>
							<div class="col-sm-12">
								<input id="attachFile" name="attachFile" type="file" multiple="multiple" class="form-control">
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-12">
								<div id="uploadResult" class="uploadResult" align="center">
									<ul></ul>
									<div align="left" style="font-size: 12px; color: red">이미지를 클릭하여 대표이미지를 선택하세요</div>
								</div>
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12" style="margin-bottom: 20px">
								<div style="margin-bottom: 5px">
									<span>리뷰 설문조사 질문1</span>
									<input id="q1" name="question1" type='text' class='form-control' placeholder='질문을 작성하세요'  autocomplete='off'>
								</div>
								<div style="display: table;margin-bottom: 5px">
									<div style="display: table-cell;">
										답변항목1
									</div>
									<div style="display: table-cell;padding-left: 10px">
										<input id="q1firstItem" name="firstItems" type='text' class='form-control' placeholder='답변을 입력하세요'  autocomplete='off' style='margin-bottom:10px;width: 210px'>
									</div>
								</div>
								<div style="display: table;margin-bottom: 5px">
									<div style="display: table-cell;">
										답변항목2
									</div>
									<div style="display: table-cell;padding-left: 10px">
										<input id="q1secondItem" name="firstItems" type='text' class='form-control' placeholder='답변을 입력하세요'  autocomplete='off' style='margin-bottom:10px;width: 210px'>
									</div>
								</div>
								<div style="display: table;margin-bottom: 5px">
									<div style="display: table-cell;">
										답변항목3
									</div>
									<div style="display: table-cell;padding-left: 10px">
										<input id="q1thirdItem" name="firstItems" type='text' class='form-control' placeholder='답변을 입력하세요'  autocomplete='off' style='margin-bottom:10px;width: 210px'>
									</div>
								</div>
							</div>
							<div class="col-sm-12">
								<div style="margin-bottom: 5px">
									<span>리뷰 설문조사 질문2</span>
									<input id="q2" name="question2" type='text' class='form-control' placeholder='질문을 작성하세요'  autocomplete='off'>
								</div>
								<div style="display: table;margin-bottom: 5px">
									<div style="display: table-cell;">
										답변항목1
									</div>
									<div style="display: table-cell;padding-left: 10px">
										<input id="q2firstItem" name="secondItems" type='text' class='form-control' placeholder='답변을 입력하세요'  autocomplete='off' style='margin-bottom:10px;width: 210px'>
									</div>
								</div>
								<div style="display: table;margin-bottom: 5px">
									<div style="display: table-cell;">
										답변항목2
									</div>
									<div style="display: table-cell;padding-left: 10px">
										<input id="q2secondItem" name="secondItems" type='text' class='form-control' placeholder='답변을 입력하세요'  autocomplete='off' style='margin-bottom:10px;width: 210px'>
									</div>
								</div>
								<div style="display: table;margin-bottom: 5px">
									<div style="display: table-cell;">
										답변항목3
									</div>
									<div style="display: table-cell;padding-left: 10px">
										<input id="q2thirdItem" name="secondItems" type='text' class='form-control' placeholder='답변을 입력하세요'  autocomplete='off' style='margin-bottom:10px;width: 210px'>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-12">
								<input id="registerBtn" type="submit"  value="등록하기" style="border:hidden; margin-top: 20px;font-size: 18px; height: 54px; width: 100%; background-color: green; color: white;">
							</div>
						</div>
						<sec:csrfInput/>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="/shoppingmall/resources/js/member.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.js"></script>
<script type="text/javascript" src="/shoppingmall/resources/js/fileupload.js"></script>
<script>
	let mainImgCheck = false;
	const id = '<c:out value='${loginUser.username}'/>';
	
	let registerForm = $("#registerForm");
	$("#registerBtn").on("click", function(e) {
		e.preventDefault();
		// 모든 항목을 작성했는지 확인하기 
		let categoryVal = $("#category").val();
		if(!categoryVal){
			alert('카테고리를 선택해주세요');
			return;
		}
		 
		let prdNameVal = $("#prdName").val().trim();
		if(!prdNameVal){
			alert('상품명을 입력해주세요');
			return;
		}
		
		let stockVal = $("#stock").val().trim();
		if(!stockVal){
			alert('재고를 입력해주세요');
			return;
		}
		
		let priceVal = $("#price").val().trim();
		if(!priceVal){
			alert('가격을 입력해주세요');
			return;
		}
		
		let discount = $("#discount").val().trim();
		if(!discount){
			alert('할인율을 입력해주세요(0%이면 0을 작성해주세요)');
			return;
		}else{
			if(parseFloat(discount) >= 100){
				alert('할인율은 100보다 작은 수로 입력해주세요');
				return;
			}
		}
		 
		if(!mainImgCheck){
			alert('대표 이미지를 선택해주세요!');
			return;
		}
		let q1 = $("#q1").val().trim();
		let q1firstItem = $("#q1firstItem").val().trim();
		let q1secondItem = $("#q1secondItem").val().trim();
		let q1thirdItem = $("#q1thirdItem").val().trim();
		
		let q2 = $("#q2").val().trim();
		let q2firstItem = $("#q2firstItem").val().trim();
		let q2secondItem = $("#q2secondItem").val().trim();
		let q2thirdItem = $("#q2thirdItem").val().trim();
		if(!q1 || !q1firstItem || !q1secondItem || !q1thirdItem || 
			!q2 || !q2firstItem || !q2secondItem || !q2thirdItem){
			alert('설문 질문과 항목을 모두 입력해주세요')
			return;
		}
		let str = '';
		$(".uploadResult ul li").each(function(i, obj) {
			let jobj= $(obj);
			str += "<input type='hidden' name='attachList["+i+"].id' value='"+ id +"'>";
			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str +=	"<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str +=	"<input type='hidden' name='attachList["+i+"].path' value='"+jobj.data("path")+"'>";
			str +=	"<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
			str +=	"<input type='hidden' name='attachList["+i+"].main' value='"+jobj.data("main")+"'>";
		});
		registerForm.append(str).submit();
	});
	
	function mainPictureSelection() {
		$(".imgLi").on("click", function() {
			$(".uploadResult ul li").attr("data-main",0);
			$(".uploadResult ul li").removeAttr("style");
			$(this).closest("li").attr("data-main", 1);
			$(this).closest("li").attr("style", "border : 3px solid green");
			mainImgCheck = true;
		});
	}
	
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
	// 사진 파일 등록하기
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
		fileuploadService.uploadProductImage(formData, function(result) {
			console.log(result);
			showUploadedFile(result);
		});
	});
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
			str += "<img class='imgLi' src='/shoppingmall/display?fileName="+fileCallPath+"' style='width:100px;height:100px'>";
			str += "</div>";
			str += "</li>";
		});
		uploadUL.append(str);
		mainPictureSelection()
	};
	
	// 썸네일 사진 삭제하기
	$(".uploadResult").on("click", "button", function() {
			var targetFile = $(this).data("file");
			var type = $(this).data("type");
			var targetLi = $(this).closest("li");
			fileuploadService.deleteProductImage(targetFile, type, function(result) {
				console.log("삭제 완료");
				targetLi.remove();
			});
		});
</script>

<script>
	function inNumber(){
	    if(event.keyCode<48 || event.keyCode>57){
	       event.returnValue=false;
	    }
	}
</script>
<%@include file="../includes/footer.jsp" %>