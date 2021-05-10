var commonService = (function() {
	function getIdValidate(id, callback, error) {
		$.ajax({
			type : 'post',
			url : '/shoppingmall/common/getIdValidate',
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
	
	function addBasket(basketInfo, callback) {
		$.ajax({
			url: '/shoppingmall/common/addBasket',
			data: JSON.stringify(basketInfo),
			dataType: 'text',
			type: 'POST',
			contentType: "application/json; charset=utf-8",
			success: function(result) {
				if(callback){
					callback(result);
				}
			}
		});
	}
	function removeBasket(pno, callback) {
		$.ajax({
			url: '/shoppingmall/common/removeBasket?pno='+pno,
			dataType: 'text',
			type: 'POST',
			success: function(result) {
				if(callback){
					callback(result);
				}
			}
		});
	}
	
	function updateBasket(pno, count, callback) {
		$.ajax({
			url: '/shoppingmall/common/updateBasket?pno='+pno+'&count='+count,
			dataType: 'text',
			type: 'POST',
			success: function(result) {
				if(callback){
					callback(result);
				}
			}
		});
	}
	return {
		getIdValidate : getIdValidate,
		addBasket : addBasket,
		removeBasket:removeBasket,
		updateBasket:updateBasket
	};
})();
 