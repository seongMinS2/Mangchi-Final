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
	
<script type="text/javascript">
$(function(){
	qnaboardList();
});
</script>

	<div class="qnaArea">
		QnA공간입니다.
		
		<hr>
		<h1>글 목록</h1>
		<hr>
		<button onclick="location.href='writeBoard'">글쓰기</button>
		<hr>
		<div id="QnABoardList" class="w3-center"></div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

</body>

</html>