<%@include file="../includes/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	let price;
	let discount;
	let discountedPrice;
</script>
<div align="center">
	<font class="panel-title" size="20px" face="Prompt">주문내역</font>
</div>

<div style="width: 80%; margin: 0px auto;">
	 
</div>
 

<%@include file="../includes/footer.jsp"%>