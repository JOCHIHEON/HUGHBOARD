<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>

	<!-- 검색 -->
	<div class="container">
		<div class="panel-body">
			<div class="nav" role="navigation" style="margin-bottom: 10px">
				<a href="/boards/new" class="create btn btn-success btn-wide pull-right">
					<i class="fa fa-pencil"></i> 새 글 쓰기
				</a>
				<h2>게시판</h2>
				<div class="category-filter-wrapper">
					<div class="category-filter-query pull-right">
						<div class="input-group input-group-sm">
							<input type="search" name="query" id="query" class="form-control" placeholder="검색어" value="${cri.query }" />
							<span class="input-group-btn">
								<button id="search-btn" class="btn btn-default">
									<i class="fa fa-search"></i>
								</button>
							</span>
						</div>
					</div>
	
					<ul class="list-sort pull-left">
						<li>
							<a id="bno" href="/boards?sort=bno&query=${cri.query }" class="category-sort-link active">최신순</a>
						</li>
						<li>
							<a id="likecnt" href="/boards?sort=likecnt&query=${cri.query }" class="category-sort-link ">추천순</a>
						</li>
						<li>
							<a id="replycnt" href="/boards?sort=replycnt&query=${cri.query }" class="category-sort-link ">댓글순</a>
						</li>
						<li>
							<a id="viewcnt" href="/boards?sort=viewcnt&query=${cri.query }" class="category-sort-link ">조회순</a>
						</li>
					</ul>
				</div>
			</div>
		</div>

		<!-- 테이블 -->
		<div class='box-body'>
			<div class="table-responsive">
				<table class="table table-hover">
					<tr>
						<th width="550px">제목</th>
						<th width="100px">댓글</th>
						<th width="100px">추천</th>
						<th width="100px">조회</th>
						<th colspan="2">작성자</th>
					</tr>
					<c:forEach var="bVO" items="${list }">
					<tr>
						<td rowspan="2">
							<font size="2" color="gray">&nbsp;&#35; <i>${bVO.bno }</i></font>&nbsp;&nbsp;
							<a href="/boards/${bVO.bno }">${bVO.title }</a>
						</td>
						<td rowspan="2">
							<i class="fa fa-comment"></i> ${bVO.replycnt }
						</td>
						<td rowspan="2">
							<i class="fa fa-heart"></i> ${bVO.likecnt }
						</td>
						<td rowspan="2">
							<i class="fa fa-eye"></i> ${bVO.viewcnt }
						</td>
						
						<td width="200px">${bVO.writer }</td>
					</tr>
					<tr>
						<fmt:formatDate var="regdate" value="${bVO.regdate }" pattern="yyyy-MM-dd hh:mm:ss"/>
						<td width="200px">${regdate }</td>
					</tr>
					</c:forEach>
				</table>
			</div>
			<div align="center">
				<c:if test="${pageMaker.totalCount == 0 }">
					<font size="4" color="gray">글이 없습니다.</font>
				</c:if>
			</div>
		</div>
	</div>

	<!-- 페이징 -->
	<div class="container" align="center" style="margin-bottom: 20px">
		<nav>
			<ul class="pagination">
				<c:if test="${pageMaker.prev }">
				<li>
					<a href="${pageMaker.startPage - pageMaker.displayPageNum }">&laquo;</a>
				</li>
				</c:if>
				<c:forEach var="idx" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
				<li	<c:out value="${pageMaker.cri.page == idx ? 'class=active' : '' }"></c:out>>
					<a href="${idx }">${idx }</a>
				</li>
				</c:forEach>
				<c:if test="${pageMaker.next }">
				<li> 
					<a href="${pageMaker.startPage + pageMaker.displayPageNum }">&raquo;</a>
				</li>
				</c:if>
			</ul>
		</nav>
	</div>
	
	<!-- 페이징 관련 부가 정보 -->
	<form id="list-form">
		<input type="hidden" name="page">
		<input type="hidden" name="query">
		<input type="hidden" name="sort">
	</form>
	
	<!-- 페이징 부가정보 전송 -->
	<script>
		$(".pagination li a").click(function(event) {
			event.preventDefault();
			
			var page = $(this).attr("href");
			var query = "${cri.query }";
			var sort = "${cri.sort }";
			
			var listForm = $("#list-form");
			
			listForm.find("[name='page']").val(page);
			listForm.find("[name='query']").val(query);
			listForm.find("[name='sort']").val(sort);
			listForm.attr("action", "/boards").attr("method", "GET");
			listForm.submit();
		});
	</script>
	
	<!-- 글 검색 기능 -->
	<script>
		$("#search-btn").click(function() {
			var query = $("#query").val();
			var sort = "${cri.sort }";
			
			if (sort == null || sort == "") {
				sort = "bno";
			}
			
			location.href="/boards?sort=" + sort + "&query=" + query;
		});
	</script>
	
	<!-- 상단 메뉴바 활성화 여부 -->
	<script>
		var url = location.href;
		var idxLikecnt = url.indexOf("sort=likecnt");
		var idxReplycnt = url.indexOf("sort=replycnt");
		var idxViewcnt = url.indexOf("sort=viewcnt");
		
	    if(idxLikecnt != -1) {
	        $("#likecnt").addClass("active");
	        $("#bno").removeClass("active");
	    }
	    if(idxReplycnt != -1) {
	        $("#replycnt").addClass("active");
	        $("#bno").removeClass("active");
	    }
	    if(idxViewcnt != -1) {
	        $("#viewcnt").addClass("active");
	        $("#bno").removeClass("active");
	    }
	</script>

<%@ include file="../include/footer.jsp" %>