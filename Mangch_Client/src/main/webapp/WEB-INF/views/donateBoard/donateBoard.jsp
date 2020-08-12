<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>나눔 게시판</title>
<link rel="stylesheet" href="<c:url value="/resources/css/hong.css"/>">
 <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.12.4.js"></script> 
<script type="text/javascript"
	src='<c:url value="/resources/js/hong.js"/>'></script>

</head>

<jsp:include page="/WEB-INF/views/include/header.jsp" />
<div id="donateWrap">
	<h3>나눔 게시판</h3>

	<div id="topBox">

		<button class="w3-button w3-black w3-round-xlarge" id="writeForm" onclick="location.href='<c:url value="/donate/donateForm"/>'">글쓰기</button>
		<div id="searchBox">
			<form>
				<input type="text" placeholder="검색할 단어를 입력하세요"> <input
					type="submit" value="검색">
			</form>
		</div>


	</div>
	<div id="contentsBox">
		<div id="listBox"></div>
		<div id="categoryBox"></div>
	</div>
	<div id="pageBox"></div>


</div>

<div id="id01" class="w3-modal">
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />


</body>
</html>