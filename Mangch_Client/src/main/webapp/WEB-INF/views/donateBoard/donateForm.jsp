<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>나눔 글쓰기</title>
<link rel="stylesheet" href="<c:url value='/resources/css/hong.css'/>">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript"
	src='<c:url value="/resources/js/hong.js"/>'></script>

<!-- summernote -->
<script
	src="<c:url value='/resources/js/summernote/summernote-lite.js'/>"></script>
<script
	src="<c:url value='/resources/js/summernote/lang/summernote-ko-KR.js'/>"></script>
<link rel="stylesheet"
	href="<c:url value='/resources/css/summernote/summernote-lite.css'/>">
</head>

</head>


<body>
<c:if test="${empty loginInfo}">
	<script>
		alert('나눔 글쓰기는 로그인 한 사용자만 가능합니다.');
		location.href="<c:url value='/member/loginForm'/>";
	</script>
</c:if>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<script>
	$(document).ready(function() {
		$('#summernote').summernote({
			minHeight : 370,
			maxHeight : null,
			focus : true,
			lang : 'ko-KR',
			toolbar : {
				image : [],
				link : [],
				air : []
			}
		});
	});
</script>

<div id="donateFormWrap">
	<div style="width: 60%; margin: auto;">
		<form id="regForm" onsubmit="return false">
			<input type="hidden" id="doLoc" name="doLoc" value="${loginInfo.mAddr}">
			<input type="hidden" value="${loginInfo.mLttd}">
			<input type="hidden" value="${loginInfo.mLgtd}">
			<input type="text" id="writer" name="writer" style="width: 20%;" value="${loginInfo.mNick}" readonly /><br> 
				<input type="text" id="title" name="title" style="width: 40%;" placeholder="제목" /> <br> <br>
			<textarea id="summernote" name="content"></textarea>
			<input type="file" name="doImg" id="doImg" style="display:block;">
			<input type="reset" style="float: right;" />
			<input type="submit" value="글 작성" style="float: right;"
				onclick="goWrite()" />
		</form>
	</div>


</div>



<jsp:include page="/WEB-INF/views/include/footer.jsp" />


</body>
</html>
