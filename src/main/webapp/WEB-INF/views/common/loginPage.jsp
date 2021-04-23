<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Prompt:wght@600&display=swap" rel="stylesheet">
<div class="container" align="center">
	<div class="row">
		<div class="col-md-6" style="margin: 0 auto;">
			<div class="panel-default">
				<div class="" align="center">
					<font class="panel-title" size="20px" face="Prompt">LOGIN</font>
				</div>
				<div class="panel-body" style="margin-top: 20px;">
					<form method="post" action="/shoppingmall/common/doLogin">
						<div class="form-group" align="left">
							
							<div class="col-sm-12">
								<input name="id" type="text" class="form-control" placeholder="아이디"
									autofocus>
							</div>
						</div>

						<div class="form-group" align="left">
							
							<div class="col-sm-12">
								<input name="pwd" type="password" class="form-control" placeholder="비밀번호">
							</div>
						</div>

						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-12">
								<font color="white">
									<input type="submit"  value="로그인" style="border:hidden; margin-top: 20px;font-size: 18px; height: 54px; width: 100%; background-color: green; color: white;">
								</font>
							</div>
						</div>
						<div align="center" style="font-size: 14px; margin-top: 30px; margin-bottom: 30px" class="col-sm-12">
							<span class="top-bar-menu-item"><a href="#">아이디 찾기</a></span>
            				<span class="top-bar-menu-item"><a href="#">비밀번호 찾기</a></span>
            				<span class="top-bar-menu-item"><a href="/shoppingmall/common/registerPage">회원가입</a></span>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<%@include file="../includes/footer.jsp" %>