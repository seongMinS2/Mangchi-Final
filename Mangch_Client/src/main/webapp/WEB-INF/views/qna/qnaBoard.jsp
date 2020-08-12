<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="<c:url value='/resources/css/min.css'/>">
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.js"></script> -->
</head>

<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div class="qnaArea">
		QnA공간입니다.
		
		<hr>
		<h1>글 목록</h1>
		<hr>
		<button onclick="location.href='writeBoard'">글쓰기</button>
		<hr>
		<div id="QnABoardList"></div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

	<script src="<c:url value='/resources/js/min.js'/>"></script>
</body>

</html>