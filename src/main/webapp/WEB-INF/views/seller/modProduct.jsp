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
					<font class="panel-title" size="20px" face="Prompt">상품 정보 수정</font>
				</div>
				
				<div class="panel-body" style="margin-top: 20px;">
					<form id="registerForm" action="/shoppingmall/seller/modifyProductInfoVO" method="post">
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
								<input id="busiName" name="busiName" type="text" class="form-control" readonly="readonly" autocomplete="off" value="${product.busiName }">
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">＊카테고리</div>
							<div class="col-sm-12">
								<select aria-label="카테고리" id="category" name="category" style="width: 100%">
									<option value="">선택</option>
									<c:choose>
										<c:when test="${'clothes' eq product.category }">
											<option value="clothes" selected="selected">패션 의류/잡화</option>
											<option value="food">식품</option>
										</c:when>
										<c:otherwise>
											<option value="clothes">패션 의류/잡화</option>
											<option value="food" selected="selected">식품</option>
										</c:otherwise>
									</c:choose>
								</select> 
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">＊상품명</div>
							<div class="col-sm-12">
								<input id="prdName" name="prdName" type="text" class="form-control" autocomplete="off" value="${product.prdName }" placeholder="상품명">
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">＊재고</div>
							<div class="col-sm-12">
								<input id="stock" name="stock" type="text" class="form-control" onkeypress="inNumber();" value="${product.stock }" placeholder="재고" autocomplete="off">
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">＊가격</div>
							<div class="col-sm-12">
								<input id="price" name="price" type="text" class="form-control" onkeypress="inNumber();" value="${product.price }" placeholder="가격"  autocomplete="off">
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">할인(%)</div>
							<div class="col-sm-12">
								<input id="discount" name="discount" type="text" class="form-control" placeholder="ex, 3.2"  autocomplete="off" value="${product.discount }">
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
									<ul>
									</ul>
									<div align="left" style="font-size: 12px; color: red">이미지를 클릭하여 대표이미지를 선택하세요</div>
								</div>
							</div>
						</div>
						
						<input type="hidden" id="pno" name="pno" value="${product.pno }">
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-12">
								<input id="registerBtn" type="submit"  value="수정하기" style="border:hidden; margin-top: 20px;font-size: 18px; height: 54px; width: 100%; background-color: green; color: white;">
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="/shoppingmall/resources/js/member.js"></script>
<script type="text/javascript" src="/shoppingmall/resources/js/fileupload.js"></script>
<script>
	const id = '<c:out value='${loginUser.username}'/>';
	let registerForm = $("#registerForm");
	// 수정하기를 눌렀을 때 
	$("#registerBtn").on("click", function(e) {
		e.preventDefault();
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
		console.log(str);
		registerForm.append(str).submit();
	});
	// 대표 사진 등록
	function mainPictureSelection() {
		$(".imgLi").on("click", function() {
			if($(this).closest("li").attr("data-main") === "1"){
				$(this).closest("li").attr("data-main", 0);
				$(this).closest("li").removeAttr("style");
			}else{
				$(".uploadResult ul li").attr("data-main",0);
				$(".uploadResult ul li").removeAttr("style");
				$(this).closest("li").attr("data-main", 1);
				$(this).closest("li").attr("style", "border : 3px solid green");
			}
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
			if(!obj.uploadPath){
				obj.uploadPath = obj.path;
				obj.image = obj.fileType;
			}
			let main = "0";
			if(obj.main){
				main = "1";
			}
			
			console.log("obj.uploadPath : " + obj.uploadPath);
			console.log("uuid:" +  obj.uuid);
			console.log("fileName : "+ obj.fileName);
			
			var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid +"_" +obj.fileName);
			console.log(fileCallPath);
			if(main === "1"){
				str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' data-main='"+main+"' style='border : 3px solid green'>";
			}else{
				str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' data-main='"+main+"'>";
			}
			str += "<div>";
			str += "<span>"+obj.fileName+"<span>";
			str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-circle'>";
			str += "<i class='fa fa-times'></i>";
			str += "</button><br>";
			str += "<img class='imgLi' src='/shoppingmall/display?fileName="+fileCallPath+"' style='width:100px;height:100px'>";
			str += "</div>";
			str += "</li>";
		});
		uploadUL.append(str);
		mainPictureSelection();
	};
	
	// 썸네일 사진 삭제하기
	$(".uploadResult").on("click", "button", function() {
			let targetFile = $(this).data("file");
			let type = $(this).data("type");
			let targetLi = $(this).closest("li");
			
			targetLi.remove();
			
		});
	
	
	startDisplay()
	// 화면에 들어오자마자 등록된 썸네일을 보여준다.
	function startDisplay() {
		let pno = $("#pno").val();
		fileuploadService.getProductImages(pno, function(list) {
			console.log(list);
			showUploadedFile(list);
		});
	}
</script>

<script>
	function inNumber(){
	    if(event.keyCode<48 || event.keyCode>57){
	       event.returnValue=false;
	    }
	}
</script>
<%@include file="../includes/footer.jsp" %>