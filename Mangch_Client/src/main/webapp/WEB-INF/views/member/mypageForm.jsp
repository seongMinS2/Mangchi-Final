<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />

	<h1>마이페이지</h1>

	<h1>session : ${loginInfo}</h1>



	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>