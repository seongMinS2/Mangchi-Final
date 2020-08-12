<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동네생활</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<link rel="stylesheet" href="<c:url value="/resources/css/kbg.css"/>">
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
	
	$.ajax({
		url:'http://localhost:8080/guest/guest_book' ,
		type:'get',
		success : function (data) {
			
			var html='';
			for(var i=0; i<data.length; i++){
				 html +='<article>';
	             html +='<header>'
	             html +='<div class="hd_img"><img src="https://img1.daumcdn.net/thumb/R720x0.q80/?scode=mtistory2&fname=http%3A%2F%2Fcfile26.uf.tistory.com%2Fimage%2F2369374A56F366BB34731F"></div>'
	             html +='<div class="hd_nick">'+data[i].guest_write+'</div>'
	             html +='</header>'
	             html +='<div class="photo_body">'+data[i].guest_photo+'</div>'
	             html +=''
	             
	             
	             
	             
	             
	             
	             
	             
	             
	             
	             
	             
	             
	             
	             
	             
	             
	             
	             
	             
	             
	             
	             
	             
	             
	             
	             
	            	 html +=''
	             
	            html +='<div class="text_body">'
	                html +='<section>'
	                html +='<button class="footers">'+data[i].guest_photo+'</button>'
	                html +='<button>'+data[i].guest_like+'</button>'
	                    html +='<div class="likes">'+data[i].guest_like+'</div>'
	                html +='</section>'
	            
	            html +='<div class="content">'
	                    html +='<div class="realtext">'+data[i].guest_text+'</div>'
	                
	                html +='</div>'
	                	html +='</article>';
			} // for끝
			
			$('#guestbookList').html(html);
			
		} // success끝 
		
		
	});
	
});


</script>




<jsp:include page="/WEB-INF/views/include/footer.jsp"/>


</body>
</html>