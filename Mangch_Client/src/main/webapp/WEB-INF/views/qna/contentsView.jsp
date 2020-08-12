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
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />

	<div class="contentBox">
		<div class="header">
			<h1>제목 들어갈 자리</h1>
		</div>

		<div class="articleContainer">
			<div class="mainContainer">
				<p class="text">내용들어갈자리</p>
			</div>
			<div class="commentBox">
				<h3 class="comment_title">
					<b>댓글</b>
				</h3>
				<!-- 루프 돌릴 태그 -->
				<div class="comment_area">
					<div class="comment_Box">
						<div class="comment_nickBox">유저 닉네임 들어갈 자리</div>
						<div class="comment_textView">댓글 텍스트 들어갈자리</div>

						<div class="comment_info_box">
							<span class="comment_info_date"> 날짜정보들어갈 자리 </span> <a href="#">답글쓰기</a>
						</div>
					</div>
				</div>
				<div class="commentWriter">
					<div class="comment_inbox">
						<div class="comment_inbox_name">
							<p>닉네임 자리</p>
							<i class="xi-ellipsis-v"></i>
						</div>
						<div class="comment_inbox_text">
							<p>댓글 쓸 내용 들어갈 자리</p>
						</div>
						<div class="comment_submit">
							<button onclick="location.href='#'">등록</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="articleBottomBtns">
			<button onclick="location.href='#'">글쓰기</button>
			<button onclick="location.href='#'">답글</button>
			<button onclick="location.href='#'">TOP</button>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>