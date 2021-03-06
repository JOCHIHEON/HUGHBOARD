<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>HUGH Board</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://okky.kr/assets/application-786c768e787a9741d1ce50a030efb766.css"/>
<link href="/resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.11/handlebars.min.js"></script>
<script type="text/javascript" src="/resources/js/upload.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="https://cdn.emailjs.com/dist/email.min.js"></script>

<style>
	.fileDrop {
		width: 100%;
		height: 200px;
		border: 1px dotted blue;
		background: white;
		margin: auto;
	}
	.popup {
		position: absolute;
	}
	.back {
		background-color: gray;
		opacity: 0.5;
		widows: 100%;
		height: 300%;
		overflow: hidden;
		z-index: 1101;
	}
	.front {
		z-index: 1110;
		opacity: 1;
		border: 1px;
		margin: auto;
	}
	.show {
		position: relative;
		max-width: 1200px;
		max-height: 800px;
		overflow: auto;
	}
</style>
</head>

<body>

	<!-- nav -->
	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<ul class="nav navbar-nav">
					<li id="home" class="active">
						<a class="navbar-brand" href="/">HUGH Board</a>
					</li>
				</ul>
			</div>
	
			<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li id="board">	
						<a href="/boards">Board</a>
					</li>
					<li id="about">	
						<a href="/about">About</a>
					</li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li style="padding: 10px">
						<h5 style="color: white;">
					</li>
					<li style="padding: 10px">
							<h5 style="color: white;">
							<c:if test="${login.uid == null }">
								GUEST님 반갑습니다.
							</c:if>
							<c:if test="${login.uid != null }">
								${login.uid }님 반갑습니다.
							</c:if>
							</h5>
					</li>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">메뉴 <span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<c:if test="${login.uid == null }">
							<li><a href="/user/login"><i class="fa fa-sign-in"></i> 로그인</a></li>
							<li><a href="/user/join"><i class="fa fa-user"></i> 회원가입</a></li>
							</c:if>
							<c:if test="${login.uid != null }">
							<li><a href="/user/logout" onclick="return confirm('로그아웃 하시겠습니까?');"><i class="fa fa-sign-out"></i> 로그아웃</a></li>
							<li><a href="/user/info"><i class="fa fa-user"></i> 내 정보</a></li>
							<li class="divider"></li>
<!-- 							<li><a href="#"><i class="fa fa-trash-o"></i> 회원탈퇴</a></li> -->
							</c:if>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>

	<script>
		var url = location.href;
	    var idxBoard = url.indexOf("board");
	    var idxAbout = url.indexOf("about");

	    if(idxBoard != -1) {
	        $("#board").addClass("active");
	        $("#home").removeClass("active");
	    }
	    if(idxAbout != -1) {
	        $("#about").addClass("active");
	        $("#home").removeClass("active");
	    }
	</script>
