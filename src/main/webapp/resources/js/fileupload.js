var fileuploadService = (function() {
	var csrfHeaderName = $("meta[name='csrfHeaderName']").attr("content");
	var csrfTokenValue = $("meta[name='csrfTokenValue']").attr("content");
	
	console.log(csrfHeaderName + ", "+csrfTokenValue);
	function uploadProductImage(formData, callback, error) {
		$.ajax({
			url: '/shoppingmall/uploadImageAction',
			processData: false,
			contentType: false,
			data: formData,
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
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
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
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
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
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
 