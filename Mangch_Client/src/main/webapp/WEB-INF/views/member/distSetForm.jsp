<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<link rel="stylesheet"
	href="<c:url value='/resources/css/member/mypage.css'/>">

</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div class="w3-container container">
		<h2>거리 설정</h2>
		<hr>
		<p>session : ${loginInfo} ${loginInfo.mIdx}</p>

		<div class="w3-cell-row">
			<div class="w3-cell">
				<div id="profile-menu" class="active">
					<a href="requestListForm">요청 리스트</a> 
					<a href="lendingListForm">대여리스트</a>
					<a href="reviewListForm">나의 리뷰</a> 
					<a href="commentListForm">나의 댓글</a> 
					<a href="mypageForm">나의 정보</a> 
					<a href="distSetForm">거리 설정</a> 
					<a href="keywordSetForm">키워드 설정</a>
				</div>
			</div>
			<div class="w3-cell">
				<div id="memberList">
					
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

</body>
</html>