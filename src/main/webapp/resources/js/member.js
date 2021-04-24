var memberService = (function() {
	$.ajaxSetup({
		
	});
	function getSellerRequestValidate(id, callback, error) {
		$.ajax({
			type : 'post',
			url : '/shoppingmall/member/getSellerRequestValidate',
			data : 'id='+id,
			success : function(result, status, xhr) {
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, err) {
				if(error){
					error(err);
				}
			}
		});
	}

	function getSellerRequest(id, callback, error) {
		$.get("/shoppingmall/member/getSellerRequest/"+id+".json", function(SellerRequestVO) {
			if(callback){
				callback(SellerRequestVO);
			}
		}).fail(function(xhr, status, err) {
			if(error){
				err();
			}
		})
	}
	function displayTime(timeValue) {	
		let dateObj = new Date(timeValue);
		let yy = dateObj.getFullYear();
		let mm = dateObj.getMonth()+1;
		let dd = dateObj.getDate();
		let hh = dateObj.getHours();
		let mi = dateObj.getMinutes();
		
		mm = mm < 10 ? '0' + mm : mm;
		dd = dd < 10 ? '0' + dd : dd;
		hh = hh < 10 ? '0' + hh : hh;
		mi = mi < 10 ? '0' + mi : mi;
		return yy + '년 ' + mm + '월 ' + dd + '일 ' + hh+'시 '+ mi+'분 ';
	}
	return {
		getSellerRequestValidate : getSellerRequestValidate,
		getSellerRequest : getSellerRequest,
		
		displayTime:displayTime
	};
})();
 