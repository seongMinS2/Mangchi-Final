<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동네생활</title>
<link rel="stylesheet" href="<c:url value="/resources/css/kbg.css"/>">
<script src="http://code.jquery.com/jquery-1.7.js" type="text/javascript"></script>
<script type="text/javascript" src='<c:url value="/resources/js/jquery.bpopup.min.js"/>'></script>
<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script> -->
<%-- <script type="text/javascript" src='<c:url value="/resources/js/kbg.js"/>'></script> --%>

	

</head>


<jsp:include page="/WEB-INF/views/include/header.jsp"/>


 
<!-- <h1>방명록작성</h1>
<form id="gbForm">
		Idx : <input type="text" id="guest_idx" ><br>
		write :<input type="text" id="guest_write"><br>
		내용 :<input type="text" id="guest_text"><br>
		photo :<input type="text" id="guest_photo"><br>
		주소 :<input type="text" id="guest_addr"><br>
		<input type="submit" value="글쓰기" ><br>
</form> -->


<div style="margin-top:5%; text-align: center; margin: 0 auto;">
<button class="Post">글쓰기</button>
</div>
  
   <div id="popup" class="Pstyle">
      <span class="b-close">X</span>
      <div class="content" id="innerView" style="height:auto; width:auto;"></div>
   </div>





<div id="guestbookList"></div>




<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
<script type="text/javascript">











function goPopup(guest_idx) {
	$.ajax({
		url:'http://localhost:8080/guest/guest_book/'+guest_idx ,
		type:'GET',
		success : function (data) {
			
			var html='';
			html+='<article class="in_wrap">'
			html+='<div class="flex">'
			if(data.guest_photo !=null){
			//html+='<div class="in_photo">'+data.guest_photo+'</div>'
			html+='<div class="in_photo"><img src="https://img1.daumcdn.net/thumb/R720x0.q80/?scode=mtistory2&amp;fname=http%3A%2F%2Fcfile26.uf.tistory.com%2Fimage%2F2369374A56F366BB34731F"></div>'
			}
			html+='<div class="in_body">'
			html+='<header>'
			html+='<div class="in_hd_img"><img src="/images/3.png"></div>'
			html+='<div class="in_hd_nick">'+data.guest_writer+'</div>'
			html+='</header>'   
			html+='<div class="null_content">'
			html+='<div class="in_nonerealtext">'+data.guest_text+'</div>'
			html+='<section class="in_bodycmt">'
			html+='<div class="flex">'
			html+='<div class="in_hd_img"><img src="/images/3.png"></div>'
			html+='<div class="in_cmtnick">짱가</div>'
			html+='<div class="in_cmttext">엌ㅋㅋㅋ엌ㅋㅋㅋㅋ엌ㅋㅋㅋㅋ엌ㅋㅋㅋㅋ엌ㅋㅋㅋㅋ엌ㅋㅋㅋㅋ엌ㅋㅋㅋ엌ㅋㅋㅋㅋ엌ㅋㅋㅋㅋㅋ엌ㅋㅋㅋㅋㅋ</div>'
			html+='</div>'
			html+='<div class="flex">'
			html+='<div class="in_hd_img"><img src="/images/3.png"></div>'
			html+='<div class="in_cmtnick">병장</div>'
			html+='<div class="in_cmttext">앜ㅋㅋㅋㅋ</div>'
			html+='</div>'
			html+='</section>'
			html+='</div>'
			html+='<section class="in_bottom">'
			html+='<button class="footers" onclick="likeup('+data.guest_idx+')"><img id="heart" src="https://p.kindpng.com/picc/s/169-1694281_heart-symbol-computer-icons-heart-icon-instagram-png.png"></button>';
		    html+='<button><img src="https://www.pngitem.com/pimgs/m/21-212930_transparent-square-speech-bubble-png-transparent-instagram-comment.png"></button>';
			html+='<div class="likes">좋아요 '+data.guest_like+'개</div>'
			html+='<div class="flex dh">'
			html+='<div class="in_hits">조회 : '+data.guest_hits+'</div>'
			if(data.guest_photo ==null){
				html+='<div class="in_date_null">'+data.guest_date+'</div>'
			}else{
				html+='<div class="in_date">'+data.guest_date+'</div>'	
			}
			html+='</div>'
			html+='<div class="in_cmtbunki">'
			if(data.guest_photo ==null){
				html+='<input type="text" class="in_cmtwr_null" placeholder="   댓글 달기">'	
			}else{
				html+='<input type="text" class="in_cmtwr" placeholder="   댓글 달기">'	
			}
			html+='<input type="submit" class="cmtsb" value="등록">'
			html+='</div>'
			html+='</section>'                     
			html+='</div>'
			html+='</div>'
			html+='</article>'
			
			
			$('#innerView').html(html);
		}// 석세스끝
		
	});
	
	
	
	$("#popup").bPopup(); // 열기
	};




	
	
	
	
	
	
	
	
	
	
	
	
	
	


function gbList() {
	$.ajax({
		url:'http://localhost:8080/guest/guest_book' ,
		type:'get',
		 
		success : function (data) {
			
			var html='';
			for(var i=0; i<data.length; i++){
				if(data[i].guest_photo !=null){
				html+='<article class="have_photo">';
			    html+='<header>';
			    html+='<input type="hidden" name="guest_idx">';
			    //아래가 멤버프로필이미지 가져와야함
			    html+='<div class="hd_img"><img src="https://img1.daumcdn.net/thumb/R720x0.q80/?scode=mtistory2&fname=http%3A%2F%2Fcfile26.uf.tistory.com%2Fimage%2F2369374A56F366BB34731F"></div>';
			    //아래가 멤버닉네임가져와야함
			    html+='<div class="hd_nick">'+data[i].guest_writer+'</div>';
			    html+='</header>';
			    //html+='<div class="photo_body">'+data[i].guest_photo+'</div>';
			    html+='<div class="photo_body"><img src="https://img1.daumcdn.net/thumb/R720x0.q80/?scode=mtistory2&fname=http%3A%2F%2Fcfile26.uf.tistory.com%2Fimage%2F2369374A56F366BB34731F"></div>';
			    html+='<div class="text_body">';
			    html+='<section>';
			    html+='<button class="footers" onclick="likeup('+data[i].guest_idx+')"><img id="heart" src="https://p.kindpng.com/picc/s/169-1694281_heart-symbol-computer-icons-heart-icon-instagram-png.png"></button>';
			    html+='<button class="btmsg" onclick="goPopup('+data[i].guest_idx+')"><img id="mmsg" src="https://www.pngitem.com/pimgs/m/21-212930_transparent-square-speech-bubble-png-transparent-instagram-comment.png"></button>';
			    html+='<div class="likes">좋아요 '+data[i].guest_like+' 개</div>';
			    html+='</section>'; 
			    html+='<div class="content">';
			    html+='<div class="realtext">'+data[i].guest_text+'<br>';
			    html+='</div>';
			    html+='</div>';
			    html+='<div class="comment">';
			    html+='<button class="cmtnum" onclick="goPopup('+data[i].guest_idx+')">댓글 모두보기</button>';
			    html+='<section>';
			    html+='<div class="flex">';
			    html+='<div class="cmtnick">짱가</div>';
			    html+='<div class="cmttext">엌ㅋㅋㅋㅋ</div>';
			    html+='</div>';
			    html+='<div class="flex">';
			    html+='<div class="cmtnick">병장</div>';
			    html+='<div class="cmttext">앜ㅋㅋㅋㅋ</div>';
			    html+='</div>';
			    html+='</section>';
			    html+='</div>';
			    html+='<div class="cmtbunki">';
			    html+='<input type="text" class="cmtwr" id="cmtwr" placeholder="    댓글 달기">';
			    html+='<input type="submit" class="cmtsb" value="등록">';
			    html+='</div>';
			    html+='</div>'; 
			    html+='</article>';
				} else if(data[i].guest_photo ==null){
					html+='<article class="none_photo">';
				    html+='<header>';
				    html+='<input type="hidden" name="guest_idx">';
				    html+='<div class="hd_img"><img src="https://img1.daumcdn.net/thumb/R720x0.q80/?scode=mtistory2&fname=http%3A%2F%2Fcfile26.uf.tistory.com%2Fimage%2F2369374A56F366BB34731F"></div>';
				    html+='<div class="hd_nick">'+data[i].guest_writer+'</div>';
				    html+='</header>';
				   
				    
				    html+='<div class="null_content">'
				    html+='<div class="nonerealtext">'+data[i].guest_text+'</div>'
				    html+='</div>'
				    
				    html+='<div class="text_body">';
				    html+='<section>';
				    
				    //아래라이크사진
				    html+='<button class="footers" onclick="likeup('+data[i].guest_idx+')"><img id="heart" src="https://p.kindpng.com/picc/s/169-1694281_heart-symbol-computer-icons-heart-icon-instagram-png.png"></button>';
				    
			    	html+='<button onclick="goPopup('+data[i].guest_idx+')"><img id="mmsg" src="https://www.pngitem.com/pimgs/m/21-212930_transparent-square-speech-bubble-png-transparent-instagram-comment.png"></button>';
			    	
				    html+='<div class="likes" id=likes>좋아요<span id=dlikes>'+data[i].guest_like+'</span>개</div>';
			    	
				    html+='</section>'; 
				 
				    html+='<div class="comment">';
				    html+='<button class="cmtnum" onclick="goPopup('+data[i].guest_idx+')">댓글 모두보기</button>';
				    html+='<section>';
				   		html+='<div class="flex">';
					    html+='<div class="cmtnick">짱가</div>';
					    html+='<div class="cmttext">안녕하세요</div>';
					    html+='</div>';
				    html+='</section>';
				    html+='</div>';
				    html+='<div class="cmtbunki">';
				    html+='<input type="text" class="cmtwr" id="cmtwr" placeholder="    댓글 달기">';
				    html+='<input type="submit" class="cmtsb" value="등록">';
				    html+='</div>';
				    html+='</div>'; 
				    html+='</article>';
				}
			
				
			
			} // for문 끝 
			
			$('#guestbookList').html(html);
			
			$('#heart').click(function () {
				var a=$('#dlikes').text();
				a=Number(a)+1;
				$('#dlikes').text(a);	
			});
			
			
		
		
			
			
		} // success끝 
		
		
	}); // ajax끝 
	
}
/* 
  $('body').on('click','#heart',function(){
	$(this).attr("src","//upload.wikimedia.org/wikipedia/commons/thumb/4/42/Love_Heart_SVG.svg/645px-Love_Heart_SVG.svg.png");
	$(this).attr("id","okheart");
	var a=$('#dlikes').text();
	a=Number(a)+1;
	$('#dlikes').text(a);
 }); */
 
  $('body').on('click','#okheart',function(){
		$(this).attr("src","https://p.kindpng.com/picc/s/169-1694281_heart-symbol-computer-icons-heart-icon-instagram-png.png");
		$(this).attr("id","heart");
		var a=$('#dlikes').text();
		a=Number(a)-1;
		$('#dlikes').text(a);
		}); 
/* 
		 $('body').on('click','#dlikes',function(){
			var a=$(this).text();
			a=Number(a)+1;
			$(this).text(a);
			});   */
		 
			
			
			
		
  function likeup(guest_idx) {
		$.ajax({
			url:'http://localhost:8080/guest/guest_book/'+guest_idx,
			type:'PUT',
			contentType: 'application/json; charset=utf-8',
			success : function (data) {
				alert(data);
			}
		});
	}


$(document).ready(function () {
	
	gbList();
	likeup();

});
</script>


</body>
</html>