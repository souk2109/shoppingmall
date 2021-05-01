<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Upload with Ajax</title>
	<style type="text/css">
		.uploadResult{
			width: 100%;
			background-color: gray;
		}
		.uploadResult ul{
			display: flex;
			flex-flow: row;
			justify-content: center;
			align-items: center;
		}
		.uploadResult ul li{
			list-style: none;
			padding: 10px;
			align-content: center;
			text-align: center;
		}
		.uploadResult ul li img{
			width: 20px;
		}
		.uploadResult ul li span{
			color: white;
		}
		.bigPictureWrapper{
			position: absolute;
			display: none;
			justify-content: center;
			align-items: center;
			top: 0%;
			width: 100%;
			height: 100%;
			background-color: gray;
			z-index: 100;
			background: rgba(255,255,255,0.5);
		}
		.bigPicture{
			position: relative;
			display: flex;
			justify-content: center;
			align-items: center;
		}
		.bigPicture img{
			width: 600px;
		}
	</style>
</head>
<body>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple="multiple">
	</div>
	<button id="uploadBtn">Upload</button>
	<div class="uploadResult">
		<ul>
		</ul>
	</div>
	<div class="bigPictureWrapper">
		<div class="bigPicture">
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js" ></script>
	<script>
	
	function showImage(fileCallPath) {
		console.log("요청한 파일 명 : "+fileCallPath);
		$(".bigPictureWrapper").css("display","flex").show();
		$(".bigPicture")
		.html("<img src='/display?fileName="+encodeURI(fileCallPath)+"'>")
		.animate({width:'100%', height:'100%'}, 1000);
	}
	
	$("document").ready(function() {
		var maxSize = 5242880;
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		
		function checkExtension(fileName, fileSize) {
			if(fileSize >= maxSize){
				alert("해당 파일의 크기가 너무 큽니다.");
				return false;	
			}
			if(regex.test(fileName)){
				alert("해당 파일은 업로드가 불가능합니다.");
				return false;	
			}
			return true;
		}
		
		var uploadResult = $(".uploadResult ul");
		var uploadResultClone = uploadResult.clone();
		function showUploadedFile(uploadResultArr) {
			var str = '';
			$(uploadResultArr).each(function(i, obj) {
				// 이미지가 아닌 파일을 업로드한 경우
				if(!obj.image){
					var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid +"_" +obj.fileName);
					str += "<li>"+
									"<a href='/download?fileName=" + fileCallPath +"'>" +
										"<img src='resources/img/attach.png'>"+ obj.fileName +
									"</a>" + 
									"<span data-file=\'"+fileCallPath+"\' data-type='file'>x</span" +
								"</li>";
				}
				// 이미지 파일을 업로드한 경우
				else{
					// str += "<li>" +obj.fileName + "</li>";
					// "C:\\upload\\"" + obj.uploadPath +"\\s_"+obj.uuid + fileName
					var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid +"_" +obj.fileName);
					var originPath = obj.uploadPath + "\\" +obj.uuid+ "_"+obj.fileName;
					originPath = originPath.replace(new RegExp(/\\/g),"/");
					str += "<li>"+
								"<a href=\"javascript:showImage(\'" +originPath+"\')\">"+
									"<img src=/display?fileName=" + fileCallPath +"/>"+
								"</a>"+
								"<span data-file=\'"+fileCallPath+"\' data-type='image'>x</span" +
							"</li>";
				}
			});
			uploadResult.append(str);
		}
		
		var cloneObj = $(".uploadDiv").clone();
		$("#uploadBtn").on("click", function(e){
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			console.log(files);
			for(var i=0; i< files.length; i++){
				if( !checkExtension( files[i].name, files[i].size) ){
					return false;
				}
				formData.append("uploadFile", files[i]);
			}
			$.ajax({
				url: '/shoppingmall/uploadAjaxAction',
				processData: false,
				contentType: false,
				data: formData,
				type: 'POST',
				dataType : 'json',
				success: function(result) {
					// 창 새로고침 후 이전에 등록한 파일명 안보이게 하는 코드
					// $(".uploadResult ul").html(uploadResultClone.html());
					console.log(result);
					console.log("경로는 " + result[0].uploadPath + "업로드 파일 수: " +result.length);
					showUploadedFile(result);
					$(".uploadDiv").html(cloneObj.html());
				}
			});
		});
		
		$(".bigPictureWrapper").on("click",function(e){
			$(".bifPicture").animate({width:'0%', height:'0%'},1000);
			setTimeout(function() {
				$('.bigPictureWrapper').hide();
			},1000);
		});
		
		$(".uploadResult").on("click", "span", function(e){
			var targetFile = $(this).data("file");
			var type = $(this).data("type"); // 이미지는 image, 파일은 file 
			console.log(targetFile);
			$.ajax({
				url: '/shoppingmall/deleteFile',
				data: {fileName: targetFile, type:type},
				dataType:'text',
				type: 'POST',
				success: function (result) {
					alert(result);
				}
			});
		});
	});
	</script>
</body>
</html>