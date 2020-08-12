<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>나눔 글쓰기</title>
<link rel="stylesheet" href="<c:url value="/resources/css/hong.css"/>">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript" src='<c:url value="/resources/js/hong.js"/>'></script>
<title>글쓰기</title>

<script>
	$(document).ready(function() {
		$('#summernote').summernote({
			placeholder : '2048자까지 작성이 가능합니다.',
			minHeight : 370,
			maxHeight : null,
			focus : true,
			lang : 'ko-KR',
			callback : {
				onImageUpload : function(files) {
					uploadSummernoteImageFile(files[0], this);
			}
		});
	});
</script>
</head>

<jsp:include page="/WEB-INF/views/include/header.jsp" />
<div id="donateFormWrap">
<div style="width: 60%; margin: auto;">
	<form method="post" action="/donate/donateBoard">
		<input type="text" name="writer" style="width: 20%;" placeholder="작성자"/><br>
		<input type="text" name="title" style="width: 40%;" placeholder="제목"/>
		<br><br> 
		<textarea id="summernote" name="content"></textarea>
		<input id="subBtn" type="button" value="글 작성" style="float: right;" onclick="goWrite(this.form)"/>
	</form>
</div>


</div>



<jsp:include page="/WEB-INF/views/include/footer.jsp" />


</body>
</html>