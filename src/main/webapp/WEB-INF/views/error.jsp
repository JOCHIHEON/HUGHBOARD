<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="./include/header.jsp"%>
<body>
	<div class="container">
		<div class="jumbotron">
			<h1>Error!</h1>
			<h2>에러가 발생했습니다. 관리자에게 문의해주세요.(zhixian030@gmail.com)</h2>
			<font color="red"> <c:out value="${msg}"></c:out>
			</font>
		</div>
	</div>
</body>
</html>