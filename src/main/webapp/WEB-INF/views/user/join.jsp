<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>

	<div class="container">
		<div class="col-lg-4"></div>
			<div class="col-lg-4">
				<div class="jumbotron" style="padding-top: 20px;" align="center">
					<form action="/user/joinPost" method="post">
						<h3>회원가입</h3>
						<div class="form-group">
							<input class="form-control" type="text" id="uid" name="uid" placeholder="아이디" autocomplete="off">
						</div>
						<div class="form-group">
							<span id="id-msg" style="color: red"></span>
						</div>	
						<div class="form-group">
							<input class="form-control" type="password" id="pw" name="pw" placeholder="비밀번호 (4자리 이상)">
						</div>
						<div class="form-group">
							<input class="form-control" type="password" id="pwck" name="pwck" placeholder="비밀번호 확인">
						</div>
						<div class="form-group" align="left">
							<span style="margin-right: 10px; color: gray" id="password-ck-btn" class="fa fa-check" aria-hidden="true"></span>
							<em id="password-ck" style="color: gray">password check</em>
						</div>
						<div class="form-group">
							<input class="form-control" type="text" id="name" name="name" placeholder="이름" autocomplete="off">
						</div>
						<div class="form-group">	
							<span id="name-msg" style="color: red"></span>
						</div>
						<div class="form-group" style="text-align: center">
							<div class="btn-group" data-toggle="buttons">
								<label class="btn btn-info active">
									<input type="radio" name="gender" value="남자" checked="checked">남자
								</label>
								<label class="btn btn-info">
									<input type="radio" name="gender" value="여자">여자
								</label>
							</div>
						</div>
						<div class="form-group">
							<input class="form-control" type="email" id="email" name="email" placeholder="이메일" autocomplete="off">
						</div>
						<div class="form-group">
							<span id="email-msg" style="color: red"></span>
						</div>
						<input id="submit-btn" class="btn btn-primary form-control" disabled="disabled" type="submit" value="회원가입">
					</form>
				</div>
			</div>
		<div class="col-lg-4"></div>
	</div>
	
	<!-- 1. password 일치 확인 -->
	<script>
		var passwordCkBtn = $("#password-ck-btn");
		var passwordCk = $("#password-ck");
		
		var pwObj = $("#pw");
		var pwckObj = $("#pwck");
		
		function pwCheck() {
			if (pwObj.val() == pwckObj.val() && pwObj.val().length >= 4 && pwckObj.val().length >= 4) {
				passwordCkBtn.css("color", "#6ce945");
				passwordCk.css("color", "black");

				pwResult = true;
			} else {
				passwordCkBtn.css("color", "gray");
				passwordCk.css("color", "gray");
				
				pwResult = false;
			}
		}
		
		// pw 입력창 keyup시
		pwObj.keyup(function() {
			pwCheck();
			finalCheck();
		});
		
		// pwck 입력창 keyup시
		pwckObj.keyup(function() {
			pwCheck();
			finalCheck();
		});
	</script>	
	
	<!-- 2. ajax uid 중복 체크 -->
	<script>	
		var uidObj = $("#uid");
		
		function joinIdCheck() {
			var uid = $("#uid").val();
			var idMsg = $("#id-msg");
			
			$.ajax({
				type:"GET",
				url:"/user/joinUidCheck?uid=" + uid,
				dataType:"text",
				success:function(result) {
					if (result == "UID_DUP") {
						idMsg.text("이미 사용중인 아이디입니다.");
						uidResult = false;
					} else if (uid == "" || uid == null) {
						idMsg.text("아이디는 필수항목입니다.");
						uidResult = false;
					} else if (result == "SUCCESS") {
						idMsg.text("");
						uidResult = true;
					}
					
					finalCheck();
					return uidResult;
				}
			});
		}
		
		// uid 입력창 keyup시
		uidObj.keyup(function() {
			joinIdCheck();
		});
	</script>
		
	<!-- 3. ajax email 중복 체크 -->
	<script>
		var emailObj = $("#email");
		
		function joinEmailCheck() {
			var email = $("#email").val();
			var emailMsg = $("#email-msg");
			
			$.ajax({
				type:"GET",
				url:"/user/joinEmailCheck?email=" + email,
				dataType:"text",
				success:function(result) {
					if (result == "EMAIL_DUP") {
						emailMsg.text("이미 사용중인 이메일입니다.");
						emailResult = false;
					} else if (email == "" || email == null) {
						emailMsg.text("이메일은 필수항목입니다.");
						emailResult = false;
					} else if (result == "SUCCESS") {
						emailMsg.text("");
						emailResult = true;
					}
					
					finalCheck();
					return emailResult;
				}
			});
		}
		
		// email 입력창 keyup시
		emailObj.keyup(function() {
			joinEmailCheck();
		});
	</script>
		
		
	<!-- 4. name null 체크 -->
	<script>
		var nameObj = $("#name");
		var nameMsg = $("#name-msg");
		
		function nameCheck() {
			if (nameObj.val() == "" || nameObj.val() == null) {
				nameMsg.text("이름은 필수항목입니다.");
				nameResult = false;
			} else {
				nameMsg.text("");
				nameResult = true;
			}
			
			return nameResult;
		}
		
		// name 입력창 keyup시
		nameObj.keyup(function() {
			nameCheck();
			finalCheck();
		});
	</script>
	
	<!-- 1, 2, 3, 4 메소드 결과를 받아 "회원가입 버튼" 활성화 결정 -->
	<script>	
		var uidResult = false;
		var pwResult = false;
		var nameResult = false;
		var emailResult = false;
		
		var submitBtn = $("#submit-btn");
	
		function finalCheck() {
			if (uidResult && pwResult && nameResult && emailResult) {
				submitBtn.removeAttr("disabled");
			} else {
				submitBtn.attr("disabled", "disabled");
			}
		}
	</script>

<%@ include file="../include/footer.jsp" %>