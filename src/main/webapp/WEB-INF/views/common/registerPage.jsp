<%@include file="../includes/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="container">
	<div class="row">
		<div class="col-md-12 col-md-offset-4">
			<div class="login-panel panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">회원가입</h3>
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
							<label for="inputPassword3" class="col-sm-12 control-label">비밀번호
								재입력</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" placeholder="비밀번호">
							</div>
						</div>

						<div class="form-group">
							<div class="col-sm-12">
								<label for="inputEmail3" class="control-label">닉네임</label>
							</div>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="inputEmail3"
									placeholder="닉네임">
							</div>
						</div>

						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">생년월일</label>
							<div class="col-sm-9">
								<input type="text" placeholder="년(4자)" aria-label="년(4자)"
									class="int" maxlength="4"> <span class="ps_box">
									<select id="mm" class="sel" aria-label="월">
										<option value="">월</option>
										<option value="01">1</option>
										<option value="02">2</option>
										<option value="03">3</option>
										<option value="04">4</option>
										<option value="05">5</option>
										<option value="06">6</option>
										<option value="07">7</option>
										<option value="08">8</option>
										<option value="09">9</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
								</select>
								</span> <input type="text" placeholder="일" aria-label="일" class="int"
									maxlength="2">
							</div>
						</div>

						<div class="form-group">
							<label for="inputPassword3" class="col-sm-12 control-label">성별</label>
							<div class="radio custom-control">
								<label><input name="gener" type="radio" checked>남성</label>
							</div>
							<div class="radio custom-control">
								<label><input name="gener" type="radio">여성</label>
							</div>
						</div>

						<div class="form-group">
							<div class="col-sm-12">
								<label for="inputEmail3" class="control-label">이메일</label>
							</div>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="email" name="email"
									placeholder="이메일" maxlength="100">
							</div>
						</div>

						<div class="form-group">
							<div class="col-sm-12">
								<label for="inputEmail3" class="control-label">우편번호</label>
							</div>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="post" name="post"
									placeholder="우편번호" maxlength="100">
							</div>
						</div>

						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-info btn-lg">회원가입</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<%@include file="../includes/footer.jsp" %>