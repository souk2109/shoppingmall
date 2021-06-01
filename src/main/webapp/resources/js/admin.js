var adminService = (function() {
	$.ajaxSetup({
	});

	function getAllSellerRequests(callback, error) {
		$.get("/shoppingmall/admin/getAllSellerRequests.json", function(list) {
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
	
	function getBusinessImage(num, callback) {
		$.get("/shoppingmall/admin/getBusinessImage/" + num + ".json", function(image) {
			if(callback){
				callback(image);
			}
		}).fail(function(xhr, status, err) {
			if(error){
				err();
			}
		})
	};
	
	return {
		getAllSellerRequests : getAllSellerRequests,
		getBusinessImage : getBusinessImage,
		displayTime:displayTime
	};
})();
 