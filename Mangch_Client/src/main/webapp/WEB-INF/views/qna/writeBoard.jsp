<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- summernote -->
<script
	src="<c:url value='/resources/js/summernote/summernote-lite.js'/>"></script>
<script
	src="<c:url value='/resources/js/summernote/lang/summernote-ko-KR.js'/>"></script>
<link rel="stylesheet"
	href="<c:url value='/resources/css/summernote/summernote-lite.css'/>">
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<h1>QnA 글 쓰기</h1>
	<hr>


	<form method="post">
		<label for="title">제목:</label><input type="text" name="title" id="title" required> <label for="pw">
			글 비밀번호:</label><input type="text" name="pw" id="pw">
		<textarea id="summernote" name="editordate" required></textarea>
		<input type="submit" value="글쓰기">
	</form>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<script src="<c:url value='/resources/js/qnaSummernote.js'/>"></script>
</body>
</html>