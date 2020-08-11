<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>


<jsp:include page="/WEB-INF/views/include/header.jsp"/>



안녕하세요

<h1>방명록 리스트</h1>
<hr>
<div id="guestbookList"></div>

<script>

$(document).ready(function () {
	
	
	
});


function viewList() {
	
	$.ajax({
		url:'localhost:8080/guest/guest_book' ,
		type:'get',
		success : function (data) {
			alert(JSON.stringify(data));
			$('#guestbookList').html(JSON.stringify(data));
		}
		
		
	});
	
}


</script>

<jsp:include page="/WEB-INF/views/include/footer.jsp"/>


</body>
</html>