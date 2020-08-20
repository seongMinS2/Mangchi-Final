<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="<c:url value='/resources/css/summernote/summernote-lite.css'/>">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<!-- summernote -->
<script
	src="<c:url value='/resources/js/summernote/summernote-lite.js'/>"></script>
<script
	src="<c:url value='/resources/js/summernote/lang/summernote-ko-KR.js'/>"></script>

<script src="<c:url value='/resources/js/qnaSummernote.js'/>"></script>
<!-- 성민 자바스크립트 -->
<script src="<c:url value='/resources/js/min.js'/>"></script>
<!-- 보겸 자바스크립트 -->
<script type="text/javascript"
	src='<c:url value="/resources/js/jquery.bpopup.min.js"/>'></script>
<script type="text/javascript"
	src='<c:url value="/resources/js/readmore.js"/>'></script>
<!-- moment() : 날짜 포멧팅 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.27.0/moment.min.js"></script>
<style>
body, h1, h2, h3, h4, h5, h6 {
	font-family: "Raleway", sans-serif
}

body, html {
	height: 100%;
	line-height: 1.8;
}

/* Full height image header */
.bgimg-1 {
	background-position: center;
	background-size: cover;
	background-image: url("z.jpg");
	min-height: 100%;
}

.w3-bar .w3-button {
	padding: 16px;
}
</style>
<header>

	<!-- Navbar (sit on top) -->
	<div class="w3-top">
		<div class="w3-bar w3-white w3-card" id="myNavbar">
			<a href="#home" class="w3-bar-item w3-button w3-wide">LOGO</a>
			<!-- Right-sided navbar links -->
			<div class="w3-center w3-hide-small">
				<input type="text"><input type="submit" value="검색">
			</div>

			<!-- Hide right-floated links on small screens and replace them with a menu icon -->

			<a href="javascript:void(0)"
				class="w3-bar-item w3-button w3-right w3-hide-large w3-hide-medium"
				onclick="w3_open()"> <i class="fa fa-bars"></i>
			</a>
		</div>
		<div class="w3-bar w3-white w3-card" id="myNavbar">
			<div class="w3-right w3-hide-small">
				<a href="<c:url value="/member/memberReg"/>"
					class="w3-bar-item w3-button">회원가입</a> <a
					href="<c:url value="/member/memberLogin"/>"
					class="w3-bar-item w3-button">로그인</a>
				<c:if test="${!empty loginInfo }">
					<a href="<c:url value="/member/memberMypage/mypageForm"/>"
						class="w3-bar-item w3-button">마이페이지</a>
				</c:if>
				<a href="<c:url value="/request/requestList"/>"
					class="w3-bar-item w3-button">요청게시판</a> <a
					href="<c:url value="/donateBoard"/>" class="w3-bar-item w3-button">나눔게시판</a>
				<a href="<c:url value="/guest_book/gbBoard"/>"
					class="w3-bar-item w3-button">동네생활</a> <a
					href="<c:url value="/qna/qnaBoard"/>" class="w3-bar-item w3-button">Q&A</a>
				<a href="<c:url value="/chat"/>" class="w3-bar-item w3-button">채팅</a>
			</div>
		</div>
	</div>

	<!-- Sidebar on small screens when clicking the menu icon -->
	<nav
		class="w3-sidebar w3-bar-block w3-black w3-card w3-animate-left w3-hide-medium w3-hide-large"
		style="display: none" id="mySidebar">
		<a href="javascript:void(0)" onclick="w3_close()"
			class="w3-bar-item w3-button w3-large w3-padding-16">Close ×</a> <a
			href="<c:url value="/member/memberReg"/>" onclick="w3_close()"
			class="w3-bar-item w3-button">회원가입</a> <a
			href="<c:url value="/member/memberLogin"/>" onclick="w3_close()"
			class="w3-bar-item w3-button">로그인</a>
		<c:if test="${!empty loginInfo }">
			<a href="<c:url value="/member/memberMypage/mypageForm"/>"
				onclick="w3_close()" class="w3-bar-item w3-button">마이페이지</a>
		</c:if>
		<a href="<c:url value="/request/requestList"/>" onclick="w3_close()"
			class="w3-bar-item w3-button">요청게시판</a> <a
			href="<c:url value="/donateBoard"/>" onclick="w3_close()"
			class="w3-bar-item w3-button">나눔게시판</a> <a
			href="<c:url value="/guest_book/gbBoard"/>" onclick="w3_close()"
			class="w3-bar-item w3-button">동네생활</a> <a
			href="<c:url value="/qna/qnaBoard"/>" onclick="w3_close()"
			class="w3-bar-item w3-button">Q&A</a> <a
			href="<c:url value="/chat"/>" onclick="w3_close()"
			class="w3-bar-item w3-button">채팅</a> <input type="text"><input
			type="submit" value="검색">
	</nav>
	<div style="height: 150px;" id="ddd"></div>
</header>