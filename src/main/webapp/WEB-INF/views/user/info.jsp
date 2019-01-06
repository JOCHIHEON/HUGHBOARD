<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>

	<div class="container" style="max-width: 70%;">
		<div class="panel-body">
			<h2 style="margin-bottom: 40px">수정하기</h2>
			<form class="form-horizontal" action="/user/edit" method="post">
				<div class="form-group">
					<label for="uid" class="col-sm-2 control-label">아이디</label>
					<div class="col-sm-10">
						<input type="text" id="uid" name="uid" class="form-control" value="${uVO.uid  }" readonly="readonly">
					</div>
				</div>
				<div class="form-group">
					<label for="name" class="col-sm-2 control-label">이름</label>
					<div class="col-sm-10">
						<input type="text" id="name" name="name" class="form-control" value="${uVO.name  }">
					</div>
				</div>
				<div class="form-group">
					<label for="gender" class="col-sm-2 control-label">성별</label>
					<div class="col-sm-10">
						<input type="text" id="gender" name="gender" class="form-control" value="${uVO.gender  }" readonly="readonly">
					</div>
				</div>
				<div class="form-group">
					<label for="email" class="col-sm-2 control-label">이메일</label>
					<div class="col-sm-10">
						<input type="email" id="email" name="email" class="form-control" value="${uVO.email  }">
					</div>
				</div>
				<div class="form-group">
					<label for="joindate" class="col-sm-2 control-label">가입일</label>
					<div class="col-sm-10">
						<input type="text" id="joindate" class="form-control" value="<fmt:formatDate value="${uVO.joindate }" pattern="yyyy-MM-dd"/>" readonly="readonly">
					</div>
				</div>
				<div align="center">
					<input type="submit" class="btn btn-primary" value="정보 수정">
				</div>
			</form>
		</div>
	</div>

<%@ include file="../include/footer.jsp" %>