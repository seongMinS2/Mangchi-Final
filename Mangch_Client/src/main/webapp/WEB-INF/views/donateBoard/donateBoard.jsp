<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>나눔 게시판</title>
</head>
<jsp:include page="/WEB-INF/views/include/header.jsp" />

<script type="text/javascript"
	src='<c:url value="/resources/js/hong.js"/>'></script>
<link rel="stylesheet" href="<c:url value="/resources/css/hong.css"/>">
<div id="donateWrap">
	<h3>나눔 게시판</h3>
	<c:if test="${loginInfo!=null}">
		<input type="hidden" id="loginUser" value="${loginInfo.mNick}">
	</c:if>

	<div id="contentsBox">
		<div id="listBox"></div>
		<div id="categoryBox" style="paddind:10px;">
			<button class="w3-button w3-block w3-theme-l5" id="writeForm" onclick="location.href='<c:url value="/donateForm"/>'">글쓰기</button>
			<form>
				<input type="text" id="searchKey" name="searchKey" placeholder="닉네임 혹은 제목을 검색하세요" style="width: 60%;"> 
				<input type="button" id="searchBar" class="w3-button w3-theme-l3" style="width: 30%;" value="검색">
			</form>

		</div>
	</div>
	<div id="pageBox"></div>


</div>
<div id="moreView" class="w3-theme-l5" style="width:100%; height: 50px; text-align:center;"></div>

<div id="id01" class="w3-modal"></div>
<div id="donateEdit" class="w3-modal"></div>
<div id="keywordNot" class="w3-modal"></div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />

</body>
</html>
