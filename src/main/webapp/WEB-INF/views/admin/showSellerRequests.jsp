<%@include file="../includes/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<div align="center" class="panel-title" style="margin-top: 30px">
	<font size="6px" face="Prompt">판매자 신청 현황</font>
	<table class="table" style="width: 60%; text-align: center; margin-top: 20px; font-size: 12px">
		<thead>
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>상태</th>
				<th>신청 날짜</th>
				<th>처리 날짜</th>
			</tr>
		</thead>
		<tbody id="tbody">

		</tbody>
	</table>
</div>
<script type="text/javascript" src="/shoppingmall/resources/js/admin.js"></script>
<script>

	<!--모든 요청정보를 받아온다. -->
	adminService.getAllSellerRequests(function(list) {
		$("#tbody").html();
		if(list){
			let str = '';
			for(var i=0; i<list.length; i++){
				str += '<tr>';
				if(list[i].status === '처리중'){
					str += "<td><a href='/shoppingmall/admin/sellerRequest?id=" + list[i].id + "' style='color: blue;cursor:pointer'>" + list[i].id +"</a></td>";
				}else{
					str += "<td>" + list[i].id + "</td>";
				}
				str += '<td>'+ list[i].name +'</td>';
				str += '<td>'+ list[i].status +'</td>';
				str += '<td>'+ adminService.displayTime(list[i].regdate) +'</td>';
				if(list[i].status === '처리중'){
					str += '<td>-</td>';
				}else{
					str += '<td>'+ adminService.displayTime(list[i].updatedate) +'</td>';
				}
				str += '</tr>';
			}
			$("#tbody").append(str);
		}
	});
</script>

<%@include file="../includes/footer.jsp"%>
