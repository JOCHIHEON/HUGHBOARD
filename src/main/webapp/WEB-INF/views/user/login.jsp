<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>

	<div class="container">
		<div class="col-lg-4"></div>
			<div class="col-lg-4">
				<div class="jumbotron" style="padding-top: 20px;" align="center">
					<form action="/user/loginPost" method="post">
						<c:if test="${param.login_error == 1 }">
						<div class="alert alert-warning" role="alert">
							<ul>
								<li><font color="red">아이디 또는 비밀번호 오류</font></li>
							</ul>
						</div>
						</c:if>
						<h3>로그인</h3>
						<div class="form-group">
							<input class="form-control" type="text" id="uid" name="uid" value="${cookie.savedId.value }" placeholder="아이디" autocomplete="off">
						</div>
						<div class="form-group">
							<input class="form-control" type="password" id="pw" name="pw" placeholder="비밀번호">
						</div>
						<div class="form-group">
							<input style="margin-right: 5px" type="checkbox" name="usecookie">로그인 유지
							<input type="hidden" name="uri" value="${param.uri }">
						</div>
						<div class="form-group">
							<input id="submit-btn" class="btn btn-primary form-control" type="submit" value="로그인">
						</div>
						<div class="form-group">
							<div id="naver_id_login"></div>
						</div>
						<div class="form-group">
							<h6>아직 회원이 아니신가요?</h6>
							<input onclick="location.href='/user/join'" class="btn btn-primary form-control" type="button" value="회원가입">
						</div>
					</form>
				</div>
			</div>
		<div class="col-lg-4"></div>
	</div>
	
	<!-- uid, pw null 체크 -->
	<script>
		$("#submit-btn").click(function() {
			var uid = $("#uid").val();
			var pw = $("#pw").val();
			
			if (uid == null || uid == "") {
				alert("아이디를 입력해주세요.");
				return false;
			} else if (pw == null || pw == "") {
				alert("비밀번호를 입력해주세요.");
				return false;
			}
		});
	</script>
	
	<!-- "네이버 아이디로 로그인" 버튼 노출 영역 -->
	<script type="text/javascript">
 		var naver_id_login = new naver_id_login("lxnK2CUPLd2wYgnGmv9C", "http://localhost/user/login");
 		var state = naver_id_login.getUniqState();
		
 		naver_id_login.setButton("green", 3, 40);
 		naver_id_login.setDomain("http://localhost:80/user/loginNaver");
 		naver_id_login.setState(state);
 		naver_id_login.init_naver_id_login();
	</script>

<%@ include file="../include/footer.jsp" %>