<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CHTTING3</title>
<c:if test="${loginInfo==null}">
	<script>
		alert('로그인해야 이용가능합니다');
		location.href='/mangh/';
	</script>
</c:if>

<style>


</style>

<link rel="stylesheet" href="<c:url value="/resources/css/kjj.css"/>">
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/kjj-header.jsp" />
	<!-- 큰화면 중간화면 -->
	<div class="w3-card" id="ml-screen">
		<!-- 상단바 -->
		<div class="w3-row" id="top-bar" style="height: 90px">
			<div class="w3-col m5 l4 w3-theme w3-border-bottom w3-border-white w3-padding-large w3-padding-16">
				<div class="w3-quarter w3-center" style="padding-top: 3px;">
					<button class="fa fa-search w3-large w3-round-large w3-border wr-border-white w3-button" id="room-search-btn" style="padding: 12px;">
					</button>
				</div>
				<div class="w3-threequarter">
					<input type="text" class="w3-theme w3-round-large w3-input w3-animate-input" id="roomSearch" placeholder="채팅상대방 닉네임입력...">
				</div>
			</div>
			
			<div class="w3-col m7 l8 w3-white w3-bottombar w3-border-theme top-bar-receiver">
				<!-- 동적생성할 부분 -->
				<div class="w3-col l3 w3-center w3-hide-medium w3-padding" id="chatuserImg">
					<%-- <img src="<c:url value="/resources/img/testimg.png"/>" id="chatuser" class="w3-circle"/> --%>
				</div>
				<div class="w3-col m9 l6 w3-padding top-bar-title" style="line-height: 60px;">
					<!-- <b id="chat-user-nick" style="font-size: 1.3em; font-weight: bold;">테스트용</b>&nbsp;&nbsp;님과의 대화 -->
				</div>
				<div class="w3-col m3 l3 w3-center w3-text-theme">
					<div class="hamburger w3-padding-16">
						<svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-three-dots-vertical" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
						  <path fill-rule="evenodd" d="M9.5 13a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm0-5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0z"/>
						</svg>
					</div>
					<div class="dropdown-content w3-animate-down w3-right w3-card" style="right: 0px;">
					    <a href="#" class="w3-button w3-col w3-padding-16 w3-text-theme out-room">
						    <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-door-open-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
								<path fill-rule="evenodd" d="M1.5 15a.5.5 0 0 0 0 1h13a.5.5 0 0 0 0-1H13V2.5A1.5 1.5 0 0 0 11.5 1H11V.5a.5.5 0 0 0-.57-.495l-7 1A.5.5 0 0 0 3 1.5V15H1.5zM11 2v13h1V2.5a.5.5 0 0 0-.5-.5H11zm-2.5 8c-.276 0-.5-.448-.5-1s.224-1 .5-1 .5.448.5 1-.224 1-.5 1z"/>
							</svg>
							<b>나가기</b>
					    </a>
						<a href="#" class="w3-button w3-col w3-padding-16 w3-text-theme confirm-room-del">
						<svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-trash-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
 						 <path fill-rule="evenodd" d="M2.5 1a1 1 0 0 0-1 1v1a1 1 0 0 0 1 1H3v9a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V4h.5a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H10a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1H2.5zm3 4a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 .5-.5zM8 5a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7A.5.5 0 0 1 8 5zm3 .5a.5.5 0 0 0-1 0v7a.5.5 0 0 0 1 0v-7z"/>
						</svg>
						 	<b>삭제</b>
						</a>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 내용바-->
		<div class="w3-row content-area">
			<div class="w3-col m5 l4 w3-theme-l1 chatRoomArea">
				<ul class="w3-ul" id="chat-room-list">
					<%-- <c:set var="arr" value="<%= new int[]{1,2,3,4,5,6,7,8,9,10,11,12} %>"/>
					<c:forEach items="${arr}" end="12">
					<li class="w3-row" style="border:0">
						<div class="w3-col m10 l10 w3-padding-small title-chatRoom">
							<b class="chat-nick">테스트용</b><br>
							<span>제목 : 망치좀 빌려주실분망치좀 빌려주실분망치좀 빌려주실분망치좀 빌려주실분</span>							
						</div>
						<span class="w3-col m1 l1 w3-badge w3-red" id="badge">8</span>
					</li>
					</c:forEach> --%>
				</ul>
			</div>
			<!-- 채팅메세지구역 -->
			<div class="w3-col m7 l8 w3-border-left w3-border-white msg-content">
				<!-- 게시물에대한 정보 -->
				<div class="w3-row w3-padding w3-border-bottom w3-border-theme info-area">
					<div id="req-writer"></div>
					<div id="req-title"></div>
					<div id="req-loc"></div>
				</div>
				
				<div class="w3-row w3-white msg-area">
					<!-- 메세지 출력 부분 -->
				</div>
				
				<!-- 인풋 버튼 모음 -->
				<div class="w3-row w3-white input-area w3-border w3-border-theme">
					<div class="w3-col m2 l1">
						<button class="w3-button w3-theme img-select-btn" >
							<svg width="1.5em" height="1.5em" viewBox="0 0 16 16" class="bi bi-image" fill="currentColor" xmlns="http://www.w3.org/2000/svg" style="top:5px;">
								<path fill-rule="evenodd" d="M14.002 2h-12a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V3a1 1 0 0 0-1-1zm-12-1a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2h-12z"/>
								<path d="M10.648 7.646a.5.5 0 0 1 .577-.093L15.002 9.5V14h-14v-2l2.646-2.354a.5.5 0 0 1 .63-.062l2.66 1.773 3.71-3.71z"/>
								<path fill-rule="evenodd" d="M4.502 7a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"/>
							</svg>
						</button>
					</div>
					<div class="w3-col m7 l9" >
					<input type="text" name="msgText" placeholder="메세지 입력..." id="msg-text"/>
					</div>					
					<div class="w3-col m3 l2" >
						<button class="w3-button w3-theme send-msg">
						<span>전송</span>
						<svg width="1.5em" height="1.5em" viewBox="0 0 16 16" class="bi bi-cursor" fill="currentColor" xmlns="http://www.w3.org/2000/svg" style="top:5px;">
							<path fill-rule="evenodd" d="M14.082 2.182a.5.5 0 0 1 .103.557L8.528 15.467a.5.5 0 0 1-.917-.007L5.57 10.694.803 8.652a.5.5 0 0 1-.006-.916l12.728-5.657a.5.5 0 0 1 .556.103zM2.25 8.184l3.897 1.67a.5.5 0 0 1 .262.263l1.67 3.897L12.743 3.52 2.25 8.184z"/>
						</svg>
						</button>
					</div>
				</div>
			</div>
		</div>
	<!-- <br>
	확인용
	<input type="text" id="curr-room" value=""> 
	<input type="text" id="curr-user" value="">
	<input type="text" id="curr-req" value=""> -->
	</div>
	<!-- 모달 -->
	<div id="img-modal" class="w3-modal">
		<div class="w3-modal-content w3-animate-top" style="width: 50%">
			<header class="w3-container w3-theme">
				<span class="w3-button w3-display-topright w3-xlarge closeImgModal">&times;</span>
				<h3>사진 보내기</h3>
			</header>
			<div class="w3-container">
				<p>사진을 선택하세요</p>
				<p><input type="file" name="msgPhoto" id="msgPhoto"></p>
				<p><button class="w3-button w3-round-large w3-theme imgSelect">선택완료</button></p>
			</div>
		</div>
	</div>
	<div id="click-img-modal" class="w3-modal" onclick="this.style.display='none'">
 		<img class="w3-modal-content w3-display-middle" id="clickImg" style="width:50%">
	</div>
	
	<div id="ask-delroom-modal" class="w3-modal">
		<div class="w3-modal-content w3-animate-top" style="width: 50%">
			<header class="w3-container w3-theme"> 
					<h3>채팅방 삭제</h3>
			</header>
			<div class="w3-container">
				<h3 class="w3-center">채팅방을 삭제하면 이전의 모든 메세지가 삭제되며<br>상대방에게 더이상 메세지를 받을 수 없습니다.</h3>
  				<h3 class="w3-center">삭제하시겠습니까?</h3>
				<p class="w3-center">
				<button class="w3-button w3-xlarge w3-round-large w3-red delRoomYes w3-margin-right">삭제</button>
				<button class="w3-button w3-xlarge w3-round-large w3-theme delRoomNo w3-margin-left">취소</button>
				</p>
			</div>
		</div>
	</div>
	<!-- 메세지 클릭시  -->
	<div id="msg-modal" class="w3-modal">
		<div class="w3-white w3-modal-content w3-center w3-padding" style="width: 200px;">
			<button class="w3-button w3-red w3-round w3-center" id="msg-del" style="width: 150px;">메세지 삭제</button>
			<button class="w3-button w3-theme3-l2 w3-round" id="msg-modal-close" style="width: 150px;">닫기</button>
		</div>
	</div>
	<!-- 이미지 클릭시 확대 -->
	<div id="img-zoom-modal" class="w3-modal img-zoom-modal w3-center" onclick="this.style.display='none'">
		<img class="w3-modal-content clickImg" id="clickImg" style="">
	</div>
	
	
	<!-- 작은 화면 -->
	<div class="w3-row "></div>
	<jsp:include page="/WEB-INF/views/include/kjj-footer.jsp" />
	
<script>
$(document).ready(function(){
	
	//전송버튼 비활성화
	$('.send-msg').attr('disabled', true);
	
	//검색실행이벤트
	$('#room-search-btn').on('click',function(){
		console.log('검색 실행');
		$('#roomSearch').val('');
	});
	
	//채팅방 검색 
	$('#roomSearch').on('keyup',function(e){
		var $chatNick =$('.chat-room').find('.chat-nick');
		var b= $('#chat-room-list');
		if($(this).val().length>0){
			for(var i =0;i<$chatNick.length;i++){
				if(!$chatNick[i].innerText.match($(this).val())){
					$($chatNick[i]).parent().parent().hide();
				}else{
					$($chatNick[i]).parent().parent().show();
				}
			}
		}else{
			$($chatNick).parent().parent().show();
		}
		
		if(e.keyCode===13){
			$('#room-search-btn').trigger('click');
		}
	});
	
	//전송버튼 클릭 이벤트
	$('.send-msg').on('click',function(){
		if (roomIdx > -2 && $('#msg-text').val().length > 0&&delUser==null) {
			console.log('메세지전송 !!');
			sendMsg();
		}else if(delUser!=null){
			alert('대화 종료한 상대에게는 메세지를 보낼수 없어요');
		}else if(roomIdx==-2){
			alert('메세지를 선택해주세요');
		}else if($('#msg-text').val().length == 0){
			alert('메세지를 입력해주세요 ');
		}
		$('#msg-text').val('');
		$('.send-msg').attr('disabled', true);
		$('#img-modal').hide();
	});
	
	//처음 페이지에 들어왔을때 '메세지선택'지시문구
	$('.top-bar-title').html(notChoiceMsg);
	
	//키보드 이벤트
	$('#msg-text').on('keyup',function(e){
		if(roomIdx<-1||$(this).val().length==0){
			$('.send-msg').attr('disabled', true);
		}else{
			$('.send-msg').attr('disabled', false);
		}
		if(e.keyCode===13){
			$('.send-msg').attr('disabled', true);
		}
	});
	$('#msg-text').on('keypress',function(e){
		if(e.keyCode===13){
			$('.send-msg').trigger('click');
		}
	});
	
	//이미지 선택이벤트
	$('.img-select-btn').on('click',function(){
		$('#msg-text').val('');
		$('#img-modal').show();
	});
	$('.closeImgModal').on('click',function(){
		$('#img-modal').hide();
	});
	$('.imgSelect').on('click',function(){
		if(roomIdx>-2 && $('#msgPhoto')[0].files[0]!=null&&delUser==null){
			console.log('메세지전송 !!');
			sendMsg();
		}else if($('#msgPhoto')[0].files[0]==null){
			alert('사진을 선택하지 않았어요 ');
		}else if(delUser!=null){
			alert('대화 종료한 상대에게는 메세지를 보낼수 없어요');
		}else if(roomIdx==-2){
			alert('메세지를 선택해주세요');
		}
		$('#msgPhoto').val(null);
		$('.send-msg').attr('disabled', true);
		$('#img-modal').hide();
	});
	
	if(${msgInfo!=null}){
		currRoom =-1;
		var reqIdx = Number('${msgInfo.reqIdx}'); 
		var reqWriter = '${msgInfo.uNick}';
		insertTopBarReq(reqIdx);
		insertTopBarTitle(reqWriter);
		insertTopBarImg(reqWriter);
		$('#msg-text').focus();
	}
});

//배포한 aws경로
var aws= 'http://ec2-13-125-249-249.ap-northeast-2.compute.amazonaws.com:8080';
var localhost='http://localhost:8080';
var path = aws;
//클라이언트의 uri
var uri = '${pageContext.request.requestURI}';
var uploadPath = '<c:url value="/resources/img/upload/"/>';
//로그인한 사용자
var loginUser= '${loginInfo.mNick}';
//게시판 타고 들어왔을시 게시글 번호와 게시글 작성자 정보 받음 
var msgInfo;

</script>
<script src="<c:url value="/resources/js/kjj/socket.js"/>"></script>
<script src="<c:url value="/resources/js/kjj/kjj.js"/>"></script>
</body>
</html>