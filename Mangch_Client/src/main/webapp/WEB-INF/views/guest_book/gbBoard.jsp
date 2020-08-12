<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동네생활</title>
<link rel="stylesheet" href="<c:url value="/resources/css/kbg.css"/>">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script type="text/javascript" src='<c:url value="/resources/js/kbj.js"/>'></script>
</head>


<jsp:include page="/WEB-INF/views/include/header.jsp"/>


<!-- 
<h1>방명록작성</h1>
<form id="gbForm">
		Idx : <input type="text" nmae="guest_idx"  readonly="readonly"><br>
		write :<input type="text" nmae="guest_write" value="1" readonly="readonly"><br>
		내용 :<input type="text" nmae="guest_text"><br>
		photo :<input type="file" nmae="guest_photo"><br>
		주소 :<input type="text" nmae="guest_addr"><br>
		<input type="submit" value="글쓰기" ><br>
</form>
 -->



<h1>방명록 리스트</h1>
<hr>
<div id="guestbookList"></div>

<script>

$(document).ready(function () {
	
	gbList();

}); // 레디끝














</script>




<jsp:include page="/WEB-INF/views/include/footer.jsp"/>


</body>
</html>