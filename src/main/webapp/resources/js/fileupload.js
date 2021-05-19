var fileuploadService = (function() {
	function uploadProductImage(formData, callback, error) {
		$.ajax({
			url: '/shoppingmall/uploadImageAction',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			dataType : 'json',
			success: function(result) {
				if(callback){
					callback(result);
				}
			}
		});
	};
	function getProductImages(pno, callback, error) {
		$.get("/shoppingmall/getProductImages/" + pno + ".json", function(list) {
			if(callback){
				callback(list);
			}
		}).fail(function(xhr, status, err) {
			if(error){
				err();
			}
		})
	}
	
	function deleteProductImage(targetFile, type, callback) {
		$.ajax({
			url: '/shoppingmall/deleteFile',
			data: {fileName: targetFile, type:type},
			dataType: 'text',
			type: 'POST',
			success: function(result) {
				if(callback){
					callback(result);
				}
			}
		});
	}
	// 리뷰에 첨부한 이미지
	function uploadReviewImage(formData, callback, error) {
		$.ajax({
			url: '/shoppingmall/uploadReviewImageAction',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			dataType : 'json',
			success: function(result) {
				if(callback){
					callback(result);
				}
			}
		});
	};
	return {
		uploadProductImage : uploadProductImage,
		deleteProductImage : deleteProductImage,
		getProductImages : getProductImages,
		uploadReviewImage : uploadReviewImage
	};
})();
 