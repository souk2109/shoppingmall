<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link href="https://fonts.googleapis.com/css2?family=Prompt:wght@600&display=swap" rel="stylesheet">
<sec:authentication property="principal" var="loginUser"/>
<div class="container" align="center">
	<div class="row">
		<div class="col-md-6" style="margin: 0 auto;">
			<div class="panel-default">
				<div align="center">
					<font class="panel-title" size="20px" face="Prompt">상품 등록</font>
				</div>
				
				<div class="panel-body" style="margin-top: 20px;">
					<form id="registerForm" action="/shoppingmall/seller/doRegisteProduct" method="post">
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
									<option value="clothes">패션 의류/잡화</option>
									<option value="food">식품</option>
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
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-12">
								<input id="registerBtn" type="submit"  value="등록하기" style="border:hidden; margin-top: 20px;font-size: 18px; height: 54px; width: 100%; background-color: green; color: white;">
							</div>
						</div>
						
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="/shoppingmall/resources/js/member.js"></script>
<script>
	function inNumber(){
	    if(event.keyCode<48 || event.keyCode>57){
	       event.returnValue=false;
	    }
	}
</script>
<%@include file="../includes/footer.jsp" %>