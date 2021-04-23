var commonService = (function() {
	$.ajaxSetup({
		
	});
	
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
 
	
	return {
		getIdValidate : getIdValidate
	};
})();
 