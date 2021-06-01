var commonService = (function() {
	var csrfHeaderName = $("meta[name='csrfHeaderName']").attr("content");
	var csrfTokenValue = $("meta[name='csrfTokenValue']").attr("content");
	
	$.ajaxSetup({
		async: false
	});
	
	function getIdValidate(id, callback, error) {
		$.ajax({
			type : 'post',
			url : '/shoppingmall/common/getIdValidate',
			data : 'id='+id,
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
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
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
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
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
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
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
			success: function(result) {
				if(callback){
					callback(result);
				}
			}
		});
	}
	function getReviewImages(rno, callback) {
		$.get("/shoppingmall/common/getReviewImages/" + rno + ".json", function(list) {
			if(callback){
				callback(list);
			}
		}).fail(function(xhr, status, err) {
			if(error){
				err();
			}
		})
	};
	function getReviewWithHighGrade(pno, callback) {
		$.get("/shoppingmall/common/getReviewWithHighGrade/" + pno + ".json", function(list) {
			if(callback){
				callback(list);
			}
		}).fail(function(xhr, status, err) {
			if(error){
				err();
			}
		})
	};
	function getReviewWithLowGrade(pno, callback) {
		$.get("/shoppingmall/common/getReviewWithLowGrade/" + pno + ".json", function(list) {
			if(callback){
				callback(list);
			}
		}).fail(function(xhr, status, err) {
			if(error){
				err();
			}
		})
	};
	function getReviewWithRegdateDesc(pno, callback) {
		$.get("/shoppingmall/common/getReviewWithRegdateDesc/" + pno + ".json", function(list) {
			if(callback){
				callback(list);
			}
		}).fail(function(xhr, status, err) {
			if(error){
				err();
			}
		})
	};
	
	function findId(name, email, callback) {
		$.ajax({
			url: '/shoppingmall/common/findId?name='+name+'&email='+email,
			dataType: 'text',
			type: 'POST',
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
			success: function(result) {
				if(callback){
					callback(result);
				}
			}
		});
	}
	function findUser(id, email, callback) {
		$.ajax({
			url: '/shoppingmall/common/findUser?id='+id+'&email='+email,
			dataType: 'text',
			type: 'POST',
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
			success: function(result) {
				if(callback){
					callback(result);
				}
			}
		});
	}
	function displayTime(timeValue) {	
		let dateObj = new Date(timeValue);
		let yy = dateObj.getFullYear();
		let mm = dateObj.getMonth()+1;
		let dd = dateObj.getDate();
		let hh = dateObj.getHours();
		let mi = dateObj.getMinutes();
		let division = ' 오전 ';
		if(hh>12){
			division = ' 오후 ';
			hh = hh - 12;
		}
		 
		mm = mm < 10 ? '0' + mm : mm;
		dd = dd < 10 ? '0' + dd : dd;
		hh = hh < 10 ? '0' + hh : hh;
		mi = mi < 10 ? '0' + mi : mi;
		return yy + '.' + mm + '.' + dd + division + hh+'시 '+ mi+'분 ';
	}
	
	return {
		getIdValidate : getIdValidate,
		addBasket : addBasket,
		removeBasket:removeBasket,
		updateBasket:updateBasket,
		getReviewImages:getReviewImages,
		getReviewWithHighGrade:getReviewWithHighGrade,
		getReviewWithLowGrade:getReviewWithLowGrade,
		getReviewWithRegdateDesc:getReviewWithRegdateDesc,
		findId:findId,
		findUser:findUser,
		displayTime:displayTime
	};
})();
 