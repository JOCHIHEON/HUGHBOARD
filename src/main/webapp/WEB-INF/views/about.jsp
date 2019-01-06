<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="./include/header.jsp" %>

	<div class="container" style="margin-bottom: 50px; max-width: 60%;">
		<div class="jumbotron">
			<div align="center">
				<img width="30%" class="img-circle" src="/resources/dist/img/profile.jpg" alt="">
			</div>
			<div class="jumbotron" align="center">
				<span style="font-size: 3em; font-weight: bold;">About</span>
				<div>
					<hr color="gray">
					<span style="font-size: 1em; letter-spacing: 2px; word-spacing: 4px">
						개발에 흥미를 가지게 되어, 현재 한국IT인재개발원에서 클라우드 컴퓨팅 기반의 빅데이터 응용SW개발자  국비지원 과정을 이수중입니다.(2018)
						어려서부터 컴퓨터에 관심이 많았는데, 이것이 지금의 제 진로에 많은 영향을 주었다고 생각합니다.<br><br>
						비전공 분야인 만큼,단순히 기술적인 부분만 공부하는 것에 그치지 않고, 
						모르는 것이 있으면 자료를 찾아보고  커뮤니티에 수시로 질문하며 제 것으로 만들었습니다. 
						  비록 저의 프로그래밍 경력은 8개월 동안  짧게 접해본 것이 전부이지만,
						 개발자로서의 제 삶은 계속해서 현재진행형입니다.
					</span>
				</div>
			</div>
		</div>
		<div class="jumbotron">
			<div align="center" style="margin-bottom: 40px">
				<span style="font-size: 3em; font-weight: bold;">Contact Me</span>
			</div>
			<hr color="gray">
			<form>
				<div class="form-group">
					<label for="name">이름</label>
					<input type="email" class="form-control" id="name" placeholder="이름을 입력해주세요.">
					<span id="name_msg" style="color: red"></span>
				</div>
				<div class="form-group">
					<label for="email">이메일 주소</label>
					<input type="email" class="form-control" id="email" placeholder="이메일을 입력해주세요.">
					<span id="email_msg" style="color: red"></span>
				</div>
				<div class="form-group">
					<label for="content">내용</label>
					<textarea rows="5" class="form-control" id="content" placeholder="내용을 입력해주세요."></textarea>
					<span id="content_msg" style="color: red"></span>
				</div>
				<div class="form-group" align="right">
					<button id="submit" type="submit" class="btn btn-warning">보내기</button>
				</div>
			</form>
		</div>
	</div>
	
	<!-- 관리자에게 메세지 보내기 -->
	<script type="text/javascript">
		$("#submit").click(function(event) {
			event.preventDefault();
			
			var name = $("#name").val();
			var email = $("#email").val();
			var content = $("#content").val();
			
			// null 체크
			if (name == null || name == "") {
				$("#name_msg").text("이름을 입력해주세요.");
			}
			if (email == null || email == "") {
				$("#email_msg").text("이메일을 입력해주세요.");
			}
			if (content == null || content == "") {
				$("#content_msg").text("내용을 입력해주세요.");
			}
			
			if (name == null || name == "" || email == null || email == "" || content == null || content == "") {
				return false;
			}
			
			// emailjs 라이브러리
			(function() {
				emailjs.init("user_5S06wEECQ1ZWpeMTRLkbO");
			})();

			var template_params = {
				"name" : name,
				"content" : content,
				"email" : email
			}
			var service_id = "default_service";
			var template_id = "template_yNHBeQiU";
			
			emailjs.send(service_id, template_id, template_params)
	        .then(function(response) {
	            console.log("SUCCESS. status=%d, text=%s", response.status, response.text);
	        }, function(err) {
	            console.log("FAILED. error=", err);
	        });
			alert("전송하였습니다.");
		});
	</script>
		
	<script>
		$(".form-group .form-control").click(function() {
			$(this).parent(".form-group").children("span").text("");
		});
	</script>
<%@ include file="./include/footer.jsp" %>