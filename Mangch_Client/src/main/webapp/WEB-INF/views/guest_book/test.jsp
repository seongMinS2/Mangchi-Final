<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동네생활</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>


<jsp:include page="/WEB-INF/views/include/header.jsp"/>



<h1>방명록작성</h1>
<form id="gbForm">
		Idx : <input type="text" nmae="guest_idx"  readonly="readonly"><br>
		write :<input type="text" nmae="guest_write" value="1" readonly="readonly"><br>
		내용 :<input type="text" nmae="guest_text"><br>
		photo :<input type="file" nmae="guest_photo"><br>
		주소 :<input type="text" nmae="guest_addr"><br>
		<input type="submit" value="글쓰기" ><br>
</form>




<h1>방명록 리스트</h1>
<hr>
<div id="guestbookList"></div>
<input type="hidden" name="guest_idx">
<script>

$(document).ready(function () {
	
	$.ajax({
		url:'https://localhost:8080/guest/guest_book' ,
		type:'get',
		success : function (data) {
			$('#guestbookList').html(JSON.stringify(data));
		}
	var html='';
	
    html='<article>'
    html='<header>'
    html+='<input type="hidden" name="guest_idx">'
    html='<div class="hd_img"><img src="https://img1.daumcdn.net/thumb/R720x0.q80/?scode=mtistory2&fname=http%3A%2F%2Fcfile26.uf.tistory.com%2Fimage%2F2369374A56F366BB34731F"></div>'
    html+='<div class="hd_nick">'+data[i]guest_writer+'</div>'
    html+='</header>'
    html+='<div class="photo_body">'+data[i]guest_photo+'</div>'
    html+='<div class="text_body">'
    html+='<section>'
    html+='<button class="footers"><img src=/images/love.png></button>'
    html+='<button><img src=/images/msg.png></button>'
    html+='<div class="likes">'+data[i]guest_like+'</div>'
    html+='</section>'
    html+='<div class="content">'
   	html+='<div class="realtext">'+data[i]guest_text+'<br>'
  	html+='</div>'
    html+='</div>'
    html+='<div class="comment">'
    html+='<div class="cmtnum">댓글 모두보기</div>'
    html+='<section>'
    html+='<div class="flex">'
    html+='<div class="cmtnick">짱가</div>'
    html+='<div class="cmttext">엌ㅋㅋㅋㅋ</div>'
    html+='</div>'
    html+='<div class="flex">'
    html+='<div class="cmtnick">병장</div>'
    html+='<div class="cmttext">앜ㅋㅋㅋㅋ</div>'
    html+='</div>'
    html+='</section>'
    html+='</div>'
    html+='<div class="cmtbunki">'
    html+='<input type="text" class="cmtwr" id="cmtwr" placeholder="    댓글 달기">'
    html+='<input type="submit" class="cmtsb" value="등록">'
    html+='</div>'
    html+='</div>'
    html+='</article>'

		
	});
	
});


</script>




<jsp:include page="/WEB-INF/views/include/footer.jsp"/>


</body>
</html>