<%@include file="../includes/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div align="center" class="panel-title" style="margin-top: 30px">
	<font size="6px" face="Prompt">판매 리스트</font>
	<table class="table" style="width: 60%; text-align: center; margin-top: 20px; font-size: 12px">
		<thead>
			<tr>
				<th>이미지</th>
				<th>카테고리</th>
				<th>상품명</th>
				<th>재고(개)</th>
				<th>가격(원)</th>
				<th>할인(%)</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody id="tbody">
			<c:forEach items="${products }" var="product">
			<tr>
				<td>이미지 첨부 예정</td>
				<c:choose>
					<c:when test="${'food' eq product.category}">
						<td>음식</td>
					</c:when>
					<c:when test="${'clothes' eq product.category}">
						<td>패션/의류</td>
					</c:when>
				</c:choose>
								 
				<td>${product.prdName}</td>
				<td>${product.stock}</td>
				<td>${product.price}</td>
				<td>${product.discount}</td>
				<td><input type="button" class="mdfBtn" data-pno="${product.pno}" value="수정"></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<script type="text/javascript" src="/shoppingmall/resources/js/admin.js"></script>
<script>
	$(".mdfBtn").on("click", function() {
		let pno = $(this).data("pno");
		window.location.href = "/shoppingmall/seller/product?pno="+pno;
	});
</script>

<%@include file="../includes/footer.jsp"%>
