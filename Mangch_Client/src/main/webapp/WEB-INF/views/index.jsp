<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<div class="w3-center" id="main-image">
	<img src="https://i.ibb.co/XFwdjvr/backgroud.jpg" alt="backgroud" border="0" style="width:80%; min-width: 360px">
</div>
<div class="w3-content w3-center w3-light-grey">
	ㅎㅇㅎㅇ
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
<script>
$(document).ready(function(){ 
    $('#main-image').css('width', $(window).width()); 
   // $('#main-image').css('height', $(window).height()); 
    $(window).resize(function() { 
        $('#main-image').css('width', $(window).width()); 
    }); 
});
</script>
</body>
</html>