<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<c:url value="/resources/css/w3.css"/>">
<link rel="stylesheet" href="<c:url value='/resources/css/theme.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/theme2.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/theme3.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/theme4.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/theme5.css'/>">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="<c:url value='/resources/css/summernote/summernote-lite.css'/>">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<!-- summernote -->
<script src="<c:url value='/resources/js/summernote/summernote-lite.js'/>"></script>
<script src="<c:url value='/resources/js/summernote/lang/summernote-ko-KR.js'/>"></script>
<script src="<c:url value='/resources/js/qnaSummernote.js'/>"></script>
<!-- 성민 자바스크립트 -->
<script src="<c:url value='/resources/js/min.js'/>"></script>
<!-- 보겸 자바스크립트 -->
<script type="text/javascript" src='<c:url value="/resources/js/jquery.bpopup.min.js"/>'></script>
<script type="text/javascript" src='<c:url value="/resources/js/readmore.js"/>'></script>
<!-- moment() : 날짜 포멧팅 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.27.0/moment.min.js"></script>
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
fieldset.side-field-set {
  width: 300px;
  position: relative;
  display: inline-block;
  padding: 0 0 0 10px;
  background: #fff;
  border: none;
  border-radius: 5px;
}
input[name=side-search-input],
button[name=side-search-btn] {
  position: relative;
  width: 200px;
  height: 50px;
  padding: 0;
  display: inline-block;
  float: left;
}

input[name=side-search-input] {
  color: #666;
  width: 200px;
  z-index: 2;
  border: 1px solid #3f51b5;
  padding-left:20px;
}

fieldset.main-field-set {
  width: 350px;
  position: relative;
  display: inline-block;
  padding: 0 0 0 50px;
  background: #fff;
  border: none;
  border-radius: 5px;
}
input[name=main-search-input],
button[name=main-search-btn] {
  position: relative;
  width: 200px;
  height: 50px;
  padding: 0;
  display: inline-block;
  float: left;
}

input[name=main-search-input] {
  color: #666;
  width: 250px;
  z-index: 2;
  border: 1px solid #3f51b5;
  padding-left:30px;
}
input.headSearchInput:focus {
  outline: 0 none;
}
input.headSearchInput:focus + button.headSearchBtn {
  -webkit-transform: translate(0, 0);
      -ms-transform: translate(0, 0);
          transform: translate(0, 0);
  -webkit-transition-duration: 0.3s;
          transition-duration: 0.3s;
}
input.headSearchInput:focus + button.headSearchBtn .fa {
  -webkit-transform: translate(0px, 0);
      -ms-transform: translate(0px, 0);
          transform: translate(0px, 0);
  -webkit-transition-duration: 0.3s;
          transition-duration: 0.3s;
  color: #fff;
}

button.headSearchBtn{
  z-index: 1;
  width: 49px;
  border: 0 none;
  background: #3f51b5;
  cursor: pointer;
  border-radius: 0 5px 5px 0;  
  -webkit-transform: translate(-50px, 0);
      -ms-transform: translate(-50px, 0);
          transform: translate(-50px, 0);
  -webkit-transition-duration: 0.3s;
          transition-duration: 0.3s;
}

.searchMainIcon {
  font-size: 1.4rem;
  color: #3f51b5;
  z-index: 3;
  top: 25%;
  -webkit-transform: translate(-240px, 0);
      -ms-transform: translate(-240px, 0);
          transform: translate(-240px, 0);
  -webkit-transition-duration: 0.3s;
          transition-duration: 0.3s;
  -webkit-transition: all 0.1s ease-in-out;
          transition: all 0.1s ease-in-out;
}
.searchSideIcon {
  font-size: 1.4rem;
  color: #664ACC;
  z-index: 3;
  top: 25%;
}
</style>
<!-- 헤드컨테이너 밑에 붙이기 -->
<div class="w3-row w3-theme w3-hide-small">
	<div class="w3-content">
		<div class="w3-col">
			<c:if test="${empty loginInfo }">
			<a href="<c:url value="/member/memberReg"/>" class="w3-bar-item w3-button w3-right">회원가입</a> 
			<a href="<c:url value="/member/memberLogin"/>" class="w3-bar-item w3-button w3-right">로그인</a>
			</c:if>
			<c:if test="${!empty loginInfo }">
			<a href="<c:url value="/member/kakao/logout"/>" class="w3-bar-item w3-button w3-right">로그아웃</a>
			<a href="<c:url value="/member/memberMypage/mypageForm"/>" class="w3-bar-item w3-button w3-right">마이페이지</a>
			</c:if>
		</div>
	</div>
</div>
<header style="position: sticky; top: 0; z-index: 1;">
	<div class="headContainer w3-row w3-white w3-border-bottom w3-border-theme">
		<div class="w3-content">
			<div class="w3-col s6 m3 w3-padding-16 w3-center"> 
				<a href="<c:url value="/"/>" class="w3-row">
					<img src="<c:url value="/resources/img/LOGO.png"/>" style="width: 145px;"/>
				</a>
			</div>
			<div class="w3-col m6 w3-hide-small">
				<div class="w3-center w3-text-theme w3-padding">
					<b>우리 동네 렌탈서비스</b>
				</div>
				<div class="w3-row w3-center" style="height: 75px;"> 
					<fieldset class="main-field-set">
						<input type="search" name="main-search-input" class="headSearchInput"/>
						<button type="submit"  name="main-search-btn" class="headSearchBtn"><i class="fa fa-search searchMainIcon"></i></button>
					</fieldset>
				</div>
			</div>
			<div class="w3-col s6 m3 w3-hide-medium w3-hide-large w3-padding-32 w3-padding-large">
				<a href="javascript:void(0)" class="w3-button w3-right w3-text-theme" onclick="w3_open()"> 
					<i class="fa fa-bars w3-xlarge"></i>
				</a>
			</div> 
		</div>
	</div>
	<div class="w3-row">
		<div style="border-bottom: 2px solid;" class="w3-col w3-center w3-hide-small w3-white w3-border-theme">
			<a href="<c:url value="/request/requestList"/>" class="w3-bar-item w3-button">요청게시판</a>
			<a href="<c:url value="/donateBoard"/>" class="w3-bar-item w3-button">나눔게시판</a>
			<a href="<c:url value="/guest_book/gbBoard"/>" class="w3-bar-item w3-button">동네생활</a> 
			<a href="<c:url value="/qna/qnaBoard"/>" class="w3-bar-item w3-button">Q&A</a>
			<a href="<c:url value="/chat"/>" class="w3-bar-item w3-button">채팅</a>
		</div>
	</div>

	<!-- Sidebar on small screens when clicking the menu icon -->
	<nav
		class="w3-sidebar w3-bar-block w3-border-theme w3-rightbar w3-card w3-animate-left w3-hide-medium w3-hide-large"
		style="display: none; width: 280px;" id="mySidebar">
		<a href="javascript:void(0)" onclick="w3_close()" 
			class="w3-bar-item w3-button w3-large w3-theme w3-padding-16 w3-right-align">Close X</a> 
		<c:if test="${empty loginInfo }">
		<a href="<c:url value="/member/memberReg"/>" onclick="w3_close()" class="w3-bar-item w3-button w3-padding-16">회원가입</a> 
		<a href="<c:url value="/member/memberLogin"/>" onclick="w3_close()" class="w3-bar-item w3-button w3-padding-16">로그인</a>
		</c:if>
		<c:if test="${!empty loginInfo }">
			<a href="<c:url value="/member/memberMypage/mypageForm"/>" onclick="w3_close()" class="w3-bar-item w3-button w3-padding-16">마이페이지</a>
			<a href="<c:url value="/member/kakao/logout"/>" onclick="w3_close()" class="w3-bar-item w3-button w3-padding-16">로그아웃</a>
		</c:if>
		<a href="<c:url value="/request/requestList"/>" onclick="w3_close()" class="w3-bar-item w3-button w3-padding-16">요청게시판</a> 
		<a href="<c:url value="/donateBoard"/>" onclick="w3_close()" class="w3-bar-item w3-button w3-padding-16">나눔게시판</a> 
		<a href="<c:url value="/guest_book/gbBoard"/>" onclick="w3_close()" class="w3-bar-item w3-button w3-padding-16">동네생활</a> 
		<a href="<c:url value="/qna/qnaBoard"/>" onclick="w3_close()" class="w3-bar-item w3-button w3-padding-16">Q&A</a> 
		<a href="<c:url value="/chat"/>" onclick="w3_close()" class="w3-bar-item w3-button w3-padding-16">채팅</a>
			<div class="w3-center w3-left">
				<fieldset class="side-field-set">
				<input type="search" name="side-search-input" class="headSearchInput" placeholder=""/>
				<button type="submit" name="side-search-btn" class="headSearchBtn"><i class="fa fa-search searchSideIcon"></i></button>
				</fieldset>
			</div>
	</nav>
</header>
<main>

