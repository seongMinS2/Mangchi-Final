<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>MANGCH - QnA</title>

<link rel="stylesheet" href="<c:url value='/resources/css/min.css'/>">
<!-- <script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.js"></script> -->
<style>
a {
	text-decoration: none;
}

.qna-board-title {
	position: relative;
}

#pw-modal-container {
	padding: 30px;
	margin-top: 20%;
}

#pw-modal-content {
	width: 400px;
}

#modal-pw-check-message {
	color: red;
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
			<c:if test="${loginInfo != null}">
				<button class="w3-button w3-theme2-l1"
					onclick="location.href='writeBoard'">글쓰기</button>
			</c:if>
			<button class="w3-right w3-button w3-theme2-l1"
				style="height: inherit;" id="SearchButton">검색</button>
			<input type="text" class="w3-right" style="height: inherit;"
				id="keyword" name="keyword"> <select class="w3-right"
				style="height: inherit;" id="searchType" name="searchType">
				<option value="SearchAll">제목+내용</option>
				<option value="SearchTitle">제목</option>
				<option value="SearchText">내용</option>
				<option value="SearchNick">작성자</option>
			</select>
		</div>
		<hr class="w3-border-theme">
		<div id="QnABoardList" class="w3-center"></div>
	</div>

	<!-- 비밀번호 입력 모달창 -->
	<div class="w3-container">
		<div id="pwModal" class="w3-modal ">
			<div class="w3-modal-content w3-round-xlarge w3-animate-top"
				id="pw-modal-content">
				<div class="w3-container w3-center" id="pw-modal-container">
					<p>비밀글 입니다.</p>
					<label for="board-pw">비밀번호: </label> <input type="password"
						name="board-pw" id="board-pw"> <br>
					<p id="modal-pw-check-message">비밀번호가 틀립니다.</p>
					<button
						class="comment_modify_cancel w3-button w3-theme-l1 w3-margin-right w3-margin-top"
						id="pw-check-button">확인</button>
					<button
						class="comment_modify_cancel w3-button w3-theme-l4 w3-margin-top"
						id="pw-check-cansel-button" onclick="pwCheckCansel()">취소</button>
				</div>
			</div>
		</div>
	</div>


	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<script>
		
	</script>
</body>

</html>