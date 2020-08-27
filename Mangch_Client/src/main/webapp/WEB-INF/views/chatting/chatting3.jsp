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
				<div class="w3-threequarter">
					<input type="text" class="w3-theme w3-round-large w3-input w3-animate-input" id="roomSearch" placeholder="닉네임입력...">
				</div>
				<div class="w3-rest w3-center" style="padding-top: 3px;">
					<button class="fa fa-search w3-large w3-round-large w3-border wr-border-white w3-button" id="room-search-btn" style="padding: 12px;">
					</button>
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
	//이미지선택클릭
	evClickSelectImg();
	//메세지전송이벤트
	evClickMsg();
	//검색실행이벤트
	evClickSearch();
	
	$('.top-bar-title').html(notChoiceMsg);
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
var localhost = 'http://localhost:8080';
//클라이언트의 uri
var uri = '${pageContext.request.requestURI}';
var uploadPath = '<c:url value="/resources/img/upload/"/>';
//로그인한 사용자
var loginUser= '${loginInfo.mNick}';
//게시판 타고 들어왔을시 게시글 번호와 게시글 작성자 정보 받음 
var msgInfo;

</script>
<script src="<c:url value="/resources/js/kjj/socket.js"/>"></script>
<script src="<c:url value="/resources/js/kjj/tag.js"/>"></script>
<script src="<c:url value="/resources/js/kjj/ready.js"/>"></script>
<script src="<c:url value="/resources/js/kjj/kjj.js"/>"></script>
<!-- <script>
var code = {
	connection:'connection',
	message : 'message',
	delRoom : 'delete'
};
//로그인사용자
var loginUser = '${loginInfo.mNick}';
//현재 보고있는 채팅방(단순히 채팅페이지에 접속이면 -2)
var currRoom=-2;
//현재 보고있는 채팅방의 상대방
var currUser;
//클릭한 채팅방의 req Idx
var chatRoomReqIdx;
//클릭한 채팅방 삭제여부확인
var delChkCurrRoom={};
//현재페이지 URI
var uri = '${pageContext.request.requestURI}';

//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■웹소켓 시작■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
//websocket을 지정한 URL로 연결
//var sock = new SockJS("<c:url value="/echo"/>");
var sock = new SockJS("http://ec2-13-125-249-249.ap-northeast-2.compute.amazonaws.com:8080/mc-chat/chatting");
//websocket 서버에 접속하면 실행
sock.onopen = sendSession;
//websocket 서버에서 메시지를 보내면 자동으로 실행된다.
sock.onmessage = onMessage;
//websocket 과 연결을 끊고 싶을때 실행하는 메소드
sock.onclose = onClose;

//접속시 로그인세션정보 보내기
function sendSession(){
	var loginInfo = {
			code:code.connection,
			sender:loginUser,
			uri:uri
		}
	sock.send(JSON.stringify(loginInfo));
}

//메세지 보내기
//websocket으로 메시지를 보내겠다.
function sendMsgToSocket(msgData) {
	console.log(moment(new Date()).format('YYYY년 MM월 DD일'));
	var text=null;
	var img=null;
	if (msgData.text!=null&&msgData.text.length>0){
		text = msgData.text;
	}else {
		img = msgData.img;
	}
	var msg = {
		code : msgData.code,
		idx : msgData.idx,
		roomIdx : msgData.roomIdx,
		sender : msgData.sender, // 현재 페이지 작성자의 id를 작성
		receiver : msgData.receiver,
		text : text,
		img : img
	};
	sock.send(JSON.stringify(msg));
}

//evt 파라미터는 websocket이 보내준 데이터다.
function onMessage(evt) { //변수 안에 function자체를 넣음.
	chatList(chkNewMsg);
	var now = new Date();
	var msgData = JSON.parse(evt.data); //전달받은 JSON 데이터를 객체로변환 
	var idx = msgData.idx;
	var roomIdx = msgData.roomIdx;
	var sender = msgData.sender;
	var receiver = msgData.receiver;
	var text=null;
	var img=null;
	if (msgData.text!=null&&msgData.text.length>0){
		text = msgData.text;
	}else {
		img = msgData.img;
	}
	//해당 채팅방을 제일위로 갱신
	//$('.chatRoom[roomidx='+msgData.roomIdx+']').prependTo('.chatRooms');
	var $msgArea = $('.msgArea');
	var $msgCon = $msgArea.children('.msgContainer').last();
	if(currRoom==msgData.roomIdx){
		//새로온 메세지가 현재 접속한 채팅방이라면 메세지태그 만들어서 뿌리긔
		var html='';
		if($msgCon.attr('date')!=moment(now).format('YYYYMMDD')){
			html +='<div class="w3-cell-row w3-container w3-center">';
			html +='	<p class="w3-round-xxlarge dateCon">'+moment(now).format('MM월 DD일')+'</p>';
			html +='</div>';
		}
		switch(msgData.code){
			case code.message:
				console.log(msgData.code);
				if (msgData.sender != loginUser) {
					html += '<div class="w3-cell-row w3-container msgContainer" idx="'+msgData.idx+'" date="'+moment(now).format('YYYYMMDD')+'" sender="'+msgData.sender+'">';
					if($msgCon.attr('date')!=moment(now).format('YYYYMMDD') || $msgCon.attr('sender')!=msgData.sender){
					html += '	<div class="w3-cell-row">';
					html += '		<div class="w3-cell w3-left sender">'+msgData.sender+'</div>';
					html += '	</div>';
					}
					html += '	<div class="w3-cell-row w3-container w3-left msg" style="width:80%;">';
					//메세지가 이미지면 이미지출력, 텍스트면 텍스트 출력
					if(msgData.img!=null){
					html += '		<span class="w3-cell w3-blue w3-padding w3-left lMsg">';
					html += '		<img src="http://ec2-13-125-249-249.ap-northeast-2.compute.amazonaws.com:8080/mc-chat/resources/image/room'+msgData.roomIdx+'/'+msgData.img+'" id="msgimgtag" class="msgimgtag"></span>';
					}else{
					html += '		<span class="w3-cell w3-blue w3-padding w3-left lMsg">'+msgData.text+'</span>';
					}
					html += '		<span class="w3-cell w3-small msgdate w3-left w3-left-align">'+moment(now).format('a HH:DD')+'</span>';
					html += '	</div>';
					html += '</div>';
				} else {
					html += '<div class="w3-cell-row w3-container msgContainer" idx="'+msgData.idx+'" date="'+moment(now).format('YYYYMMDD')+'" sender="'+msgData.sender+'">';
					if($msgCon.attr('date')!=moment(now).format('YYYYMMDD') || $msgCon.attr('sender')!=msgData.sender){
					html += '	<div class="w3-cell-row">';
					html += '		<div class="w3-cell w3-right sender">'+msgData.sender+'</div>';
					html += '	</div>';
					}
					html += '	<div class="w3-cell-row w3-container w3-right msg" style="width:80%;">';
					//메세지가 이미지면 이미지출력, 텍스트면 텍스트 출력
					if(msgData.img!=null){
					html += '		<span class="w3-cell w3-green w3-padding w3-right rMsg">';
					html += '		<img src="http://ec2-13-125-249-249.ap-northeast-2.compute.amazonaws.com:8080/mc-chat/resources/image/room'+msgData.roomIdx+'/'+msgData.img+'" id="msgimgtag" class="msgimgtag"></span>';
					}else{
					html += '		<span class="w3-cell w3-green w3-padding w3-right rMsg">'+msgData.text+'</span>';
					}
					html += '		<span class="w3-cell w3-small msgdate w3-right w3-right-align">'+moment(now).format('a HH:DD')+'</span>';
					html += '	</div>';
					html += '</div>';
				}
				break;
			case code.delRoom:
				console.log(msgData.code);
				if(currRoom == msgData.roomIdx){
					$msgArea.append(msgData.text);
				}
				delRoomClick();
				break;
		}
		$msgArea.append(html);
		$('.msgArea').scrollTop($('.msgArea')[0].scrollHeight);
		
	}else{
		//새로 온 메세지의 채팅방이 현재 보고있는 채팅방이 아닐때
		/* switch(msgData.code){
			case code.message:
				console.log(msgData.code);
				var badge=$('.chatRoom[roomidx='+msgData.roomIdx+']> .badge');
				badge.text(Number(badge.text())+1);
				controllBadge(); 
				break;
			case code.delRoom:
				console.log(msgData.code);
				var titletext = $('.chatRoom[roomidx='+msgData.roomIdx+'] .titletext');
				titletext.append('<span class="w3-red">상대방이 채팅을 종료했습니다</span>'); 
				break;
		} */
	}
}

function onClose(evt) {
	//$("#data").append("연결 끊김");
}
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■웹소켓 끝■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
function delRoomClick(){
	//채팅방 삭제모달 삭제버튼
	$('.delRoomYes').click(function(){
		if(currRoom!=-1&&currRoom!=-2){
			console.log('delYesClick:'+currRoom);
			delChatRoom(currRoom);
		}else{
			alert('채팅방이 존재하지 않습니다');
		}
		$('#askDelChatRoomModal').hide();
	});
}
//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ ready function 시작 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
$(document).ready(function() {
	
	//채팅방 삭제모달 취소버튼	
	$('.delRoomNo').click(function(){
		$('#askDelChatRoomModal').hide();
	});
	
	delRoomClick();
	
	//사진보내기모달 열기버튼
	$('.imgModalBtn').click(function(){
		$('#modal').show();
		$('#message').val('');
	});
	
	//사진보내기모달 닫기버튼
	$('.closeImgModal').click(function(){
		$('#modal').hide();
	});
	
	//사진선택완료 버튼 클릭이벤트
	$('.imgSelect').click(function(){
		if($('#msgPhoto')[0].files[0]==null){
			alert('이미지가 선택되지 않았어요');
		}else{
			sendMsg();
			$('#modal').hide();
			$("#msgPhoto").val('');
		}
	});
	
	//메세지가 없을때 전송버튼 비활성화
	$('#message').keyup(function(e) {
		if (currRoom == -2 || $('#message').val().length == 0 ||delChkCurrRoom[currRoom]!=null) {
			$('#sendBtn').attr('disabled', true);
		} else if(currRoom > -2 && $('#message').val().length > 0&&delChkCurrRoom[currRoom]==null){
			$('#sendBtn').attr('disabled', false);
		}
		//엔터쳤을때 메세지 전송(전송버튼 강제클릭)
		if (e.keyCode == 13) {
			$('#sendBtn').trigger('click');
		}
	});
	
	//전송버튼 클릭시 메세지 전송
	$('#sendBtn').click(function() {
		//단순히 채팅페이지에 들어왔거나 메세지길이가 0이면 전송안됨
		if (currRoom > -2 && $('#message').val().length > 0) {
			if(delChkCurrRoom[currRoom]==null){
				console.log('메세지전송');
				sendMsg();
			}
		}
		$('#message').val('');
		$('#sendBtn').attr('disabled', true);
		$('#modal').hide();
	});
});//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ ready function 끝 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 


//먼저실행할 메서드(채팅방 )
//가장 먼저 실행할 function
function init(){
	if(${msgInfo!=null}){
		//게시글 작성자에게 처음 메세지를 보낼때
		currRoom = -1;
		currUser ='${msgInfo.uNick}';
		chatRoomReqIdx='${msgInfo.reqIdx}';
		$('.receiver').text(currUser+'님과의 대화');
		$('#message').focus();
	}else{
		chatRoomReqIdx=-1;
	}
	$('#sendBtn').attr('disabled', true);
	
	//debug
 	$('#currChatRoom').val(currRoom);
	$('#currChatUser').val(currUser);
	$('#chatRoom-reqIdx').val(chatRoomReqIdx);
}

//채팅방 삭제 아이콘 관리
function insertTrashDiv(){
	var $trashDiv= $('.trashIcon');
	var html='<i class="fa fa-trash w3-xxlarge w3-padding-large w3-hover-red w3-circle delChatRoom"></i>';
	if(currRoom>0){
		$trashDiv.html(html);
	}else 
	$('.delChatRoom').click(function(){
		$('#askDelChatRoomModal').show();
	});
	
}

//채팅방 삭제
function delChatRoom(currRoom){
	$.ajax({
		url : 'http://ec2-13-125-249-249.ap-northeast-2.compute.amazonaws.com:8080/mc-chat/chat/chatRoom',
		type : 'post',
		data : {
			delUser:delChkCurrRoom[currRoom],
			loginUser:loginUser,
			roomIdx:currRoom
		},
		success : function(data) {
			console.log(code.delRoom);
			var msgData = {
					code : code.delRoom,
					idx : null,
					roomIdx : currRoom,
					sender : loginUser, // 현재 페이지 작성자의 id를 작성
					receiver : currUser,
					text : null,
					img : null
			};
			sendMsgToSocket(msgData);
			delete delChkCurrRoom[currRoom];
			chatList(chkNewMsg);
			$('.msgArea').empty();
			$('.receiver').text('메세지를 선택해주세요');
			currRoom=-2;
			currUser;
			chatRoomReqIdx;
		}
		
	});
}

//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 메세지전송 시작 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
//메세지 전송 
function sendMsg() {
	var regFormData = new FormData();
	regFormData.append('roomIdx',currRoom);
	regFormData.append('sender',loginUser);
	regFormData.append('receiver',currUser);
	regFormData.append('text',$('#message').val());
	regFormData.append('reqIdx',chatRoomReqIdx);
	if($('#msgPhoto')[0].files[0]!=null){
		regFormData.append('msgPhoto',$('#msgPhoto')[0].files[0]); //file
	}
	$.ajax({
		url : 'http://ec2-13-125-249-249.ap-northeast-2.compute.amazonaws.com:8080/mc-chat/chat',
		type : 'post',
		processData: false, // File전송시 필수
		contentType: false, // false = Multipart/form-data
		data : regFormData,
		success : function(msgData) {
			var msgData = {
					code : code.message,
					idx : msgData.idx,
					roomIdx : msgData.roomIdx,
					sender : msgData.sender, // 현재 페이지 작성자의 id를 작성
					receiver : msgData.receiver,
					text : msgData.text,
					img : msgData.img
			};
			sendMsgToSocket(msgData);
			chatList(chkNewMsg);
		}
	});
}//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 메세지전송 끝 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 

//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 메세지리스트 시작 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
//클릭이벤트 : 내가 클릭한 채팅방의 메세지 리스트 가져오기
//메세지 리스트 가져오긔
function getMsgList(roomIdx) {
	const ma = $('.msgArea');
	$.ajax({
		url : 'http://ec2-13-125-249-249.ap-northeast-2.compute.amazonaws.com:8080/mc-chat/chat/' + roomIdx,
		type : 'get',
		data : {
			uNick : loginUser
		},
		success : function(msgList) {
			var lastMsg = msgList[msgList.length-1];
			var html = '';
			for (var i =0;i<msgList.length;i++) {
				//날짜가 바뀌면 날짜 출력
				if(msgList[i-1]==null||moment(msgList[i].date).format('YYYYMMDD')!=moment(msgList[i-1].date).format('YYYYMMDD')){
					html +='<div class="w3-cell-row w3-container w3-center">';
					html +='	<p class="w3-round-xxlarge dateCon">'+moment(msgList[i].date).format('MM월 DD일')+'</p>';
					html +='</div>';
				}
				
				if (msgList[i].sender != loginUser) {
					html += '<div class="w3-cell-row w3-container msgContainer" idx="'+msgList[i].idx+'" date="'+moment(msgList[i].date).format('YYYYMMDD')+'" sender="'+msgList[i].sender+'">';
					html += '	<div class="w3-cell-row">';
					//이전메세지의 발신자와 현재메세지의 발신자가 다르면 닉네임 출력하지만
					//이전메세지의 날짜랑 현재메세지의 날짜가 다르면 닉네임출력
					if(i==0){
						html += '		<div class="w3-cell w3-left sender">'+msgList[i].sender+'</div>';
					}else{
						if(msgList[i].sender!=msgList[i-1].sender||moment(msgList[i].date).format('YYYYMMDD')!=moment(msgList[i-1].date).format('YYYYMMDD'))
							html += '		<div class="w3-cell w3-left sender">'+msgList[i].sender+'</div>';
					}
					html += '	</div>';
					html += '	<div class="w3-cell-row w3-container w3-left msg" style="width:80%;">';
					//메세지가 이미지면 이미지출력, 텍스트면 텍스트 출력
					if(msgList[i].img!=null&&msgList[i].img.length>0){
						html += '		<span class="w3-cell w3-blue w3-padding w3-left lMsg">';
						html += '		<img src="http://ec2-13-125-249-249.ap-northeast-2.compute.amazonaws.com:8080/mc-chat/resources/image/room'+msgList[i].roomIdx+'/'+msgList[i].img+'" id="msgimgtag" class="msgimgtag"></span>';
					}else{
						html += '		<span class="w3-cell w3-blue w3-padding w3-left lMsg">'+msgList[i].text+'</span>';
					}
					html += '		<span class="w3-cell w3-small msgdate w3-left w3-left-align">'+moment(msgList[i].date).format('a h:mm')+'</span>';
					html += '	</div>';
					html += '</div>';
					
					
				} else {
					html += '<div class="w3-cell-row w3-container msgContainer" idx="'+msgList[i].idx+'" date="'+moment(msgList[i].date).format('YYYYMMDD')+'" sender="'+msgList[i].sender+'">';
					html += '	<div class="w3-cell-row">';
					//이전메세지의 발신자와 현재메세지의 발신자가 다르면 닉네임 출력하지만
					//이전메세지의 날짜랑 현재메세지의 날짜가 다르면 닉네임출력
					if(i==0){
						html += '		<div class="w3-cell w3-right sender">'+msgList[i].sender+'</div>';
					}else{
						if(msgList[i].sender!=msgList[i-1].sender||moment(msgList[i].date).format('YYYYMMDD')!=moment(msgList[i-1].date).format('YYYYMMDD'))
							html += '		<div class="w3-cell w3-right sender">'+msgList[i].sender+'</div>';
					}
					html += '	</div>';
					html += '	<div class="w3-cell-row w3-container w3-right msg" style="width:80%;">';
					//메세지가 이미지면 이미지출력, 텍스트면 텍스트 출력
					if(msgList[i].img!=null&&msgList[i].img.length>0){
						html += '		<span class="w3-cell w3-green w3-padding w3-right rMsg">';
						html += '		<img src="http://ec2-13-125-249-249.ap-northeast-2.compute.amazonaws.com:8080/mc-chat/resources/image/room'+msgList[i].roomIdx+'/'+msgList[i].img+'" id="msgimgtag" class="msgimgtag"></span>';
					}else{
						html += '		<span class="w3-cell w3-green w3-padding w3-right rMsg">'+msgList[i].text+'</span>';
					}
					html += '		<span class="w3-cell w3-small msgdate w3-right w3-right-align">'+moment(msgList[i].date).format('a h:mm')+'</span>';
					html += '	</div>';
					html += '</div>';
				}
			}//for문 종료
			ma.html(html);
			
			//채팅메세지 긁어올때 실행
			if(delChkCurrRoom[currRoom]!=null){
				var h ='<div class="w3-cell-row w3-container w3-center">';
				h +='	<p class="w3-round-xxlarge w3-red">상대방이 채팅을 종료했습니다.<br> 메세지를 보낼 수 없습니다</p>';
				h +='	<button class="w3-button w3-large w3-round-large w3-red delChatRoom">삭제</button>';
				h +='</div>';
				ma.append(h);
			}
			
			//스크롤 제일 밑으로 (최신메세지에 포커스 맞추기위해)
			$('.msgArea').scrollTop($('.msgArea')[0].scrollHeight);
			$('.msgimgtag').click(function(){
				console.log($(this).attr('src'));
				$('#clickImg').attr('src',$(this).attr('src'));
				$('#clickImgModal').show();
			});
			
			$('.delChatRoom').click(function(){
				$('#askDelChatRoomModal').show();
			});
			
		}
	});
}//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 메세지리스트 끝 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 

//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 채팅방리스트 시작 ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 
//채팅방 리스트 뽑긔
function chatList(func) {
	delChkCurrRoom={};
	const cl = $('.chatRooms');
	$.ajax({
		url : 'http://ec2-13-125-249-249.ap-northeast-2.compute.amazonaws.com:8080/mc-chat/chat/chatRoom',
		type : 'get',
		data : {
			uNick : loginUser
		},
		success : function(list) {
			var html = '';
			for (var i = 0; i < list.length; i++) {

				//로그인한 사용자와 채팅참여자1의 이름이 같을때
				if (loginUser == list[i].mbNick1) {
					html += '<li class="w3-bar w3-border w3-round-large w3-margin-bottom w3-white w3-hover-blue chatRoom"';
					html += ' roomIdx="'+ list[i].idx +'" opponent="'+list[i].mbNick2+'" reqIdx="'+ list[i].reqIdx +'">';
					html += '	<img src="<c:url value="/resources/img/memberDefault.png"/>" class="w3-bar-item w3-circle w3-hide-small" style="height: 70px;">';
					html += '	<div class="w3-bar-item titletext">';
					html += '		<span class="w3-large" style="font-weight: bold;">'+ list[i].mbNick2 +'</span><br> ';
					if(list[i].delUser != null){
						html += '	<span class="w3-red">상대방이 채팅을 종료했습니다</span>';
					}else if(list[i].reqIdx==0){
						html += '	<span class="w3-text-grey">' + list[i].reqTitle+ '</span>';
					}else{
						html += '	<span>' + list[i].reqTitle+ '</span>';
					}
					html += '	</div>';
					html += '</li>';
				//로그인한 사용자와 채팅참여자2의 이름이 같을때
				} else {
					html += '<li class="w3-bar w3-border w3-round-large w3-margin-bottom w3-white w3-hover-blue chatRoom"';
					html += ' roomIdx="'+ list[i].idx +'" opponent="'+list[i].mbNick1+'" reqIdx="'+ list[i].reqIdx +'">';
					html += '	<img src="<c:url value="/resources/img/memberDefault.png"/>" class="w3-bar-item w3-circle w3-hide-small" style="height: 70px;">';
					html += '	<div class="w3-bar-item titletext">';
					html += '		<span class="w3-large" style="font-weight: bold;">'+ list[i].mbNick1 +'</span><br> ';
					if(list[i].delUser != null){
						html += '	<span class="w3-red">상대방이 채팅을 종료했습니다</span>';
					}else if(list[i].reqIdx==0){
						html += '	<span class="w3-text-grey">' + list[i].reqTitle+ '</span>';
					}else{
						html += '	<span>' + list[i].reqTitle+ '</span>';
					}
					html += '	</div>';
					html += '</li>';
				}
				
				if(list[i].delUser != null){
					delChkCurrRoom[list[i].idx]=list[i].delUser;
				}
			}
			cl.html(html);
			//채팅방 클릭이벤트
			$('.chatRoom').click(function() {
				//$(this).children('.badge').css('visibility','hidden');
				currRoom = $(this).attr('roomIdx');
				currUser = $(this).attr('opponent');
				chatRoomReqIdx = $(this).attr('reqIdx');
				getMsgList(currRoom);
				$('.receiver').text(currUser+' 님과의 대화');
				insertTrashDiv();
				if(Number($(this).find('.badge').text())>0){
					$(this).find('.badge').text('0');
					controllBadge();
				}
				$('#message').focus();
				//debug : 클릭 동작확인
				$('#currChatRoom').val(currRoom);
				$('#currChatUser').val(currUser);
				$('#chatRoom-reqIdx').val(chatRoomReqIdx);
			});
			func();
		}
	});
}//■■■■■■■■■■■■■■■■■■■■■■■■■■■■■채팅방리스트 끝■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 

//현재 로그인한 사용자에게 새로운메세지가 있으면 메세지리스트 갱신
function chkNewMsg() {
	$.ajax({
		url : 'http://ec2-13-125-249-249.ap-northeast-2.compute.amazonaws.com:8080/mc-chat/chat',
		type : 'get',
		data : {
			uNick : loginUser
		},
		success : function(newMsgList) {
			if(newMsgList.length>0){
				console.log('new Msg 확인!');
			}
			//새로운 메세지가 있으면 메세지 개수만큼 뱃지달아주기 
			for(var i=0;i<newMsgList.length;i++){
				if(currRoom != newMsgList[i].roomIdx){
					var html='';
					html+='<span class="w3-bar-item w3-right w3-red w3-badge badge">'+newMsgList[i].newMsgCount+'</span>';
					$('.chatRoom[roomidx='+newMsgList[i].roomIdx+']').prepend(html);
					//$('.chatRoom[roomidx='+newMsgList[i].roomIdx+']> .badge').text(newMsgList[i].newMsgCount);
				}
			}
			controllBadge();
		}
	});
}

function controllBadge(){
	//새로운 메세지가 있으면 채팅방뱃지 보이기, 없으면 가리기
	$('.badge').each(function(i,x){
		if($(x).text()>0){
			$(x).css('visibility','visible');
		}else{
			$(x).css('visibility','hidden');
		}
	});
}
init();
chatList(chkNewMsg);
</script>
 -->
</body>
</html>