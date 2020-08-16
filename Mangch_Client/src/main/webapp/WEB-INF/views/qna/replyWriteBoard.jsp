<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/min.css'/>">
</head>

<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<script type="text/javascript">
		$(function () {
			summer();
		});
	</script>
	<div class="writeContainer">
		<h1>QnA 답글 쓰기</h1>
		<hr>
		<form id="qnaWriteForm" onsubmit="return false;">
			<input type="hidden" name="qnaWriter" id="qnaWriter" value="${loginInfo.mNick}">
			<label for="qnaTitle">제목:</label><input type="text" name="qnaTitle" id="qnaTitle" required>
			<label for="qnaPw">글 비밀번호:</label><input type="password" name="qnaPw" id="qnaPw">
			<textarea id="summernote" name="editordate" required></textarea>
			<input type="submit" value="글쓰기" onclick="qnaWriteSubmit(${idx});">
		</form>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	
</body>

</html>