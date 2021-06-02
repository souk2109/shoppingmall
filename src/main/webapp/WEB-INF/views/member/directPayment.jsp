<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Prompt:wght@600&display=swap" rel="stylesheet">
<sec:authentication property="principal" var="loginUser"/>
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
	const pno = '<c:out value='${productInfoVO.pno}'/>'; // 상품가격
	const price = '<c:out value='${productInfoVO.price}'/>'; // 원래 가격(1개당)
	const discount = '<c:out value='${productInfoVO.discount}'/>'; // 할인
	const discountedPrice = makeFloorPrice(price * (1-discount/100)); // 할인가(1개당)
	const count = '<c:out value='${count}'/>';
	const originTotalPrice = count*price; //할인 되기전 금액의 총 합
	const discountedTotalPrice = count*discountedPrice; // 할인된 금액의 총 합
	const id = '<c:out value='${loginUser.username}'/>';
</script>
<div class="container">
	<div class="row" style="margin-bottom: 30px">
		<div class="col-12"><i class="fas fa-cash-register fa-3x"></i><font size="30px" style="margin-left: 5px">주문/결제</font></div>
	</div>
	<div class="row" style="margin-bottom: 100px">
		<div class="col-12">
			<div class="col-12" style="border-left: 6px solid #ccd;margin-bottom: 10px">구매할 상품</div>
			<div>
				<table class="table">
					<!-- 상품번호, 판매자, 판매자이름, 상호명, 카테고리, 상품명, 수량, 가격, 할인 -->
					<tr>
						<th>카테고리</th><th>상품명</th>
						<th>수량</th><th>가격</th>
						<th>판매자</th><th>상호명</th>
					</tr>
					<tr>
						<td>
							<c:choose>
								<c:when test="${productInfoVO.category eq 'food'}">식품</c:when>
								<c:when test="${productInfoVO.category eq 'beauty'}">뷰티</c:when>
								<c:when test="${productInfoVO.category eq 'clothes'}">패션의류/잡화</c:when>
								<c:when test="${productInfoVO.category eq 'life'}">생활용품</c:when>
							</c:choose>
						</td>
						<td>${productInfoVO.prdName }</td>
						<td>${count }</td>
						<td>
							<script>document.write(makeComma(discountedTotalPrice)+"원");</script>
						</td>
						<td>${productInfoVO.sellerId }</td>
						<td>${productInfoVO.busiName }</td>
					</tr>
				</table>
			</div>
			<div>
				<div class="col-12" style="border-left: 6px solid #ccd;margin-bottom: 10px;margin-top: 40px;">
					<div>총 결제 금액</div>
				</div>
				<del><script>document.write(makeComma(originTotalPrice)+"원");</script></del>
				<div><script>document.write(makeComma(discountedTotalPrice)+"원");</script></div>
			</div>
			<div>
				<div class="col-12" style="border-left: 6px solid #ccd;margin-bottom: 10px;margin-top: 40px;">
					<div style="display: inline;margin-right: 5px">배송지</div>
					<input type="checkbox" id="shipCheckbox">기본 배송지 사용
				</div>
				<div class="col-md-6 col-sm-12" style="margin-bottom: 20px">
					<div style="margin-top: 10px;margin-bottom: 10px">
						<input type="text" id="postalCode" name="postalCode" class="form-control" placeholder="우편번호" style="width: 50%;display: inline;" readonly="readonly">
						<input type="button" id="findPostalBtn" class="form-control" onclick="startDaumPostcode()" value="우편번호 검색" style="width: 45%;display: inline;float: right;">
					</div>
					<input type="text" id="roadAddress" name="roadAddress" class="form-control" placeholder="도로명주소" readonly="readonly" style="margin-bottom: 10px">
					<input type="text" id="detailAddress" name="detailAddress" class="form-control" placeholder="상세주소" autocomplete="new-password">
				</div>
			</div>
			<!--  카드 입력 -->
			<div>
				<div class="col-12" style="border-left: 6px solid #ccd;margin-bottom: 10px;margin-top: 40px;">
					<div style="display: inline;margin-right: 5px">카드 정보</div>
					<input type="checkbox" id="simpleCardCheckbox">간편카드 사용
				</div>
				<div class="col-md-6 col-sm-12" style="margin-bottom: 20px">
					<select aria-label="은행" id="bankName" name="bankName" style="width: 100%">
						<option value="">은행</option>
						<option value="하나">하나</option>
						<option value="국민">국민</option>
						<option value="기업">기업</option>
						<option value="농협">농협</option>
					</select>
				</div>
				<div class="col-md-6 col-sm-12" style="margin-bottom: 20px">
					<div style="margin-bottom: 3px">이름</div>
					<input id="name" name="name" type="text" class="form-control" 
						placeholder="이름" autocomplete="off">
				</div>
				<div class="col-md-6 col-sm-12" style="margin-bottom: 20px">
					<input id="cardNum" name="cardNum" type="text" class="form-control" 
						placeholder="카드번호 12자리" maxlength="12" autocomplete="off" onkeypress="inNumber();">
				</div>
				<div class="col-md-6 col-sm-12" style="margin-bottom: 20px">
					<div style="margin-bottom: 3px">유효기간</div>
					<div>
						<div style="height: 45px; font-family: 'Nunito Sans', sans-serif">
							<input id="validateMonth" name="validateMonth" maxlength="2" type="text" placeholder="월" autocomplete="off" style="width: 32%" onkeypress="inNumber();">
							<input id="validateYear" name="validateYear" maxlength="4" type="text" placeholder="년" autocomplete="off" style="width: 32%" onkeypress="inNumber();">
							<input id="cvc" name="cvc" maxlength="3" type="password" placeholder="cvc" autocomplete="off" style="width: 32%" onkeypress="inNumber();">
						</div>
						<div>예) 12 2025 123</div>
					</div>
				</div>
				<div class="col-md-6 col-sm-12" style="margin-bottom: 20px">
					<div style="margin-bottom: 3px">비밀번호</div>
					<input id="cardPwd" name="cardPwd" type="password" class="form-control" 
						placeholder="비밀번호 4자리" maxlength="4" autocomplete="off" onkeypress="inNumber();">
				</div>
			</div>
			<div style="margin-bottom: 10px;margin-top: 40px;">
				<div id="paymentBtn" class="btn btn-primary col-6">결제하기</div>
			</div>
		</div>
	</div>
	<form id="submitBtn" action="/shoppingmall/member/doDirectPayment" method="post">
		<sec:csrfInput/>
	</form>
</div>

<!-- 다음 우편번호 검색 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- 배송지 관련 코드 -->
<script>
	function startDaumPostcode() {
		new daum.Postcode({
		oncomplete: function(data) {
			document.getElementById("postalCode").value = data.zonecode;
			document.getElementById("roadAddress").value = data.roadAddress;
		}
		}).open();
	}
	
	$("#shipCheckbox").change(function() {
		if($("#shipCheckbox").is(":checked")){
			let autoPostalCode = "<c:out value='${loginUser.postalCode }'/>";
			if(autoPostalCode){
				let postalCode = "<c:out value='${loginUser.postalCode }'/>";
				let roadAddress = "<c:out value='${loginUser.roadAddress }'/>";
				let detailAddress = "<c:out value='${loginUser.detailAddress }'/>";
				$("#postalCode").val(postalCode);
				$("#roadAddress").val(roadAddress);
				$("#detailAddress").val(detailAddress).attr("readonly",true);
				$("#findPostalBtn").prop("disabled", true);
			}else{
				$("input:checkbox[id='shipCheckbox']").prop("checked", false);
				alert('기본으로 설정된 배송지가 없습니다');
			}
		}else{
			$("#postalCode").val("");
			$("#roadAddress").val("");
			$("#detailAddress").val("").attr("readonly",false);
			$("#findPostalBtn").prop("disabled", false);
		}
	});
</script>
<script type="text/javascript" src="/shoppingmall/resources/js/member.js"></script>
<script>
	let msg = '<c:out value='${msg}'/>';
	if(msg === 'noBalance'){
		alert('잔액이 부족하여 결제에 실패하였습니다');
	}
	else if(msg === 'noCard'){
		alert('카드 정보가 잘못되었습니다');
	}
</script>
 
<script>
	// '간편 카드 사용'을 체크했을 때 기존에 등록된 카드가 있다면 내용을 채워준다.
	$("#simpleCardCheckbox").change(function(){
	    if($("#simpleCardCheckbox").is(":checked")){
	    	// 1. 등록된 간편카드가 있는지 확인
	    	// 2. 있다면 간편카드 정보를 가져옴
	    	// 3. 없다면 등록된 카드가 없다고 출력 후 체크 해제
	    	$("#name").val("").attr("readonly",true);
	    	$("#cardNum").val("").attr("readonly",true);
			$("#validateMonth").val("").attr("readonly",true);
			$("#validateYear").val("").attr("readonly",true);
			$("#cvc").val("").attr("readonly",true);
	    	memberService.getSimpleCards(id, function(list) {
	    		console.log(list);
	    		if(list.length >0){
	    			let str = "";
	    			str += "<option value='x'>간편카드 선택</option>";
	    			for(var i=0; i<list.length; i++){
	    				str += "<option id='"+list[i].bankName+"SimpleCard' value="+ list[i].bankName 
	    						+" data-cardNum=" + list[i].cardNum+ " data-validateMonth=" 
	    						+ list[i].validateMonth + " data-validateyear=" + list[i].validateYear 
	    						+" data-cvc=" + list[i].cvc + " data-name=" + list[i].name + ">" + list[i].bankName + "</option>";
	    			}
	    			$("#bankName").html(str);
	    		}else{
	    			$("input:checkbox[id='simpleCardCheckbox']").prop("checked", false);
	    			alert('등록된 카드가 없습니다.');
	    			$("#name").val("").removeAttr("readonly");
	    	    	$("#cardNum").val("").removeAttr("readonly");
	    			$("#validateMonth").val("").removeAttr("readonly");
	    			$("#validateYear").val("").removeAttr("readonly");
	    			$("#cvc").val("").removeAttr("readonly");
	    			
	    			let str = "";
	    			str += "<option value=''>은행</option>";
	    			str += "<option value='하나'>하나</option>";
	    			str += "<option value='국민'>국민</option>";
	    			str += "<option value='기업'>기업</option>";
	    			str += "<option value='농협'>농협</option>";
	    			$("#bankName").html(str);
	    		}
			});
	    }else{
	    	$("#name").val("").removeAttr("readonly");
	    	$("#cardNum").val("").removeAttr("readonly");
			$("#validateMonth").val("").removeAttr("readonly");
			$("#validateYear").val("").removeAttr("readonly");
			$("#cvc").val("").removeAttr("readonly");
			
			let str = "";
			str += "<option value=''>은행</option>";
			str += "<option value='하나'>하나</option>";
			str += "<option value='국민'>국민</option>";
			str += "<option value='기업'>기업</option>";
			str += "<option value='농협'>농협</option>";
			$("#bankName").html(str);
	    }
	});
	
$("#bankName").change(function() {
		let bankName = $(this).val();
		// 카드가 선택된 경우 
		if(bankName){
			if(bankName === $("#"+bankName+"SimpleCard").val()){
				let name = $("#bankName option:selected").data("name");
				let cardNum = $("#bankName option:selected").data("cardnum");
				let validateMonth = $("#bankName option:selected").data("validatemonth");
				let validateYear = $("#bankName option:selected").data("validateyear");
				let cvc = $("#bankName option:selected").data("cvc");
				
				$("#name").val(name).attr("readonly",true);
				$("#cardNum").val(cardNum).attr("readonly",true);
				$("#validateMonth").val(validateMonth).attr("readonly",true);
				$("#validateYear").val(validateYear).attr("readonly",true);
				$("#cvc").val(cvc).attr("readonly",true);
			}
			else if(bankName === "x"){
				$("#name").val("").attr("readonly",true);
				$("#cardNum").val("").attr("readonly",true);
				$("#validateMonth").val("").attr("readonly",true);
				$("#validateYear").val("").attr("readonly",true);
				$("#cvc").val("").attr("readonly",true);
			}
		}
	}); 
	
	$("#paymentBtn").on("click", function(e) {
		e.preventDefault();
		let name = $("#name").val();
		let bankName = $("#bankName").val();
		let cardNum = $("#cardNum").val();
		let validateMonth = $("#validateMonth").val();
		let validateYear = $("#validateYear").val();
		let cvc = $("#cvc").val();
		let cardPwd = $("#cardPwd").val();
		
		let postalCode = $("#postalCode").val();
		let roadAddress = $("#roadAddress").val();
		let detailAddress= $("#detailAddress").val();
		
		if(!name || !bankName || !cardNum || !validateMonth || !validateYear || !cvc || !cardPwd || !postalCode || !roadAddress || !detailAddress){
			alert('모두 입력하세요');
			return;
		}
		
		if(!discountedTotalPrice){
			alert('구매할 상품이 없습니다.');
			return;
		}
		let str = "";
		str += "<input type='hidden' name='name' value='"+name+"'>";
		str += "<input type='hidden' name='bankName' value='"+bankName+"'>";
		str += "<input type='hidden' name='cardNum' value='"+cardNum+"'>";
		str += "<input type='hidden' name='validateMonth' value='"+validateMonth+"'>";
		str += "<input type='hidden' name='validateYear' value='"+validateYear+"'>";
		str += "<input type='hidden' name='cvc' value='"+cvc+"'>";
		str += "<input type='hidden' name='pwd' value='"+cardPwd+"'>";
		
		str += "<input type='hidden' name='count' value='"+count+"'>";
		str += "<input type='hidden' name='pno' value='"+pno+"'>";
		
		str += "<input type='hidden' name='postalCode' value='"+postalCode+"'>";
		str += "<input type='hidden' name='roadAddress' value='"+roadAddress+"'>";
		str += "<input type='hidden' name='detailAddress' value='"+detailAddress+"'>";
		
		$("#submitBtn").append(str);
		$("#submitBtn").submit();
	});
</script>

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
	// 숫자만 입력
	function inNumber(){
	    if(event.keyCode<48 || event.keyCode>57){
	       event.returnValue=false;
	    }
	}
</script>
<%@include file="../includes/footer.jsp" %>