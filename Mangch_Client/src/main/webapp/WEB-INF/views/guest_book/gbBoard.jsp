<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동네생활</title>
<link rel="stylesheet" href="<c:url value="/resources/css/kbg.css"/>">

<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script> -->
<%-- <script type="text/javascript" src='<c:url value="/resources/js/kbg.js"/>'></script> --%>



</head>


<jsp:include page="/WEB-INF/views/include/header.jsp"/>



<h1>방명록작성</h1>
 ${loginInfo}

 
<form id="postForm" onsubmit="return false;">
		writer :<input type="text" name="guest_writer" id="guest_writer" value=" ${loginInfo.mNick}"><br>
		text :<input type="text" name="guest_text" id="guest_text"><br>
		 photo :<input type="file" name="guest_photo" id="guest_photo" ><br>
		addr :<input type="text" name="guest_addr" id="guest_addr" value="${loginInfo.mAddr}"><br>
		x :<input type="text" name="x" id="x" value="${loginInfo.mLttd}"><br>
		y :<input type="text" name="y" id="y" value="${loginInfo.mLgtd}"><br>
		r :<input type="text" name="r" id="r" value="${loginInfo.mRadius}"><br>
		<input type="submit" value="글쓰기" onclick="guestPost()">
	
</form>



<div style="margin-top:5%; text-align: center; margin: 0 auto;">
<button class="Post">글쓰기</button>
</div>
  
   <div id="popup" class="Pstyle">
      <span class="b-close">X</span>
      <div class="content" id="innerView" style="height:auto; width:auto;"></div>
   </div>





<div id="guestbookList"></div>




 
<form id="postForm" onsubmit="return false;">
		writer :<input type="text" name="guest_writer" id="guest_writer" value="${loginInfo.mNick}"><br>
		text :<input type="text" name="guest_text" id="guest_text"><br>
		photo :<input type="file" name="guest_photo" id="guest_photo" ><br>
		addr :<input type="text" name="guest_addr" id="guest_addr" value="${loginInfo.mAddr}"><br>
		x :<input type="text" name="x" id="x" value="${loginInfo.mLttd}"><br>
		y :<input type="text" name="y" id="y" value="${loginInfo.mLgtd}"><br>
		r :<input type="text" name="r" id="r" value="${loginInfo.mRadius}"><br>
		
		
		<input type="submit" value="글쓰기" onclick="guestPost();"><br>
		
</form>

<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

<script type="text/javascript">

var zz =$('#guest_writer').val();
var bb=zz.trim();
var x=$('#x').val();


var mnick=$('')

function guestPost() {
	
	var zz =$('#guest_writer').val();
	var bb=zz.trim();
	var postFormData = new FormData();
	postFormData.append('guest_writer',bb);
	postFormData.append('guest_text',$('#guest_text').val());
	postFormData.append('x',x);
	postFormData.append('y',y);
	postFormData.append('photo',$('#guest_photo')[0].files[0]); // 파일첨부 코드	

	$.ajax({
		url : 'http://localhost:8080/guest/guest_book',
		type : 'post',

		processData : false, // File 전송시 필수 
		contentType : false, // multipart/form-data 쓰는 코드
		data : postFormData,
		success : function (data) {
			gbList();
			$('#postForm')[0].reset();
		}
		
	});
	
	
}








///////////////////// 팝업 함수
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
			
				html+='<button class="footers likebtn" id="heartok" onclick="likeup('+data.guest_idx+')"><img id="heart" src="${pageContext.request.contextPath}/resources/img/love.png"></button>';
		    html+='<button class="footers likedownbtn" id="heartno" style="display:none" onclick="likedown('+data.guest_idx+')"><img id="heart" src="${pageContext.request.contextPath}/resources/img/redheart.png"></button>';
			
		    html+='<button><img src="${pageContext.request.contextPath}/resources/img/msg.png"></button>';
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



	
	  /*  if(data[i].guest_writer == ${loginInfo.mNick}){
	    	html+='<div>안녕</div>'
	    } */
	
	

///////////////////// 전체리스트
function gbList() {
	$.ajax({
		url:'http://localhost:8080/guest/guest_book' ,
		dataType:'json',
		type:'get',
		traditional : true,
		 data : {
			 xx :'${loginInfo.mLttd}',
			 yy :'${loginInfo.mLgtd}',
			 member_radius :'${loginInfo.mRadius}'
		 },
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
			    html+='<div class="photo_body">'+data[i].guest_photo+'</div>';
			    //html+='<div class="photo_body"><img src="https://img1.daumcdn.net/thumb/R720x0.q80/?scode=mtistory2&fname=http%3A%2F%2Fcfile26.uf.tistory.com%2Fimage%2F2369374A56F366BB34731F"></div>';
			    html+='<div class="text_body">';
			    html+='<section>';
			    
			    html+='<button class="footers likebtn" id="heartok" onclick="likeup('+data[i].guest_idx+')"><img id="heart" src="${pageContext.request.contextPath}/resources/img/love.png"></button>';
			    html+='<button class="footers likedownbtn" id="heartno" style="display:none" onclick="likedown('+data[i].guest_idx+')"><img id="heart" src="${pageContext.request.contextPath}/resources/img/redheart.png"></button>';
			    
			    html+='<button class="btmsg" onclick="goPopup('+data[i].guest_idx+')"><img id="mmsg" src="${pageContext.request.contextPath}/resources/img/msg.png"></button>';
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
				    /* html+='<div class="hd_img"><img src="https://img1.daumcdn.net/thumb/R720x0.q80/?scode=mtistory2&fname=http%3A%2F%2Fcfile26.uf.tistory.com%2Fimage%2F2369374A56F366BB34731F"></div>'; */
				    html+='<div class="hd_img">'+data[i].member_img+'</div>'; 
				    html+='<div class="hd_nick">'+data[i].guest_writer+'</div>';
				    html+='</header>';
				   
				    
				    html+='<div class="null_content">'
				    html+='<div class="nonerealtext">'+data[i].guest_text+'</div>'
				    html+='</div>'
				    
				    html+='<div class="text_body">';
				    html+='<section>';
				    
				    //아래라이크사진
				   
				    html+='<button class="footers likebtn" id="heartok" onclick="likeup('+data[i].guest_idx+')"><img id="heart" src="${pageContext.request.contextPath}/resources/img/love.png"></button>';
				    html+='<button class="footers likedownbtn" id="heartno" style="display:none" onclick="likedown('+data[i].guest_idx+')"><img id="heart" src="${pageContext.request.contextPath}/resources/img/redheart.png"></button>';
				    
			    	html+='<button onclick="goPopup('+data[i].guest_idx+')"><img id="mmsg" src="${pageContext.request.contextPath}/resources/img/msg.png"></button>';
			    	
				    html+='<div class="likes" id="likes">좋아요<span class="dlikes" id="dlikes">'+data[i].guest_like+'</span>개</div>';
				    html+='</div>'
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
				    html+='<input type="hidden" value="'+data[i].x+'"><br>'
				    html+='<input type="hidden" value="'+data[i].y+'"><br>'
				    html+='</article>';
				}
			
			} // for문 끝 
			
					$('#guestbookList').html(html);
					
					
			
			
			
			
			$('.likebtn').click(function () {
				
					var a=$(this).next();
					var b = a.next();
					var c = b.next();
					var d =c.children('.dlikes').text();
					console.log(d);
					d=Number(d)+1;
					c.children('.dlikes').text(d);
					$(this).hide();
					a.show();
				
					
					
			});
			
			
			$('.likedownbtn').click(function () {
				
				var a=$(this).next();
				var b = a.next();
				var c = b.children('.dlikes').text();
				
				console.log(c);
				c=Number(c)-1;
				b.children('.dlikes').text(c);
				$(this).hide();
				$(this).prev().show();
		});
			
		} // success끝 
		
		
	}); // ajax끝 
	
}


///////////////////// 좋아요 증감 함수
  function likeup(guest_idx) {
		$.ajax({
			url:'http://localhost:8080/guest/guest_book/plus/'+guest_idx,
			type:'PUT',
			contentType: 'application/json; charset=utf-8',
			success : function (data) {
				
			}
		});
	}
			
			
			
///////////////////// 좋아요 감소 함수
	function likedown(guest_idx) {
		$.ajax({
			url:'http://localhost:8080/guest/guest_book/mi/'+guest_idx,
			type:'PUT',
			contentType: 'application/json; charset=utf-8',
			success : function (data) {
				
			}
		});
	} 
	
			
			


$(document).ready(function () {
	
	gbList();

});
</script>


</body>
</html>