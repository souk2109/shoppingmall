<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Footer Section Begin -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="footer__text" style="padding: 0">
                    	<div style="display: table;margin: 0 auto">
                    		<div style="display: table-cell;padding: 20px">
                    			<div style="margin-bottom: 10px"><h5><b>개발환경</b></h5></div>
                    			<div align="left">
                    				<h6>eclipse</h6>
                    				<h6>java 1.8</h6>
                    				<h6>Spring framework 5.0.7</h6>
                    				<h6>apache tomcat 9.0.41</h6>
                    				<h6>mysql 5.7.21</h6>
                    				<h6>mybatis 3.4.6</h6>
                    				<h6>bootstrap 4.4.1</h6>
                    				<h6>Jquery</h6>
			                     	<h6>HTML5</h6>
			                     	<h6>CSS</h6>
                    			</div>
                    		</div>
                    		<div style="display: table-cell;padding: 20px">
                    			<div style="margin-bottom: 10px"><h5><b>프로젝트 기간</b></h5></div>
	                    		<div align="left">
	                    			<h6>2021.04.21~2021.06.02</h6>
	                    		</div>
	                    	</div>
                    		<div style="display: table-cell;padding: 20px">
                    			<div style="margin-bottom: 10px"><h5><b>깃허브</b></h5></div>
	                    		<div align="left">
	                    			<div id="git-link" style="cursor: pointer;">
	                    				<h6>souk2109/shoppingmall</h6>
	                    			</div>
	                    		</div>
                    		</div>
                    		<div style="display: table-cell;padding: 20px">
                    			<div style="margin-bottom: 10px"><h5><b>블로그</b></h5></div>
	                    		<div align="left">
	                    			<div id="tstory-link" style="cursor: pointer;">
	                    				<h6>웹개발 꿈나무(티스토리)</h6>
	                    			</div>
	                    		</div>
                    		</div>
                    	</div>
                    </div>
                    <div class="footer__copyright">
                        <p>2021 &copy; copyright by 
                        	<a href="mailto: souk2109@naver.com" title="문의하기">souk2109</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- Footer Section End -->
	<script>
		$("#git-link").on("click", function() {
			window.location.href = "https://github.com/souk2109/shoppingmall";
		});
		$("#tstory-link").on("click", function() {
			window.location.href = "https://web-developer-backend.tistory.com/";
		});
	</script>
    <!-- Search Begin -->
    <div class="search-model">
        <div class="h-100 d-flex align-items-center justify-content-center">
            <div class="search-close-switch">+</div>
            <form class="search-model-form">
                <input type="text" id="search-input" placeholder="Search here.....">
            </form>
        </div>
    </div>
    <!-- Search End -->

     
</body>
<script src="/shoppingmall/resources/js/main.js"></script>
</html>