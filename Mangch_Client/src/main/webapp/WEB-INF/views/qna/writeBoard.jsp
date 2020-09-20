<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>MANGCH - QnA</title>
<link rel="stylesheet" href="<c:url value='/resources/css/min.css'/>">
</head>

<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<script type="text/javascript">
		$(function () {
			summer();
		});
	</script>
	<div class="writeContainer w3-margin-bottom">
		<h1>QnA 글 쓰기</h1>
		<hr class="w3-border-theme w3-topbar">
		<form id="qnaWriteForm" onsubmit="return false;">
			<input type="hidden" name="qnaWriter" id="qnaWriter" value="${loginInfo.mNick}">
			<label for="qnaTitle" class="w3-margin-left w3-margin-bottom">제목:</label><input type="text" class="w3-margin-left w3-margin-bottom" name="qnaTitle" id="qnaTitle" required>
			<label for="qnaPw" class="w3-margin-left w3-margin-bottom">글 비밀번호:</label><input type="password" class="w3-margin-left w3-margin-bottom" name="qnaPw" id="qnaPw">
			<textarea id="summernote" name="editordate" required></textarea>
			<button type="submit" class="w3-button w3-right w3-theme-l1 w3-margin-top" onclick="qnaWriteBoard()">글쓰기</button>
		</form>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	
</body>

</html>