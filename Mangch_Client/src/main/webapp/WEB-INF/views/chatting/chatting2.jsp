<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value="/resources/css/kjj.css"/>">
<c:if test="${loginInfo==null}">
	<script>
		alert('로그인해야 이용가능합니다');
		location.href='/mangh/';
	</script>
</c:if>
<style>
.badge{
	font-weight: bold;
}
.msgContainer{
	position: relative;
	
}
.msgdate{
	padding-left:5px; 
	padding-right:5px;
	padding-top: 10px;
	width:120px;
}
.sender{
	font-weight: bold;
}
.msg{
	margin-bottom: 5px;
	width: 80%;
}
.lMsg{
	border-radius: 0 15px 15px 15px;
}
.rMsg{
	border-radius: 15px 0 15px 15px;
}
.fa-trash{
	cursor: pointer;
}
.dateCon{
	background-color: #CFD8DC;
}
.imagebtn{
	cursor: pointer;
}
#msgimgtag{
	width: 250px;
}
.w3-cell{
	height: in
}
</style>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div class="w3-container">
		<div class="w3-row-padding">
			<div class="w3-col" style="width: 10%">
				<p></p>
			</div>
			<div class="w3-col" style="width: 80%">
				<div class="w3-row">
					<h1>채팅</h1>
				</div>
				<div class="w3-row">
					<div class="w3-container w3-third chatRoomArea">
						<div class="w3-row w3-indigo w3-padding chatlist">
							<h3>채팅방 목록</h3>
						</div>
						<div class="w3-row w3-light-grey chatRoomList">
							<ul class="w3-ul w3-margin chatRooms">
								<!-- 채팅방 목록 -->
								
							</ul>
						</div>
					</div>
					<div class="w3-container w3-twothird chatArea">
						<div class="w3-bar w3-indigo">
							<div class="w3-bar-item">
								<h3 class="receiver">
									<!-- 누구와의 대화 -->
									메세지를 선택해주세요
								</h3>
							</div>
							<div class="w3-bar-item w3-right trashIcon">
								<!-- 휴지통 아이콘 -->
							</div>
							
						</div>
						<div class="w3-row w3-light-grey w3-padding msgArea">
							<!-- 메세지 목록 -->
							
						</div>

						<div class="w3-cell-row w3-padding inputArea">
							<div class="w3-cell">
								<button class="w3-button w3-indigo w3-hover-blue w3-round-large imgModalBtn">
									<i class="fa fa-image"></i>
								</button>
							</div>
							<div class="w3-cell w3-container" style="width: 80%">
								<input class="w3-input w3-border w3-round-small" type="text" id="message">
							</div>
							<div class="w3-cell w3-container">
								<button class="w3-button w3-blue w3-center" id="sendBtn">
									전송 <i class="fa fa-plane"></i>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="w3-col" style="width: 10%">
				<p></p>
			</div>
		</div>
		
		<!-- 모달 -->
		<div id="modal" class="w3-modal">
			<div class="w3-modal-content w3-animate-top" style="width: 50%">
				<header class="w3-container w3-indigo"> 
					<span class="w3-button w3-display-topright w3-xlarge closeImgModal">&times;</span>
					<h3>사진 보내기</h3>
				</header>
				<div class="w3-container">
					<p>사진을 선택하세요</p>
					<p><input type="file" name="msgPhoto" id="msgPhoto"></p>
					<p><button class="w3-button w3-round-large w3-indigo imgSelect">선택완료</button></p>
				</div>
			</div>
		</div>
		<div id="clickImgModal" class="w3-modal" onclick="this.style.display='none'">
  			<img class="w3-modal-content w3-display-middle" id="clickImg" style="width:50%">
		</div>
		
		<div id="askDelChatRoomModal" class="w3-modal">
			<div class="w3-modal-content w3-animate-top" style="width: 50%">
				<header class="w3-container w3-indigo"> 
						<h3>채팅방 삭제</h3>
				</header>
				<div class="w3-container">
					<h3 class="w3-center">채팅방을 삭제하면 이전의 모든 메세지가 삭제되며<br>상대방에게 더이상 메세지를 받을 수 없습니다.</h3>
	  				<h3 class="w3-center">삭제하시겠습니까?</h3>
					<p class="w3-center">
					<button class="w3-button w3-xlarge w3-round-large w3-red delRoomYes w3-margin-right">삭제</button>
					<button class="w3-button w3-xlarge w3-round-large w3-indigo delRoomNo w3-margin-left">취소</button>
					</p>
				</div>
			</div>
		</div>
	</div>
	<!-- 확인용 -->
	<input type="text" id="currChatRoom" value=""> 
	<input type="text" id="currChatUser" value="">
	<input type="text" id="chatRoom-reqIdx" value="">
	<input type="button" id="getConnection">
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	
<script>
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

	<%-- <script src="<c:url value="/resources/js/kjj.js"/>"></script> --%>
</body>
</html>