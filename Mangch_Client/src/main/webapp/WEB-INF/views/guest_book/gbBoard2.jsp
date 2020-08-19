<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동네생활</title>
<link rel="stylesheet" href="<c:url value="/resources/css/kbg.css?ver=1"/>">

<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script> -->
<%-- <script type="text/javascript" src='<c:url value="/resources/js/kbg.js"/>'></script> --%>



</head>


<jsp:include page="/WEB-INF/views/include/header.jsp"/>




 ${loginInfo}
 
 
 <h3 style="font-weight: bold; text-align: center;">반가워요,${loginInfo.mNick }님!<br>
  ${loginInfo.mNick }님의 근처 동네생활 입니다</h3>
 
<article class="none_photo">

<div id="postForm" onsubmit="return false;">
		<input type="hidden" name="guest_writer" id="guest_writer" value=" ${loginInfo.mNick}">	
		<input type="hidden" name="x" id="x" value="${loginInfo.mLttd}">
		<input type="hidden" name="y" id="y" value="${loginInfo.mLgtd}">
		<input type="hidden" name="r" id="r" value="${loginInfo.mRadius}">
		<input type="hidden" name="member_img" id="member_img" value="${loginInfo.mImg}">
		<input type="hidden" name="guest_addr" id="guest_addr" value="${loginInfo.mAddr}"> 
	<div class="postwrap" style="display: block;">
		<div class="postTitle" style="background-color: #DDD; line-height: 27px; ">
		<span style="font-weight: bold; margin-left: 3px;">게시물 만들기</span>
		</div>
		<div class="postbody" style="height: auto;">
		
			<div style="width: 100%; display: flex; position: relative; height: 100px; border-bottom: 1px solid #DDD;">
				<div style="width: 20%;">
				<img   src="${pageContext.request.contextPath}${loginInfo.mImg}" style=" left: 6%; top: 25%; position: absolute; border: 2px solid #DDD; border-radius: 50px; width: 45px; height: 45px;">
				
				</div>
				
				
			
			<textarea rows="100" cols="500"  type="textarea" name="guest_text" id="guest_text" required="required" placeholder="    ${loginInfo.mNick}님, 무슨생각을 하고계신가요?"
				style="width: 80%; border: 0; outline: 0;  height: 50px; margin-top:33px; overflow: hidden; resize: none;"></textarea>
			</div>
				
				<div class="foot" style="padding: 15px;">
				<label for="guest_photo"><img src="${pageContext.request.contextPath}/resources/img/photo.png" style="height: 30px; width: 30px;"></label>
		 <input type="file" name="guest_photo" id="guest_photo" style="display: none;">
		 <input class="upload-name" value="파일선택"  style="border: 0; outline: 0; font-size: 10px; width:400px;" readonly="readonly">
		 <input type="submit" value="게시" class="cmtsb" onclick="guestPost()" style="float: right;">
		 		</div>
		 </div>
</div>
 </div>
 </article>



<div style="margin-top:5%; text-align: center; margin: 0 auto;">

</div>
  
  
  
   <div id="popup" class="Pstyle">
      <span class="b-close">X</span>
      <div class="content" id="innerView" style="height:auto; width:auto;"></div>
   </div>



<div id="guestbookList"></div>


<div id="editddd"  class="editdiv"></div>

<div id="testt"></div>





<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

<script type="text/javascript">



//댓글쓰기
function cmtWrite(guest_idx,text) {
	var zz =$('#guest_writer').val();
	var bb=zz.trim();
$.ajax({
		
		url:'http://localhost:8080/guest/guest_book/cmt',
		type : 'Post',
		dataType:'json', 
		data : {
			
			member_nick : bb,
			comment_text :text,
			comguest_idx : guest_idx
		},
		success : function (data) {
			gbList();
			
		}
	});
	

}





//////////////삭제함수
function deleteForm(guest_idx) {
	if(confirm('정말 삭제하시겠습니까?')){
		
		$.ajax({
			
			url:'http://localhost:8080/guest/guest_book/'+guest_idx ,
			type : 'DELETE',
			success : function (data) {
				gbList();
			}
		});
	}
	$('.editdiv-close').trigger('click');
	$('.b-close').trigger('click');
}




//세션 x,y값 전역변수선언
var x=$('#x').val();
var y=$('#y').val();

////////////////////////글쓰기 함수
function guestPost() {
	
	var zz =$('#guest_writer').val();
	var bb=zz.trim();
	
	var mImg=$('#member_img').val();
	
	var maddr=$('#guest_addr').val();
	var addrbunki=maddr.substr(2,5);
	
	
	//db에 줄바꿈
	var str = $('#guest_text').val();
	str = str.replace(/(?:\r\n|\r|\n)/g, '<br/>');

	
	var postFormData = new FormData();
	postFormData.append('guest_writer',bb);
	postFormData.append('guest_text',str);
	postFormData.append('x',x);
	postFormData.append('y',y);
	postFormData.append('member_img',mImg);
	postFormData.append('guest_addr',addrbunki);
	if($('#guest_photo')[0].files[0] !=null){
	postFormData.append('photo',$('#guest_photo')[0].files[0]); // 파일첨부 코드	
	}
	$.ajax({
		url : 'http://localhost:8080/guest/guest_book/post',
		type : 'post',

		processData : false, // File 전송시 필수 
		contentType : false, // multipart/form-data 쓰는 코드
		data : postFormData,
		success : function (data) {
			console.log(data);
			$('#guest_text').val('');
			$(".upload-name").val('파일선택');
			gbList();
		}
	});
}

//////글쓰기 파일업로드 네임
var fileTarget=$('#guest_photo');
fileTarget.on('change',function(){
	var cur=fileTarget.val();
	var name=cur.substring(12)
	$(".upload-name").val(name);
	
});







////////////////////// 에디트팝업
function editPopup(guest_idx) {
	$.ajax({
		url:'http://localhost:8080/guest/guest_book/'+guest_idx ,
		type:'GET',
		success : function (data) {
			
			var html='';
			
				html+='<button class="btnz" >게시글 수정</button>';
				html+='<button class="btnz" onclick="deleteForm('+data.guest_idx+')">게시글 삭제</button>';
				html+='<button class="btnz">'+data.guest_idx+'</button>';
				html+='<button class="btnz editdiv-close">취소</button>';
			
			$('#editddd').html(html);
			
			
		}// 석세스끝
		
	});
	$("#editddd").bPopup({closeClass:'editdiv-close',
        opacity:0.4,
        modalClose:true}); // 열기
	
	
	};












///////////////////// 팝업 함수
function goPopup(guest_idx) {
	$.ajax({
		url:'http://localhost:8080/guest/guest_book/'+guest_idx ,
		type:'GET',
		success : function (data) {
			console.log(data)
			var html='';
			if(data.guest_photo !=null){
				html+='<article class="in_wrap">'
					html+='<div class="flex">'
						html+='<div class="in_photo"><img src="http://localhost:8080/guest_book/upload/'+data.guest_photo+'"></div>'
						html+='<div class="in_body">'
							html+='<header>'
							html+='<div class="hd_img"><img src="${pageContext.request.contextPath}'+data.member_img+'"></div>'; 
							//html+='<div class="hd_img"><img src="${pageContext.request.contextPath}/upload/'+data.member_img+'"></div>';
							 html+='<div class="in_hd_nick">';
						    html+=data.guest_writer
						    if(data.guest_writer === `${loginInfo.mNick}`){
						    	html+='<button class="dotpopup" style="float:right;" onclick="editPopup('+data.guest_idx+');"><img src="${pageContext.request.contextPath}/resources/img/dot.png" style="width:15px;"></button>'
						    }
						    html+='</div>'
							html+='</header>'   
							html+='<div class="null_content">'
							html+='<div class="in_nonerealtext">'+data.guest_text
							html+='<section class="in_bodycmt">'
							console.log(data.guest_comment)
								 for(var j=0; j<data.guest_comment.length; j++){
								    		html+='<div class="flex">';
									    html+='<div class="cmtnick_in" style="display:block;">'+data.guest_comment[j].member_nick+'</div>';
									    html+='<br/>'
									    html+='<div class="cmttext">'+data.guest_comment[j].comment_text+'</div>';
									    html+='</div>';
									    }
							html+='</section>'
								html+='</div>'
							html+='</div>'
							html+='<section class="in_bottom">'
							
								html+='<button class="footers likebtn" id="heartok" onclick="likeup('+data.guest_idx+')"><img id="heart" src="${pageContext.request.contextPath}/resources/img/love.png"></button>';
						    html+='<button class="footers likedownbtn" id="heartno" style="display:none" onclick="likedown('+data.guest_idx+')"><img id="heart" src="${pageContext.request.contextPath}/resources/img/redheart.png"></button>';
							
						    html+='<button><img src="${pageContext.request.contextPath}/resources/img/msg.png"></button>';
							html+='<div class="likes">좋아요 '+data.guest_like+'개</div>'
							html+='<div class="flex dh">'
							html+='<div class="in_hits">조회 : '+data.guest_hits+'</div>'
							html+='<div class="in_date">'+data.guest_date+'</div>'	
			
			html+='</div>'
			html+='<div class="in_cmtbunki">'
			html+='<input type="text" class="in_cmtwr" placeholder="   댓글 달기">'	
			html+='<input type="submit" class="cmtsb2" value="등록">'
			html+='<input type="hidden" class="cmtwrtext" value="'+data.guest_idx+'">';
			html+='</div>'
			html+='</section>'                     
			html+='</div>'
			html+='</div>'
			html+='</article>'
			}else if(data.guest_photo ==null){
				
				html+='<article class="in_wrap">'
				html+='<div class="no_wrap">'
			
				html+='<header>'
				html+='<div class="hd_img"><img src="${pageContext.request.contextPath}'+data.member_img+'"></div>'; 
				//html+='<div class="hd_img"><img src="${pageContext.request.contextPath}/upload/'+data.member_img+'"></div>';
				 html+='<div class="in_hd_nick_no">';
			    html+=data.guest_writer
			    if(data.guest_writer === `${loginInfo.mNick}`){
			    	html+='<button class="dotpopup" style="float:right;" onclick="editPopup('+data.guest_idx+');"><img src="${pageContext.request.contextPath}/resources/img/dot.png" style="width:15px;"></button>'
			    }
			    html+='</div>'
				html+='</header>'   
				html+='<div class="null_content">'
				html+='<div class="in_nonerealtext">'+data.guest_text
				html+='<section class="in_bodycmt">'
				console.log(data.guest_comment)
					 for(var j=0; j<data.guest_comment.length; j++){
					    		html+='<div class="flex">';
						    html+='<div class="cmtnick_in" style="display:block;">'+data.guest_comment[j].member_nick+'</div>';
						    html+='<br/>'
						    html+='<div class="cmttext">'+data.guest_comment[j].comment_text+'</div>';
						    html+='</div>';
						    }
				html+='</section>'
					html+='</div>'
				html+='</div>'
				html+='<section class="in_bottom">'
				
					html+='<button class="footers likebtn" id="heartok" onclick="likeup('+data.guest_idx+')"><img id="heart" src="${pageContext.request.contextPath}/resources/img/love.png"></button>';
			    html+='<button class="footers likedownbtn" id="heartno" style="display:none" onclick="likedown('+data.guest_idx+')"><img id="heart" src="${pageContext.request.contextPath}/resources/img/redheart.png"></button>';
				
			    html+='<button><img src="${pageContext.request.contextPath}/resources/img/msg.png"></button>';
				html+='<div class="likes">좋아요 '+data.guest_like+'개</div>'
				html+='<div class="flex dh">'
				html+='<div class="in_hits">조회 : '+data.guest_hits+'</div>'
					html+='<div class="in_date_null">'+data.guest_date+'</div>'
				html+='</div>'
				html+='<div class="in_cmtbunki">'
					html+='<input type="text" class="in_cmtwr_null" placeholder="   댓글 달기">'	
				html+='<input type="submit" class="cmtsb2" value="등록">'
				html+='<input type="hidden" class="cmtwrtext" value="'+data.guest_idx+'">';
				html+='</div>'
				html+='</section>'                     
				html+='</div>'
				
				html+='</article>'
			}
			/* 
			html+='<article class="in_wrap">'
			html+='<div class="flex">'
			if(data.guest_photo !=null){
			//html+='<div class="in_photo">'+data.guest_photo+'</div>'
			html+='<div class="in_photo"><img src="http://localhost:8080/guest_book/upload/'+data.guest_photo+'"></div>'
			}
			html+='<div class="in_body">'
			html+='<header>'
			html+='<div class="hd_img"><img src="${pageContext.request.contextPath}'+data.member_img+'"></div>'; 
			//html+='<div class="hd_img"><img src="${pageContext.request.contextPath}/upload/'+data.member_img+'"></div>';
			 html+='<div class="in_hd_nick">';
		    html+=data.guest_writer
		    if(data.guest_writer === `${loginInfo.mNick}`){
		    	html+='<button class="dotpopup" style="float:right;" onclick="editPopup('+data.guest_idx+');"><img src="${pageContext.request.contextPath}/resources/img/dot.png" style="width:15px;"></button>'
		    }
		    html+='</div>'
			html+='</header>'   
			html+='<div class="null_content">'
			html+='<div class="in_nonerealtext">'+data.guest_text
			html+='<section class="in_bodycmt">'
			console.log(data.guest_comment)
				 for(var j=0; j<data.guest_comment.length; j++){
				    		html+='<div class="flex">';
					    html+='<div class="cmtnick_in" style="display:block;">'+data.guest_comment[j].member_nick+'</div>';
					    html+='<br/>'
					    html+='<div class="cmttext">'+data.guest_comment[j].comment_text+'</div>';
					    html+='</div>';
					    }
			html+='</section>'
				html+='</div>'
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
			html+='<input type="submit" class="cmtsb2" value="등록">'
			html+='<input type="hidden" class="cmtwrtext" value="'+data.guest_idx+'">';
			html+='</div>'
			html+='</section>'                     
			html+='</div>'
			html+='</div>'
			html+='</article>' */
			
			
			$('#innerView').html(html);
			
			
			$('.cmtsb2').click(function () {
				var a=$(this).next().val();
				var b=$(this).prev().val();
				cmtWrite(a,b);
				goPopup(guest_idx);
				goPopup(guest_idx);
			});
			
		}// 석세스끝
		
	});
	$("#popup").bPopup(); // 열기
	
	};



	
	  /*  if(data[i].guest_writer == ${loginInfo.mNick}){
	    	html+='<div>안녕</div>'
	    } */
	
	    

	    
	    
	    var page = 5;
///////////////////// 전체리스트

function gbList() {
	 $(window).scroll(function vv() {
    if ($(window).scrollTop() == $(document).height() - $(window).height()) { 
	$.ajax({
		url:'http://localhost:8080/guest/guest_book' ,
		dataType:'json',
		type:'get',
		traditional : true,
		 data : {
			 xx :'${loginInfo.mLttd}',
			 yy :'${loginInfo.mLgtd}',
			 member_radius :'${loginInfo.mRadius}',
			 limit : page
			
		 },
		success : function (data) {
			var html='';
			
			for(var i=0; i<data.length; i++){
				if(data[i].guest_photo !=null){
				html+='<article class="have_photo">';
			    html+='<header>';
			    html+='<input type="hidden" name="guest_idx">';
			    //아래가 멤버프로필이미지 가져와야함
			    html+='<div class="hd_img"><img src="${pageContext.request.contextPath}'+data[i].member_img+'"></div>'; 
			    //아래가 멤버닉네임가져와야함
			    html+='<div class="hd_nick">';
			    html+=data[i].guest_writer
			    html+='<span class="addr">'+data[i].guest_addr+'</span>';
			    if(data[i].guest_writer === `${loginInfo.mNick}`){
			    	html+='<button class="dotpopup" onclick="editPopup('+data[i].guest_idx+');"><img src="${pageContext.request.contextPath}/resources/img/dot.png" style="width:15px;"></button>'
			    }
			    html+='</div>'
			    html+='</header>';
			    html+='<div class="photo_body"><img src="http://localhost:8080/guest_book/upload/'+data[i].guest_photo+'"></div>';
			    //html+='<div class="photo_body"><img src="https://img1.daumcdn.net/thumb/R720x0.q80/?scode=mtistory2&fname=http%3A%2F%2Fcfile26.uf.tistory.com%2Fimage%2F2369374A56F366BB34731F"></div>';
			    html+='<div class="text_body">';
			    html+='<section>';
			    
			    //아래라이크사진
			   
			    html+='<button class="footers likebtn" id="heartok" onclick="likeup('+data[i].guest_idx+')"><img id="heart" src="${pageContext.request.contextPath}/resources/img/love.png"></button>';
			    html+='<button class="footers likedownbtn" id="heartno" style="display:none" onclick="likedown('+data[i].guest_idx+')"><img id="heart" src="${pageContext.request.contextPath}/resources/img/redheart.png"></button>';
			    
		    	html+='<button onclick="goPopup('+data[i].guest_idx+')"><img id="mmsg" src="${pageContext.request.contextPath}/resources/img/msg.png"></button>';
		    	
			    html+='<div class="likes" id="likes">좋아요<span class="dlikes" id="dlikes">'+data[i].guest_like+'</span>개</div>';
			    html+='</div>'
			    html+='</section>'; 
			    
			    html+='<div class="content">';
			    html+='<div class="nonerealtext">'+data[i].guest_text+'<br>';
			   
			    html+='</div>';
			    if(data[i].guest_text.includes('<br/>')){
			    	html+='<span class="more">더보기</span>';
			    }
			    html+='</div>';
			    html+='<div class="comment">';
			    html+='<button class="cmtnum" onclick="goPopup('+data[i].guest_idx+')">댓글 모두보기</button>';
			    html+='<section>';
			    for(var j=0; j<data[i].guest_comment.length; j++){
			    	if(j<2){
			    		html+='<div class="flex">';
				    html+='<div class="cmtnick" style="display:block;">'+data[i].guest_comment[j].member_nick+'</div>';
				    html+='<br/>'
				    html+='<div class="cmttext">'+data[i].guest_comment[j].comment_text+'</div>';
				    html+='</div>';
			    	}
				    }
			    html+='</section>';
			    html+='</div>';
			    html+='<div class="cmtbunki">';
			    html+='<input type="text" class="cmtwr" id="cmtwr" placeholder="    댓글 달기">';
			    html+='<input type="submit" class="cmtsb" value="등록">';
			    html+='<input type="hidden" class="cmtwrtext" value="'+data[i].guest_idx+'">';
			    html+='</div>';
			    html+='</div>'; 
			    html+='</article>';
				} else if(data[i].guest_photo ==null){
					html+='<article class="none_photo">';
				    html+='<header>';
				    html+='<input type="hidden" name="guest_idx">';
				    /* html+='<div class="hd_img"><img src="https://img1.daumcdn.net/thumb/R720x0.q80/?scode=mtistory2&fname=http%3A%2F%2Fcfile26.uf.tistory.com%2Fimage%2F2369374A56F366BB34731F"></div>'; */
				    html+='<div class="hd_img"><img src="${pageContext.request.contextPath}'+data[i].member_img+'"></div>'; 
				    html+='<div class="hd_nick">';
				    html+=data[i].guest_writer
				    html+='<span class="addr">'+data[i].guest_addr+'</span>';
				    if(data[i].guest_writer === `${loginInfo.mNick}`){
				    	html+='<button class="dotpopup" onclick="editPopup('+data[i].guest_idx+');"><img src="${pageContext.request.contextPath}/resources/img/dot.png" style="width:15px;"></button>'
				    }
				    html+='</div>'
				    html+='</header>';
				   
				    
				    html+='<div class="null_content">'
				    html+='<div class="nonerealtext">'+data[i].guest_text+'</div>'
				    if(data[i].guest_text.includes('<br/>')){
				    	html+='<span class="more" style="margin-left:13px; color:gray;">더보기</span>';
				    }
				    
				    
				    
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
				   		
						
				   		
					    /* for(var j=0; j<data[i].guest_comment.length; j++){
					    html+='<div class="cmtnick">'+data[i].guest_comment[j].member_nick+'</div>';
					    html+='<div class="cmttext">'+data[i].guest_comment[j].comment_text+'</div>';
					    } */
					    
					    for(var j=0; j<data[i].guest_comment.length; j++){
					    	if(j<2){
					    		html+='<div class="flex">';
						    html+='<div class="cmtnick" style="display:block;">'+data[i].guest_comment[j].member_nick+'</div>';
						    html+='<br/>'
						    html+='<div class="cmttext">'+data[i].guest_comment[j].comment_text+'</div>';
						    html+='</div>';
					    	}
						    }
					    
					   
				    html+='</section>'; 
				    html+='</div>';
				    html+='<div class="cmtbunki">';
				    html+='<input type="text" class="cmtwr"  placeholder="    댓글 달기">';
				    html+='<input type="submit" class="cmtsb" value="등록">';
				    html+='<input type="hidden" class="cmtwrtext" value="'+data[i].guest_idx+'">';
				    html+='</div>';
				    html+='</div>';
				    html+='</article>';
				}
			
			} // for문 끝 
				
			
			
					
					
					
					
				
				
			$('.cmtsb').click(function () {
				var a=$(this).next().val();
				var b=$(this).prev().val();
				cmtWrite(a,b);
			});
			
			
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
			
			//더보기
		/* 	$('.nonerealtext').readmore({
				
			});
			$('.realtext').readmore({
				
			}); */
				
			
			$('.more').click(function () {
				$(this).css('display','none');
				var text=$(this).prev();
				$(text).attr('class','nonerealtext2');
				
			})
			
			
				$.ajax({
					url:'http://localhost:8080/guest/guest_book/test',
					type:'GET',
					contentType: 'application/json; charset=utf-8',
					success : function (data) {
						
						html='';
						html+='<input type="text" class="tztz" value="'+data.a+'">'
						$('#testt').html(html);
						
						
					}
				});
			
			
			
			$('#guestbookList').html(html);
			
			
			
			var qaqa=Number($('article').length-1);
			var zaza=$('.tztz').val();
			console.log(qaqa)
			console.log(zaza)
			
			
			
			page=page+4
			
			if(qaqa>zaza){
				$(window).off();
				alert('넘었다');
			} 
			
		} // success끝 
		
		
		
		 
		
	}); // ajax끝 
	
	
	
	
    }
		});
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
	/* $(window).scroll(function() {
	    if ($(window).scrollTop() == $(document).height() - $(window).height()) { */
	    	//console.log(page)
	       /* gbList(); 
	      
	    }
	}); */

	//gbList();

});
</script>


</body>
</html>