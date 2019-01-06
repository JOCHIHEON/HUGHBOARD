<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

	<div class="container" style="max-width: 70%;">
		<div class="panel-body">
			<h2>수정하기</h2>
			<form action="/boards/${bVO.bno }" method="post" id="edit-form" class="create-form">
				<input type="hidden" name="_method" value="PUT">
				<fieldset class="form">
					<div class="form-group  has-feedback">
						<div class="form-group">
							<input class="form-control" type="text" name="title" value="${bVO.title }">
						</div>
						<div class="form-group">
							<textarea class="form-control" name="content" style="height: 200px; resize: none">${bVO.title }</textarea>
						</div>
					</div>
					<hr color="gray">
					<div class="form-group" style="margin-top: 30px">
						<label>아래 영역에 첨부하실 파일을 올려주세요.</label>
						<div class="fileDrop">
						</div>
					</div>
					<ul class="mailbox-attachments clearfix uploadedList">
					</ul>
					<div class="popup back" style="display: none;">
						<div id="popup_front" class="popup front" style="display: none;"></div>
						<img id="popup_img">
					</div>
					<div>
						<hr color="gray">
					</div>
					<div class="nav" role="navigation">
						<fieldset class="buttons">
							<a href="/boards" class="btn btn-default btn-wide" onclick="return confirm('정말로 취소하시겠습니까?')">취소</a> 
							<input type="submit" class="create btn btn-success btn-wide pull-right" value="저장">
						</fieldset>
					</div>
				</fieldset>
			</form>
		</div>
	</div>
	
	<!--첨부파일 템플릿 -->
	<script id="edit-attached-template" type="text/x-handlebars-template">
		<li data-src="{{fullName}}">
			<span class="mailbox-attachment-icon has-img">
				<img src="{{imgSrc}}" alt="Attachment">
			</span>
			<div class="mailbox-attachment-info">
				<a href="{{getLink}}" class="mailbox-attachment-name">{{fileName}}</a>
				<a href="{{fullName}}" class="btn btn-default btn-xs pull-right del-btn">
					<i class="fa fa-fw fa-remove"></i>
				</a>
			</div>
		</li>
	</script>
	
	<!-- 첨부파일 업로드 -->
	<script>
		var source = $("#edit-attached-template").html();
		var template = Handlebars.compile(source);
		
		$(".fileDrop").on("dragenter dragover", function(event) {
			event.preventDefault();
		});
		
		$(".fileDrop").on("drop", function(event) {
			event.preventDefault();
			
			var bno = "${bVO.bno}";
			
			var files = event.originalEvent.dataTransfer.files;
			var file = files[0];
			
			var formData = new FormData();
			formData.append("file", file);
			
			$.ajax({
				type:"POST",
				url:"/boards/" + bno + "/uploadFile",
				data:formData,
				processData:false,
				contentType:false,
				dataType:"text",
				success:function(result) {
					var fileInfo = getFileInfo(result);
					var html = template(fileInfo);
					
					$(".uploadedList").append(html);
				}
			});
		});
	</script>	
	
	<!-- 첨부파일 리스트 얻기 -->	
	<script>	
		getAttachList();
		
		function getAttachList() {
			var bno = "${bVO.bno}";
			var source = $("#edit-attached-template").html();
			var template = Handlebars.compile(source);
			
			$.ajax({
				type:"GET",
				url:"/boards/" + bno + "/attaches",
				dataType:"json",
				success:function(result) {
					$(result).each(function() {
						var fileInfo = getFileInfo(this);
						var html = template(fileInfo);
						
						$(".uploadedList").append(html);
					});
				}
			});
		}
	</script>
		
	<!-- 첨부파일 변경사항 처리 -->
	<script>
		var deleteFiles = [];
		
		$(".uploadedList").on("click", ".del-btn" ,function(event){
			event.preventDefault();
			
			$(this).closest("li").each(function(index) {
				deleteFiles.push($(this).attr("data-src"));
			});
			
			$(this).closest("li").remove();
		});
		
		$("#edit-form").submit(function(event) {
			event.preventDefault();
			
			var that = $(this);
			var bno = "${bVO.bno}";
			var str = "";
			
			$(".uploadedList .del-btn").each(function (index) {
				str += "<input type='hidden' name='files[" + index + "]' value='" + $(this).attr("href") + "' >";
			});
			
			if (deleteFiles.length > 0) {
				$.ajax({
					type:"POST",
					url:"/boards/" + bno + "/deleteAllFiles",
					data:{files:deleteFiles}
				});
			}
			
			that.append(str);
			that.get(0).submit();
		});
	</script>
	
<%@ include file="../include/footer.jsp" %>