<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="../include/header.jsp" %>
	
	<form id="info_form" action="/user/loginPostNaver" method="post">
		<input type="hidden" id="uid" name="uid">
		<input type="hidden" id="name" name="name">
		<input type="hidden" id="gender" name="gender">
		<input type="hidden" id="thumbnail" name="thumbnail">
		<input type="hidden" id="email" name="email">
	</form>
	
	<script type="text/javascript">
		var naver_id_login = new naver_id_login("lxnK2CUPLd2wYgnGmv9C", "http://localhost:80/user/loginNaver");
		
		// 네이버 사용자 프로필 조회
		naver_id_login.get_naver_userprofile("naverSignInCallback()");
		
		// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
		function naverSignInCallback() {
			var infoForm = $("#info_form");
			
			$("#uid").val(naver_id_login.getProfileData("id"));
			$("#name").val(naver_id_login.getProfileData("name"));
			var gender = naver_id_login.getProfileData("gender") == "M" ? "남자" : "여자";
			$("#gender").val(gender);
			$("#thumbnail").val(naver_id_login.getProfileData("profile_image"));
			$("#email").val(naver_id_login.getProfileData("email"));
			
			infoForm.submit();
		}
	</script>

<%@ include file="../include/footer.jsp" %>