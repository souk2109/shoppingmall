var memberService = (function() {
	$.ajaxSetup({
		
	});
	// 최근 하나의 판매자 신청 정보만 가져옴
	function getRecentSellerRequest(id, callback, error) {
		$.get("/shoppingmall/member/getRecentSellerRequest/"+id+".json", function(SellerRequestVO) {
			if(callback){
				callback(SellerRequestVO);
			}
		}).fail(function(xhr, status, err) {
			if(error){
				err();
			}
		})
	}
	// 모든 판매자 신청 정보를 가져옴
	function getSellerRequests(id, callback, error) {
		$.get("/shoppingmall/member/getSellerRequests/"+id+".json", function(list) {
			if(callback){
				callback(list);
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
		getRecentSellerRequest : getRecentSellerRequest,
		getSellerRequests : getSellerRequests,
		
		displayTime:displayTime
	};
})();
 