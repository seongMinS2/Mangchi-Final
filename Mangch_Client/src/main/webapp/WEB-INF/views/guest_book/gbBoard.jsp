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

<style type="text/css">

.button_style {
 opacity: 5;
 display: none;
 position: relative;
 padding: 30px;
 background-color: #fff;
}
 
.layer_close {
 position: absolute;
 right: 3px;
 top: 1px;
 padding: 10px;
 cursor: pointer;
}
</style>

</head>


<jsp:include page="/WEB-INF/views/include/header.jsp"/>




 
 <h3 style="font-weight: bold; text-align: center;">반가워요,${loginInfo.mNick }님!<br>
  ${loginInfo.mNick }님의 근처 동네생활 입니다</h3>


<!-- 게시글 작성폼 --> 
<article class="none_photo">
<div id="postForm" onsubmit="return false;">
		<input type="hidden" name="guest_writer" id="guest_writer" value=" ${loginInfo.mNick}">	
		<input type="hidden" name="x" id="x" value="${loginInfo.mLttd}">
		<input type="hidden" name="y" id="y" value="${loginInfo.mLgtd}">
		<input type="hidden" name="r" id="r" value="${loginInfo.mRadius}">

		<input type="hidden" name="guest_addr" id="guest_addr" value="${loginInfo.mAddr}"> 
	<div class="postwrap" style="display: block;">
		<div class="postTitle w3-theme5" style="background-color: #DDD; line-height: 27px; ">
		<span style="font-weight: bold; margin-left: 3px;">게시물 만들기</span>
		</div>
		<div class="postbody" style="height: auto;">
		
			<div style="width: 100%; display: flex; position: relative; height: 100px; border-bottom: 1px solid #DDD;">
				<div style="width: 20%;">
				
				<c:if test="${empty loginInfo.kId}">
				<input type="hidden" name="member_img" id="member_img" value="${pageContext.request.contextPath}/resources/img/upload/${loginInfo.mImg}">
				<img   src="${pageContext.request.contextPath}/resources/img/upload/${loginInfo.mImg}" style=" left: 6%; top: 25%; position: absolute; border: 2px solid #DDD; border-radius: 50px; width: 45px; height: 45px;">
				</c:if>
				
				<c:if test="${not empty loginInfo.kId}">
				<input type="hidden" name="member_img" id="member_img" value="${loginInfo.mImg}">
				<img   src="${loginInfo.mImg}" style=" left: 6%; top: 25%; position: absolute; border: 2px solid #DDD; border-radius: 50px; width: 45px; height: 45px;">
				</c:if>
				
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
  
  
  
   <div id="popup" style="width : 800px;
   height : 500px;
   background-color : #fff;
            display: none;">
      <span class="b-close" style="display: none;"></span>
      <div class="content" id="innerView" style="height:auto; width:auto;"></div>
   </div>

<div id="sessionList"></div>

<div id="guestbookList"></div>


<div id="editddd"  class="editdiv"></div>
<div id="editcmt"  class="editdiv"></div>


<!-- 게시글수정폼 -->
<div id="layer_popup" class="button_style">
<article class="none_photo">
    <div class="postwrap" style="display: block;">
        <div class="postTitle" style="background-color: #DDD; line-height: 27px; ">
            <span style="font-weight: bold; margin-left: 3px;">게시물 수정하기</span>
            <span class="layer_close" style="float: right; margin-right: 10px;">X</span>
        </div>
            <div class="postbody" style="height: auto;">
                <div style="width: 100%; display: flex; position: relative; height: 100px; border-bottom: 1px solid #DDD;">
                    <form class="ditform" onsubmit="return false;">
                    <input type="text" name="guest_idx" id="guest_idx" style="display:none;">
                    <textarea rows="100" cols="500"  type="textarea" name="guest_text" id="guest_text" class="edittext" required="required" placeholder="    ${loginInfo.mNick}님, 수정할 텍스트를 입력해주세요"
                    style="width: 80%; border: 0; outline: 0;  height: 50px; margin-top:33px; overflow: hidden; resize: none;"></textarea>
                    <input  type="text" name="guest_writer" id="guest_writer" class="wr" style="display:none;">
                    <input type="text" name="oldphoto" id="oldphoto" class="oldphoto" style="display:none;">
                </div>
                <div class="foot" style="padding: 15px;">
                    <label for="photo"><img src="${pageContext.request.contextPath}/resources/img/photo.png" style="height: 30px; width: 30px;"></label>
                    <input type="file" name="photo" id="photo" style="display: none;">
                    <input class="upload-name" value="파일선택"  style="border: 0; outline: 0; font-size: 10px; width:400px;" readonly="readonly">
                    <input type="submit" value="수정"  onclick="editService()" style="float: right;">
                </div>
            </div>
    </div>
</form>
</article> 
</div>


<!-- 댓글수정폼 -->
<div id="realcmtedit" class="Pstyle2">
<form class="realcmteditform" onsubmit="return false;">
 <input type="text"  id="comment_idx" style="display:none;">
  <input type="text"  id="editguest_guest_idx" style="display:none;">
<input type="text" class="editformtext" >
<input type="submit" class="editformsubmit" onclick="editCmtText()">
</form>
</div>












<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

<script type="text/javascript">


var zz =$('#guest_writer').val();
var bb=zz.trim();


// 로그인한 세션값이 글쓴 리스트
function writerList(bb) {
	

	
	$.ajax({
		url:'http://localhost:8080/guest/guest_book/loginnick',
		type : 'GET',
		dataType:'json',
		data:{bb:bb},
		success : function (data) {
			
			var html='';
			for(var i=0; i<data.length; i++){
				if(data[i].guest_photo !=null){
				html+='<article class="have_photo">';
			    html+='<header>';
			    html+='<input type="hidden" name="guest_idx" class="idx" value="'+data[i].guest_idx+'">';
			    //아래가 멤버프로필이미지 가져와야함
			    html+='<div class="hd_img" ><img src="'+data[i].member_img+'"></div>';  
			    //아래가 멤버닉네임가져와야함
			    html+='<div class="hd_nick">';
			    html+=data[i].guest_writer
			    html+='<span class="addr">'+data[i].guest_addr+'</span>';
			    html+='</div>'
			    html+='</header>';
			    html+='<div class="photo_body"><img src="http://localhost:8080/guest/upload/'+data[i].guest_photo+'"></div>';
			    //html+='<div class="photo_body"><img src="https://img1.daumcdn.net/thumb/R720x0.q80/?scode=mtistory2&fname=http%3A%2F%2Fcfile26.uf.tistory.com%2Fimage%2F2369374A56F366BB34731F"></div>';
			    html+='<div class="text_body">';
			    html+='<section>';
			    
			    //아래라이크사진
			   
			    
		    	
			    html+='</div>'
			    html+='</section>'; 
			    
			    html+='<div class="content">';
			    html+='<div class="nonerealtext" id="nonerealtext2">'+data[i].guest_text+'<br>';
			   
			    html+='</div>';
			    if(data[i].guest_text.includes('<br/>')){
			    	html+='<span class="more">더보기</span>';
			    }
			    html+='</div>';
			    html+='<div class="comment">';
			    if(data[i].guest_comment.length !=0){
			    html+='<button class="cmtnum" onclick="goPopup('+data[i].guest_idx+')">댓글 모두보기</button>';
			    }
			    html+='<section>';
			    html+='</section>';
			    html+='</div>';
			    html+='</div>'; 
			    html+='</article>';
				} else if(data[i].guest_photo ==null){
					html+='<article class="none_photo">';
					
				    html+='<header>';
				    html+='<input type="hidden" name="guest_idx" class="idx" value="'+data[i].guest_idx+'">';
				    html+='<div class="hd_img");"><img src="'+data[i].member_img+'"></div>'; 
				    html+='<div class="hd_nick">';
				    html+=data[i].guest_writer
				    html+='<span class="addr">'+data[i].guest_addr+'</span>';
				    html+='</div>'
				    html+='</header>';
				   
				    
				    html+='<div class="null_content">'
				    html+='<div class="nonerealtext" id="nonerealtext2">'+data[i].guest_text+'</div>'
				    if(data[i].guest_text.includes('<br/>')){
				    	html+='<span class="more" style="margin-left:13px; color:gray;">더보기</span>';
				    }
				    
				    
				    
				    html+='</div>'
				    
				    html+='<div class="text_body">';
				    html+='<section>';
				    
				    //아래라이크사진
			    	
				    html+='</div>'
				    html+='</section>'; 
				    
				   	 html+='<section>';
				   		
						
				   		
					    /* for(var j=0; j<data[i].guest_comment.length; j++){
					    html+='<div class="cmtnick">'+data[i].guest_comment[j].member_nick+'</div>';
					    html+='<div class="cmttext">'+data[i].guest_comment[j].comment_text+'</div>';
					    } */
					    
					    
					   
				    html+='</section>'; 
				    html+='</div>';
				    html+='</div>';
				    html+='</article>';
				}
			
			} // for문 끝 
			$('#sessionList').html(html);
			
		}		
	})
}




//댓글쓰기
function cmtWrite(guest_idx,text) {
	
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




//////////////게시글삭제함수
function deleteForm(a,b) {
	if(confirm('정말 삭제하시겠습니까?')){
		$.ajax({
			
			url:'http://localhost:8080/guest/guest_book/deletec',
			type : 'DELETE',
			dataType:'json',
			data :
				{
				guest_idx:a,
				guest_photo:b},
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
var r=$('#r').val();
////////////////////////글쓰기 함수
function guestPost() {
	
	
	var mImg=$('#member_img').val();
	
	// ~~구 글자 자르기
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








/////////////////////수정 팝업펑션
  function editService() {
	
	  var str2 = $('.edittext').val();
		str2 = str2.replace(/(?:\r\n|\r|\n)/g, '<br/>');
	
	
	var editFormData = new FormData();
	editFormData.append('guest_idx',$('#guest_idx').val());
	editFormData.append('guest_text',str2);
	
	if($('#oldphoto')!=null){
	editFormData.append('oldFile',$('#oldphoto').val());
	}
	console.log($('#oldphoto').val());

	
	if($('#photo')[0].files[0] !=null){
		editFormData.append('photo',$('#photo')[0].files[0]); // 파일첨부 코드	
	}
	$.ajax({
		url:'http://localhost:8080/guest/guest_book/edi' ,
		type:'POST',
		processData : false, // File 전송시 필수 
		contentType : false, // multipart/form-data 쓰는 코드
		data : editFormData,
		success : function (data) {
		alert('수정이 완료됐습니다');
			
			
		$('#layer_popup').bPopup().close();
		$('#editddd').bPopup().close();
		$("#popup").bPopup().close();
			gbList();
			
		}// 석세스끝
		
	});
	
}  




////////////////////// 에디트팝업
function editPopup(guest_idx) {
	$.ajax({
		url:'http://localhost:8080/guest/guest_book/'+guest_idx ,
		type:'GET',
		data : {nick:bb},
		success : function (data) {
			
			var html='';
			
				html+='<button class="btnz editform">게시글 수정</button>';
				html+='<button class="btnz deleteService" onclick="">게시글 삭제</button>';
				html+='<button class="btnz">'+data.guest_idx+'</button>';
				html+='<button class="btnz editdiv-close">취소</button>';
				
			$('#editddd').html(html);
			
			
			
			$('.deleteService').click(function () {
				
				var deidx=data.guest_idx;
				var dephoto=data.guest_photo;
				
				console.log(deidx);
				console.log(dephoto);
				deleteForm(deidx,dephoto);
			})
			
			
			$('.editform').click(function () {
				$('.ditform')[0].reset();
				$('#guest_idx').val(data.guest_idx);	
				
				console.log(data.guest_photo==null)
				
				$('.oldphoto').val(data.guest_photo);
				
			
				console.log($('#oldphoto').val());
				$('.wr').val(data.guest_writer);
				
				$('#layer_popup').bPopup();
				
			});
			
			
			
			
		}// 석세스끝
		
	});
	$("#editddd").bPopup({closeClass:'editdiv-close',
        opacity:0.4,
        modalClose:true}); // 열기
	
        ////////여기야
	
	};





	
	
	
	
	
////////////// 댓글 에디트폼 	
function cmtedit(comment_idx,guest_idx) {
	
	$.ajax({
		url:'http://localhost:8080/guest/guest_book/cmt/'+comment_idx ,
		type:'GET',
		success : function (data) {
			var html='';
			
				html+='<button class="btnz edittextform">댓글 수정</button>';
				html+='<button class="btnz deleteService" onclick="deleteCmt('+data.comment_idx+','+guest_idx+')">댓글 삭제</button>';
				html+='<button class="btnz editdiv-close2">'+comment_idx+'</button>';
				html+='<button class="btnz editdiv-close2">취소</button>';
				
			$('#editcmt').html(html);
			
			$('.edittextform').click(function () {
				$('.realcmteditform')[0].reset();
				
				$('#comment_idx').val(comment_idx);				
				$('#editguest_guest_idx').val(guest_idx);
				$('#realcmtedit').bPopup();
				
			})
			
			
			
			
			
		}// 석세스끝
		
	});
	$("#editcmt").bPopup({closeClass:'editdiv-close2'});
	
}	



//댓글수정
function editCmtText() {

	
	var idx=$('#editguest_guest_idx').val();
	
	var cmtedittext = $('.editformtext').val();
	var cmteditidx = $('#comment_idx').val();
	
	$.ajax({
		url:'http://localhost:8080/guest/guest_book/cmtedit',
		type:'PUT',
		data : {cmtedittext , cmteditidx},
		success : function (data) {
			
			$('#realcmtedit').bPopup().close();
			$("#editcmt").bPopup().close();
			gbList();
			goPopup(idx);
			
		}
	})
	
}


	
	

///////댓글 삭제
function deleteCmt(comment_idx,guest_idx) {
	console.log(guest_idx);
	if(confirm('정말 삭제하시겠습니까?')){
	$.ajax({
		url:'http://localhost:8080/guest/guest_book/delcmt/'+comment_idx,
		type:'DELETE',
		success : function (data) {
			
			alert("댓글이 삭제됐습니다");
			$("#editcmt").bPopup().close();
			gbList();
			goPopup(guest_idx);
			
			
		}
	});
	}
}















///////////////////// 팝업 함수
function goPopup(guest_idx) {
	
	$.ajax({
		url:'http://localhost:8080/guest/guest_book/'+guest_idx ,
		type:'GET',
		data: {nick : bb},
		success : function (data) {
			var html='';
			if(data.guest_photo !=null){
				html+='<article class="in_wrap">'
					html+='<div class="flex">'
						html+='<div class="in_photo"><img src="http://localhost:8080/guest/upload/'+data.guest_photo+'"></div>'
						html+='<div class="in_body">'
							html+='<header>'
								html+='<div class="hd_img"><img src="'+data.member_img+'"></div>';  
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
								 for(var j=0; j<data.guest_comment.length; j++){
								    		html+='<div class="flex mousecmt" id="mousecmt">';
									    html+='<div class="cmtnick_in" style="display:block;">'+data.guest_comment[j].member_nick+'</div>';
									    html+='<br/>'
									    html+='<div class="cmttext">'+data.guest_comment[j].comment_text+'</div>';
									    
									 if(data.guest_comment[j].member_nick === `${loginInfo.mNick}`){
									    	html+='<button class="dotpopup2" id="mousecmt" onclick="cmtedit('+data.guest_comment[j].comment_idx+','+data.guest_idx+');"><img src="${pageContext.request.contextPath}/resources/img/dot.png" style="width:15px;"></button>'
									    }
									 
									    html+='</div>';
									    }
							html+='</section>'
								html+='</div>'
							html+='</div>'
							html+='<section class="in_bottom">'
								if(data.checkLikes==1){
								    html+='<button class="footers likedownbtn" id="heartno"  onclick="likedown2('+data.guest_idx+'); likedowncount('+data.guest_idx+'); "><img id="heart" src="${pageContext.request.contextPath}/resources/img/redheart.png"></button>';
								    }else{
								    html+='<button class="footers likebtn" id="heartok" onclick="likeup2('+data.guest_idx+'); likeupcount('+data.guest_idx+');"><img id="heart" src="${pageContext.request.contextPath}/resources/img/love.png"></button>';
								    } 
						    html+='<button class="gomsg"><img src="${pageContext.request.contextPath}/resources/img/msg.png"></button>';
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
					html+='<div class="hd_img"><img src="'+data.member_img+'"></div>';  
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
					 for(var j=0; j<data.guest_comment.length; j++){
				    		html+='<div class="flex mousecmt" id="mousecmt">';
					    html+='<div class="cmtnick_in" style="display:block;">'+data.guest_comment[j].member_nick+'</div>';
					    html+='<br/>'
					    html+='<div class="cmttext">'+data.guest_comment[j].comment_text+'</div>';
					    if(data.guest_comment[j].member_nick === `${loginInfo.mNick}`){
						    	html+='<button class="dotpopup2" id="mousecmt" onclick="cmtedit('+data.guest_comment[j].comment_idx+','+data.guest_idx+');"><img src="${pageContext.request.contextPath}/resources/img/dot.png" style="width:15px;"></button>'
						    }
					 
					    html+='</div>';
					    }
				html+='</section>'
					html+='</div>'
				html+='</div>'
				html+='<section class="in_bottom">'
					 if(data.checkLikes==1){
						    html+='<button class="footers likedownbtn" id="heartno"  onclick="likedown2('+data.guest_idx+'); likedowncount('+data.guest_idx+'); "><img id="heart" src="${pageContext.request.contextPath}/resources/img/redheart.png"></button>';
						    }else{
						    html+='<button class="footers likebtn" id="heartok" onclick="likeup2('+data.guest_idx+'); likeupcount('+data.guest_idx+');"><img id="heart" src="${pageContext.request.contextPath}/resources/img/love.png"></button>';
						    } 
			    html+='<button class="gomsg"><img src="${pageContext.request.contextPath}/resources/img/msg.png"></button>';
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
			
			
			
			$('#innerView').html(html);
			
		
			
			
			$('.cmtsb2').click(function () {
				var a=$(this).next().val();
				var b=$(this).prev().val();
				cmtWrite(a,b);
				goPopup(guest_idx);
				goPopup(guest_idx);
			});
			
			
			$('.gomsg').click(function () {
				$('.in_cmtwr').focus();
				$('.in_cmtwr_null').focus();
			});
			
			$('.mousecmt').mouseover(function () {
				var btn=$(this).find('button');
				btn.show();
				/* $('.dotpopup2').show(); */
			});			
			
			$('.mousecmt').mouseleave(function () {
				$('.dotpopup2').hide();
			})	
			
		}// 석세스끝
		
	});
	$("#popup").bPopup(); // 열기
	
	};



	
	  /*  if(data[i].guest_writer == ${loginInfo.mNick}){
	    	html+='<div>안녕</div>'
	    } */
	
	    

	    
	    
	    var page = 0;
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
			 member_radius :'${loginInfo.mRadius}',
			 limit : page,
			 nick : bb
			
		 },
		success : function (data) {
			
			
			var html='';
			for(var i=0; i<data.length; i++){
				if(data[i].guest_photo !=null){
				html+='<article class="have_photo">';
			    html+='<header>';
			    html+='<input type="hidden" name="guest_idx" class="idx" value="'+data[i].guest_idx+'">';
			    //아래가 멤버프로필이미지 가져와야함
			    html+='<div class="hd_img" ><img src="'+data[i].member_img+'"></div>';  
			    //아래가 멤버닉네임가져와야함
			    html+='<div class="hd_nick">';
			    html+=data[i].guest_writer
			    html+='<span class="addr">'+data[i].guest_addr+'</span>';
			    if(data[i].guest_writer === `${loginInfo.mNick}`){
			    	html+='<button class="dotpopup" onclick="editPopup('+data[i].guest_idx+');"><img src="${pageContext.request.contextPath}/resources/img/dot.png" style="width:15px;"></button>'
			    }
			    html+='</div>'
			    html+='</header>';
			    html+='<div class="photo_body"><img src="http://localhost:8080/guest/upload/'+data[i].guest_photo+'"></div>';
			    //html+='<div class="photo_body"><img src="https://img1.daumcdn.net/thumb/R720x0.q80/?scode=mtistory2&fname=http%3A%2F%2Fcfile26.uf.tistory.com%2Fimage%2F2369374A56F366BB34731F"></div>';
			    html+='<div class="text_body">';
			    html+='<section>';
			    
			    //아래라이크사진
			    if(data[i].checkLikes==1){
				    html+='<button class="footers likedownbtn" id="heartno"  onclick="likedown('+data[i].guest_idx+'); likedowncount('+data[i].guest_idx+'); "><img id="heart" src="${pageContext.request.contextPath}/resources/img/redheart.png"></button>';
				    }else{
				    html+='<button class="footers likebtn" id="heartok" onclick="likeup('+data[i].guest_idx+'); likeupcount('+data[i].guest_idx+');"><img id="heart" src="${pageContext.request.contextPath}/resources/img/love.png"></button>';
				    } 
		    	html+='<button onclick="goPopup('+data[i].guest_idx+')"><img id="mmsg" src="${pageContext.request.contextPath}/resources/img/msg.png"></button>';
		    	
			    html+='<div class="likes" id="likes">좋아요<span class="dlikes" id="dlikes">'+data[i].guest_like+'</span>개</div>';
			    html+='</div>'
			    html+='</section>'; 
			    
			    html+='<div class="content">';
			    html+='<div class="nonerealtext" id="nonerealtext2">'+data[i].guest_text+'<br>';
			   
			    html+='</div>';
			    if(data[i].guest_text.includes('<br/>')){
			    	html+='<span class="more">더보기</span>';
			    }
			    html+='</div>';
			    html+='<div class="comment">';
			    if(data[i].guest_comment.length !=0){
			    html+='<button class="cmtnum" onclick="goPopup('+data[i].guest_idx+')">댓글 모두보기</button>';
			    }
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
			    html+='<input type="text" class="cmtwr"  placeholder="    댓글 달기">';
			    html+='<input type="submit" class="cmtsb-wr" value="등록">';
			    html+='<input type="hidden" class="cmtwrtext" value="'+data[i].guest_idx+'">';
			    html+='</div>';
			    html+='</div>'; 
			    html+='</article>';
				} else if(data[i].guest_photo ==null){
					html+='<article class="none_photo">';
					
				    html+='<header>';
				    html+='<input type="hidden" name="guest_idx" class="idx" value="'+data[i].guest_idx+'">';
				    html+='<div class="hd_img");"><img src="'+data[i].member_img+'"></div>'; 
				    html+='<div class="hd_nick">';
				    html+=data[i].guest_writer
				    html+='<span class="addr">'+data[i].guest_addr+'</span>';
				    if(data[i].guest_writer === `${loginInfo.mNick}`){
				    	html+='<button class="dotpopup" onclick="editPopup('+data[i].guest_idx+');"><img src="${pageContext.request.contextPath}/resources/img/dot.png" style="width:15px;"></button>'
				    }
				    html+='</div>'
				    html+='</header>';
				   
				    
				    html+='<div class="null_content">'
				    html+='<div class="nonerealtext" id="nonerealtext2">'+data[i].guest_text+'</div>'
				    if(data[i].guest_text.includes('<br/>')){
				    	html+='<span class="more" style="margin-left:13px; color:gray;">더보기</span>';
				    }
				    
				    
				    
				    html+='</div>'
				    
				    html+='<div class="text_body">';
				    html+='<section>';
				    
				    //아래라이크사진
				    if(data[i].checkLikes==1){
				    html+='<button class="footers likedownbtn" id="heartno"  onclick="likedown('+data[i].guest_idx+'); likedowncount('+data[i].guest_idx+'); "><img id="heart" src="${pageContext.request.contextPath}/resources/img/redheart.png"></button>';
				    }else{
				    html+='<button class="footers likebtn" id="heartok" onclick="likeup('+data[i].guest_idx+'); likeupcount('+data[i].guest_idx+');"><img id="heart" src="${pageContext.request.contextPath}/resources/img/love.png"></button>';
				    } 
			    	html+='<button onclick="goPopup('+data[i].guest_idx+')"><img id="mmsg" src="${pageContext.request.contextPath}/resources/img/msg.png"></button>';
			    	
				    html+='<div class="likes" id="likes">좋아요<span class="dlikes" id="dlikes">'+data[i].guest_like+'</span>개</div>';
				    html+='</div>'
				    html+='</section>'; 
				    
				    html+='<div class="comment">';
				    if(data[i].guest_comment.length !=0){
					    html+='<button class="cmtnum" onclick="goPopup('+data[i].guest_idx+')">댓글 모두보기</button>';
					    }
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
				    html+='<input type="submit" class="cmtsb-wr" value="등록">';
				    html+='<input type="hidden" class="cmtwrtext" value="'+data[i].guest_idx+'">';
				    html+='</div>';
				    html+='</div>';
				    html+='</article>';
				}
			
			} // for문 끝 
				
			
			
					$('#guestbookList').html(html);
					
					
					
					$('.cmtsb').click(function () {
						$('#guest_photo').val('');
					});	
			
				
			$('.cmtsb-wr').click(function () {
				var a=$(this).next().val();
				var b=$(this).prev().val();
				cmtWrite(a,b);
				$('#guest_photo').val('');
			});
			
			
			$('.likebtn').click(function () {
				
				/* 	var a=$(this).next();
					var b = a.next();
					var c = b.next();
					var d =c.children('.dlikes').text();
					d=Number(d)+1;
					c.children('.dlikes').text(d); */
					//$(this).hide();
					//a.show();
					
				
					
					
			});
			
			
			$('.likedownbtn').click(function () {
				
			/* 	var a=$(this).next();
				var b = a.next();
				var c = b.children('.dlikes').text();
				
				c=Number(c)-1;
				b.children('.dlikes').text(c); */
				//$(this).hide();
				//$(this).prev().show();
				
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
			
			
			var current=$('article').length-1;
			
			
			$('.hd_img').click(function () {
				writerList(bb);
			})
			
			
			
			
			
			
			
			
			///////////// 게시글 토탈카운트 구하는 에이젝스 실행 
			$.ajax({
				url:'http://localhost:8080/guest/guest_book/test',
				type:'GET',
				contentType: 'application/json; charset=utf-8',
				data : {
					 x :x,
					 y :y,
					 r :r
				},
				success : function (data) {
			
					
					
					/////// 만약 페이지가 토탈카운트보다 많다면 스크롤이벤트종료 
					console.log('페이지'+page);
					if(data<page){
						
						console.log("끝"+page);
						$(window).off();
					}		 
				}
			});
		
			
			//console.log('페이지':page);
			
			
		} // success끝 
		
		
		
		
		
	}); // ajax끝 
	
}



///////////////////// 좋아요 증감 함수 에디트버전 
function likeup2(guest_idx) {
	$.ajax({
		url:'http://localhost:8080/guest/guest_book/plus/'+guest_idx,
		type:'POST',
		data :  
			 bb ,
		contentType: 'application/json; charset=utf-8',
		success : function (data) {
			goPopup(guest_idx);
			gbList();
		}
	});
}

///////////////////// 좋아요 감소 함수 에디트버전
function likedown2(guest_idx) {
	$.ajax({
		url:'http://localhost:8080/guest/guest_book/mi/'+guest_idx,
		type:'DELETE',
		data:bb,
		contentType: 'application/json; charset=utf-8',
		success : function (data) {
			goPopup(guest_idx);
			gbList();
		}
	});
} 



///////////////////// 좋아요 증감 함수
  function likeup(guest_idx) {
		$.ajax({
			url:'http://localhost:8080/guest/guest_book/plus/'+guest_idx,
			type:'POST',
			data :  
				 bb ,
			contentType: 'application/json; charset=utf-8',
			success : function (data) {
				gbList();
			}
		});
	}
			
			
			
///////////////////// 좋아요 감소 함수
	function likedown(guest_idx) {
		$.ajax({
			url:'http://localhost:8080/guest/guest_book/mi/'+guest_idx,
			type:'DELETE',
			data:bb,
			contentType: 'application/json; charset=utf-8',
			success : function (data) {
				gbList();
			}
		});
	} 
	
			
/* -----------------------------------숫자만--------------------------- */
			
//////////////////// 좋아요 숫자 증가 함수
function likeupcount(guest_idx) {
	$.ajax({
		url:'http://localhost:8080/guest/guest_book/pluscount/'+guest_idx,
		type:'PUT',
		contentType: 'application/json; charset=utf-8',
		success : function (data) {
			gbList();
		}
	});
}

////////////////////좋아요 숫자 감소 함수
function likedowncount(guest_idx) {
	$.ajax({
		url:'http://localhost:8080/guest/guest_book/micount/'+guest_idx,
		type:'PUT',
		contentType: 'application/json; charset=utf-8',
		success : function (data) {
			gbList();
		}
	});
}






$(document).ready(function () {
	$('main').attr('style','background-color:white !important');
	gbList(page=4);
	
	$(window).scroll(function() {
		  if($(window).scrollTop() +1 >= $(document).height() - $(window).height()) {
	///////// 스크롤 한번갱신때마다 페이지를 +4씩 올려라 
	    	page=page+4
	
	        gbList(); 
	        //console.log(page)
	    }
	});

});
</script>


</body>
</html>