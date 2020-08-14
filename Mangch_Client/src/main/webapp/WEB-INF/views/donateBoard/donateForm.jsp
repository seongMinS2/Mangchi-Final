<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>나눔 글쓰기</title>
</head>
<%-- <c:if test="${loginInfo==null}">
	<script>
		alert('나눔 글쓰기는 로그인 한 사용자만 가능합니다.');
		location.href="<c:url value='/member/loginForm'/>";
	</script>
</c:if> --%>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<!-- <script>
	$(document).ready(function() {
		$('#summernote').summernote({
			minHeight : 370,
			maxHeight : null,
			focus : true,
			lang : 'ko-KR',
			toolbar: [
			    ['fontname', ['fontname']],
			    ['fontsize', ['fontsize']],
			    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
			    ['color', ['forecolor','color']],
			    ['table', ['table']],
			    ['para', ['ul', 'ol', 'paragraph']],
			    ['height', ['height']],
			    ['view', ['fullscreen', 'help']]
			  ],
			fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
		});
	});
	

</script> -->
<script type="text/javascript" src='<c:url value="/resources/js/hong.js"/>'></script>
<link rel="stylesheet" href="<c:url value='/resources/css/hong.css'/>">
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
