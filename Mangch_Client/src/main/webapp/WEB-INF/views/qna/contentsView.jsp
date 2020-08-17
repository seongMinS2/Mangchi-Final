<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/min.css'/>">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/gh/xpressengine/xeicon@2.3.1/xeicon.min.css">
<style>
.btn {cursor:pointer;}

.comment_tool{
	position: absolute;
	right: 750px;
}

.layerMore{
	height: 50px;
	width: 50px;
	background-color: red;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
		<script type="text/javascript">
			$(function(){
				var idx = ${idx};
				var loginSession = `${loginInfo.mNick}`;
				console.log(loginSession);
				contentsList(idx, loginSession);
			});
		</script>
	<div class="contentBox"></div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>