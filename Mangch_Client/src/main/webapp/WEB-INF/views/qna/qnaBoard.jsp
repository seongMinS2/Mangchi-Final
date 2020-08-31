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
<style>
a {
 text-decoration:none 
}
</style>
</head>

<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />

	<script type="text/javascript">
		$(function() {
			qnaboardList();
		});
	</script>

	<div class="qnaArea">
		<h1>QnA</h1>
		<hr class="w3-border-theme w3-topbar">
		<div style="height: 42px;" class="qna-util-bar ">
			<button class="w3-button w3-theme-l1" onclick="location.href='writeBoard'">글쓰기</button>
			<button class="w3-right w3-button w3-theme-l1" style="height: inherit;" id="SearchButton">검색</button>
			<input type="text" class="w3-right" style="height: inherit;" id="keyword" name="keyword">
			<select class="w3-right" style="height: inherit;" id="searchType" name="searchType">
				<option value="SearchAll">제목+내용</option>
				<option value="SearchTitle">제목</option>
				<option value="SearchText">내용</option>
				<option value="SearchNick">작성자</option>
			</select>
		</div>
		<hr class="w3-border-theme">
		<div id="QnABoardList" class="w3-center"></div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

</body>

</html>