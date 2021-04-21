<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="container">
	<div class="row">
		<div class="col-md-12 col-md-offset-4">
			<div class="login-panel panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">로그인</h3>
				</div>
				<div class="panel-body" style="margin-top: 20px;">
					<form role="form">
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">아이디</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" placeholder="아이디"
									autofocus>
							</div>
						</div>

						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">비밀번호</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" placeholder="비밀번호">
							</div>
						</div>

						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="site-btn btn-lg">로그인</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<%@include file="../includes/footer.jsp" %>