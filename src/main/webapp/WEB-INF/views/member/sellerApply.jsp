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
	<div align="left" class="row">
		<div class="col-12 title-font" style="margin-bottom: 30px">
			판매자 신청
		</div>
	</div>
	<div class="row">
		<div class="col-md-6" style="margin: 0 auto;">
			<div class="panel-default">
				<div class="panel-body" style="margin-top: 20px;">
					<form id="registerForm" action="/shoppingmall/member/doSellerApply" method="post" enctype="multipart/form-data">
						<div class="form-group" align="left">
							<div class="col-sm-12">＊이름</div>
							<div class="col-sm-12">
								<input id="name" name="name" type="text" class="form-control" readonly="readonly" value="${loginUser.name }">
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">＊판매자 아이디</div>
							<div class="col-sm-12">
								<input id="id" name="id" type="text" class="form-control" readonly="readonly" value="${loginUser.username }">
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">＊상호명</div>
							<div class="col-sm-12">
								<input id="busiName" name="busiName" type="text" class="form-control" autocomplete="off">
							</div>
						</div>
						<!--  이부분 사진으로  -->
						<div class="form-group" align="left">
							<div class="col-sm-12">＊사업자 등록증 첨부</div>
							<div class="col-sm-12">
								<input id="attachFile" name="attachFile" type="file" class="form-control">
							</div>
						</div>
						<div class="form-group">
							<div class="col-sm-12">
								<div id="uploadResult" class="uploadResult" align="center">
									<ul></ul>
								</div>
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">＊카드 번호</div>
							<div class="col-sm-12">
								<input id="cardNum" name="cardNum" type="text" class="form-control" placeholder="카드번호 12자리" maxlength="12"  autocomplete="off" onkeypress="inNumber();">
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">＊은행명</div>
							<div class="col-sm-12">
								<select aria-label="은행" id="bankName" name="bankName" style="width: 100%">
									<option value="">은행</option>
									<option value="하나">하나</option>
									<option value="국민">국민</option>
									<option value="기업">기업</option>
									<option value="농협">농협</option>
								</select> 
							</div>
						</div>
						
						<div class="form-group" align="left">
							<div class="col-sm-12">＊유효기간</div>
							<div class="col-sm-12" style="padding-left: 15px; padding-right: 15px;margin: 0 auto;">
								<div align="center" style="height: 45px; font-family: 'Nunito Sans', sans-serif">
									<input id="validateMonth" name="validateMonth" maxlength="2" type="text"  placeholder="월" autocomplete="off" style="width: 32%" onkeypress="inNumber();">
									<input id="validateYear" name="validateYear" maxlength="4" type="text"  placeholder="년" autocomplete="off" style="width: 32%" onkeypress="inNumber();">
									<input id="cvc" name="cvc" maxlength="3" type="password"  placeholder="cvc" autocomplete="off" style="width: 32%" onkeypress="inNumber();">
								</div>
								<div>예) 12 2025 123</div>
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">＊카드 비밀번호</div>
							<div class="col-sm-12">
								<input id="pwd" maxlength="4" name="pwd" type="password" class="form-control" placeholder="숫자 4자리" autocomplete="off" onkeypress="inNumber();">
							</div>
						</div>
						<div class="form-group" align="left">
							<div class="col-sm-12">＊이메일</div>
							<div class="col-sm-12">
								<input id="email" name="email" type="email" class="form-control" readonly="readonly" value="${loginUser.email }">
							</div>
						</div>
						
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-12">
								<input id="registerBtn" type="submit"  value="신청하기" style="border:hidden; margin-top: 20px;font-size: 18px; height: 54px; width: 100%; background-color: green; color: white;">
							</div>
						</div>
						<sec:csrfInput/>
						<div id="addInput"></div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="/shoppingmall/resources/js/member.js"></script>
<script>
	$("#registerBtn").on("click", function(e) {
		e.preventDefault();
		
		let id = $("#id").val().trim();
		let busiName = $("#busiName").val().trim();
		
		let name = $("#name").val().trim();
		let cardNum = $("#cardNum").val().trim();
		let bankName = $("#bankName").val().trim();
		let validateMonth = $("#validateMonth").val().trim();
		let validateYear = $("#validateYear").val().trim();
		let cvc = $("#cvc").val().trim();
		let pwd = $("#pwd").val().trim();
		
		if(!name || !cardNum || !bankName || !validateMonth || !validateYear || !cvc || !pwd || !busiName){
			alert('모두 작성해주세요');
			return;
		}
		else if(cardNum.length !== 12){
			alert('카드번호 12자리를 입력해주세요.');
			return;
		}
		else if(validateMonth.length !== 2){
			alert('달을 2자리로 입력해주세요.(ex, 02)');
			return;
		}
		else if(validateYear.length !== 4){
			alert('년도 4자리를 입력해주세요.');
			return;
		} 
		else if(cvc.length !== 3){
			alert('cvc 3자리를 입력해주세요.');
			return;
		} 
		else if(pwd.length !== 4){
			alert('카드 비밀번호 4자리를 입력해주세요.');
			return;
		}
		else{
			memberService.getRecentSellerRequest(id, function(SellerRequest) {
				if(!SellerRequest){ //  마지막으로 요청한 정보가 없는 경우 (신규 신청)
					alert('정상적으로 요청 되었습니다.');
					$("#registerForm").submit();
					return;
				}else{ // 이미 처리중, 거절, 승인 중  한 가지의 상태를 가진 경우
					let status = SellerRequest.status;
					if(status === '처리중'){
						alert('처리 중인 상태입니다.');
						return;
					}
					else if(status === '거절'){
						alert('정상적으로 요청 되었습니다.');
						$("#registerForm").submit();
						return;
					}else if(status === '승인'){
						alert('이미 승인된 상태입니다.');
						return;
					}
				}
			});
		}
	});
	
	function inNumber(){
	    if(event.keyCode<48 || event.keyCode>57){
	       event.returnValue=false;
	    }
	}
</script>
<!-- 첨부 이미지 관련 코드 -->
<script type="text/javascript" src="/shoppingmall/resources/js/fileupload.js"></script>
<script>
//사진 파일 등록하기
$("input[type='file']").change(function(e) {
	var formData = new FormData();
	var inputFile = $("input[name='attachFile']");
	var files = inputFile[0].files;
	console.log('name : '+files[0].name);
	
	if(!checkExtension(files[0].name, files[0].size)){
		if ($.browser.msie) {
			// 브라우저가 ie인 경우 초기화
			$("#attachFile").replaceWith($("#attachFile").clone(true) );
		} else {
			// 다른 브라우저인 경우 input[type=file] init.
			$("#attachFile").val("");
		}
		return false;
	}
	formData.append("attachFile", files[0]);
	fileuploadService.uploadBuisnessImage(formData, function(result) {
		console.log(result);
		showUploadedFile(result);
	});
});
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

//썸네일 보여주기
var uploadResult =  $(".uploadResult");
function showUploadedFile(fileList) {
	if(!fileList || fileList.length == 0){
		return;
	}
	let uploadUL = $(".uploadResult ul");
	uploadUL.html('');
	let str = '';
	$(fileList).each(function(i, obj) {
		var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid +"_" +obj.fileName);
		str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' data-main='0'>";
		str += "<div>";
		str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-circle'>";
		str += "<i class='fa fa-times'></i>";
		str += "</button><br>";
		str += "<img class='imgLi' src='/shoppingmall/buisnessDisplay?fileName="+fileCallPath+"' style='width:130px;height:130px'>";
		str += "</div>";
		str += "</li>";
		
		$("#addInput").html('');
		let inputStr = '';
		let id = $("#id").val();
		inputStr += "<input type='hidden' name='sellerAttachVO.id' value='"+ id +"'>";
		inputStr += "<input type='hidden' name='sellerAttachVO.fileName' value='"+obj.fileName+"'>";
		inputStr += "<input type='hidden' name='sellerAttachVO.uuid' value='"+obj.uuid+"'>";
		inputStr += "<input type='hidden' name='sellerAttachVO.path' value='"+obj.uploadPath+"'>";
		inputStr += "<input type='hidden' name='sellerAttachVO.fileType' value='"+obj.image+"'>";
		$("#addInput").append(inputStr);
	});
	uploadUL.append(str);
};

//썸네일 사진 삭제하기
$(".uploadResult").on("click", "button", function() {
	var targetFile = $(this).data("file");
	var type = $(this).data("type");
	var targetLi = $(this).closest("li");
	fileuploadService.deleteProductImage(targetFile, type, function(result) {
		console.log("삭제 완료");
		targetLi.remove();
		$("#addInput").html('');
	});
});
</script>
<%@include file="../includes/footer.jsp" %>