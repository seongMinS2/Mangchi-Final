<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value="/resources/css/kjj.css"/>">
<style>
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
						<div class="w3-row w3-blue w3-padding chatlist">
							<h3>채팅방 목록</h3>
						</div>
						<div class="w3-row w3-light-grey chatRoomList">
							<ul class="w3-ul w3-margin chatRooms">
								<!-- 채팅방 목록 -->
								<%-- <li class="w3-bar w3-border w3-margin-bottom chatRoom">
									<input type="hidden" class="roomIdx" value=""> 
									<input type="hidden" class="opponent" value="">
									<span onclick="" class="w3-bar-item w3-right w3-badge w3-blue" >9</span>
									<img src="<c:url value="/resources/img/redheart.png"/>" class="w3-bar-item w3-circle w3-hide-small" style="height: 70px;">
									<div class="w3-bar-item">
										<span class="w3-large">Mike</span><br> 
										<span>Web Designerasdfasd</span>
									</div>
								</li> --%>
							</ul>
						</div>
					</div>
					<div class="w3-container w3-twothird chatArea">
						<div class="w3-row w3-blue w3-padding receiver">
							<h3>메세지를 선택해주세요</h3>
						</div>
						<div class="w3-row w3-light-grey w3-padding msgArea">
							<!-- 메세지 목록 -->
						</div>

						<div class="w3-row w3-padding inputArea">
							<div class="w3-col" style="width: 85%">
								<input class="w3-input w3-border w3-round-small" type="text" id="message">
							</div>
							<div class="w3-rest">
								<button type="button" class="w3-button w3-blue w3-center" id="sendBtn">
									전송 <i class="fa fa-plane"></i>
								</button>
								<input type="text" id="currChatRoom" value=""> 
								<input type="text" id="currChatUser" value="">
								<input type="text" id="chatRoom-reqIdx" value="">
								<input type="button" id="test" value="ㅎㅎ" onclick="updateBadge()">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="w3-col" style="width: 10%">
				<p></p>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

	<!-- moment() : 날짜 포멧팅 -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.27.0/moment.min.js"></script>

	<!-- 채팅방 리스트, n번idx채팅방의 메세지 리스트-->
	<!-- interval로 안읽은 메세지 있을때 갱신-->
	<script>
		//후순위  function
		$(document).ready(function() {
			
			setInterval(function(){
				chkNewMsg(chatList);
			},2000);

			
			
			//메세지 전송 
			function sendMsg() {
				$.ajax({
					url : 'http://localhost:8080/mc-chat/chat',
					type : 'post',
					data : {
						roomIdx : currRoom,
						sender : loginUser,
						receiver : currUser,
						text : $('#message').val(),
						reqIdx : chatRoomReqIdx
					},
					success : function(data) {
						currRoom = data;
						getMsgIdx(currRoom);
						chkNewMsg(chatList);
					}
				});
			}
			
			//메세지가 없을때 전송버튼 비활성화
			$('#message').keyup(function(e) {
				if (currRoom == -2 || $('#message').val().length == 0) {
					$('#sendBtn').attr('disabled', true);
				} else if(currRoom > -2 && $('#message').val().length > 0){
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
					console.log('메세지전송');
					sendMsg();
				}
				$('#message').val('');
			});
		});
		
		//로그인사용자
		var loginUser = '${loginInfo.nick}';
		//현재 보고있는 채팅방(단순히 채팅페이지에 접속이면 -2)
		var currRoom=-2;
		//현재 보고있는 채팅방의 상대방
		var currUser;
		//클릭한 채팅방의 req Idx
		var chatRoomReqIdx;
		//셋인터벌
		var listTimer;
		
		//클릭이벤트 : 내가 클릭한 채팅방의 메세지 리스트 가져오기
		function getMsgIdx(idx) {
			//clearInterval(listTimer);
			//메세지 리스트함수
			getMsgList();
		}

		function getMsgList() {
			const ma = $('.msgArea');
			const rc = $('.receiver');
			$.ajax({
				url : 'http://localhost:8080/mc-chat/chat/' + currRoom,
				type : 'get',
				data : {
					uNick : loginUser
				},
				success : function(msgList) {
					var html2 = '';
					if (msgList[0].sender == loginUser) {
						html2 += '<h3>' + msgList[0].receiver
								+ '님과의 대화</h3>';
					} else {
						html2 += '<h3>' + msgList[0].sender
								+ '님과의 대화</h3>';
					}
					rc.html(html2);
					
					var html = '';
					for (var i = 0; i < msgList.length; i++) {
						html += '<div class="w3-row w3-margin">';
						if (msgList[i].sender != loginUser) {
							html += '<div class="w3-container w3-left msg'+msgList[i].idx+'">';
							html += '	<input type="hidden" class="messageIdx" value="'+msgList[i].idx+'">';
							html += '	<p class="sender">'+msgList[i].sender+' &#40; '+moment(msgList[i].date).format('MM월DD일, HH:mm')+' &#41;</p>';
							html += '	<p class="w3-blue w3-padding">'+msgList[i].text +'</p>';
							html += '</div>';
						} else {
							html += '<div class="w3-container w3-right msg'+msgList[i].idx+'">';
							html += '	<input type="hidden" class="messageIdx" value="'+msgList[i].idx+'">';
							html += '	<p class="login">&#40; '+moment(msgList[i].date).format('MM월DD일, HH:mm')+' &#41; '+msgList[i].sender+'</p>';
							html += '	<p class="w3-green w3-padding">'+msgList[i].text+'</p>';
							html += '</div>';
						}
						html += '</div>';
					}
					ma.html(html);
					//스크롤 제일 밑으로 (최신메세지에 포커스 맞추기위해)
					$('.msgArea').scrollTop($('.msgArea')[0].scrollHeight);
				}
			});
		}

		//현재 로그인한 사용자에게 새로운메세지가 있으면 메세지리스트 갱신
		function chkNewMsg(callback) {
			
			console.log('새로운메세지 체크중');
			var loginInfo = '${loginInfo.nick}';
			$.ajax({
				url : 'http://localhost:8080/mc-chat/chat/',
				type : 'get',
				data : {
					uNick : loginInfo
					//idx : currRoom
				},
				success : function(newMsgList) {
					callback(loginUser,newMsgList);
					
					for(var i=0;i<newMsgList.length;i++){
						if(newMsgList[i].roomIdx==currRoom)
							getMsgList();
					}
				}

			});
		}

		//채팅방 리스트 뽑긔
		function chatList(loginUser,newMsgList) {
			const cl = $('.chatRooms');
			$.ajax({
				url : 'http://localhost:8080/mc-chat/chat/chatRoom',
				type : 'get',
				data : {
					uNick : loginUser
				},
				success : function(list) {
					var html = '';
					for (var i = 0; i < list.length; i++) {
						//채팅방에는
						//로그인한 사용자와 채팅참여자1의 이름이 같을때
						if (loginUser == list[i].mbNick1) {
							html += '<li class="w3-bar w3-border w3-margin-bottom w3-white chatRoom chatRoom'+ list[i].idx +'">';
							html += '	<input type="hidden" class="roomIdx" value="'+ list[i].idx +'">';
							html += '	<input type="hidden" class="opponent" value="'+ list[i].mbNick2 +'">';
							html += '	<input type="hidden" class="reqIdx" value="'+ list[i].reqIdx +'">';
							html += '	<span class="w3-bar-item w3-right w3-badge w3-blue badge"></span>';
							html += '	<img src="<c:url value="/resources/img/redheart.png"/>" class="w3-bar-item w3-circle w3-hide-small" style="height: 70px;">';
							html += '	<div class="w3-bar-item">';
							html += '		<span class="w3-large">'+ list[i].mbNick2 +'</span><br> ';
							html += '		<span>' + list[i].reqTitle+ '</span>';
							html += '	</div>';
							html += '</li>';
						//로그인한 사용자와 채팅참여자2의 이름이 같을때
						} else {
							html += '<li class="w3-bar w3-border w3-margin-bottom w3-white chatRoom chatRoom'+ list[i].idx +'">';
							html += '	<input type="hidden" class="roomIdx" value="'+ list[i].idx +'">';
							html += '	<input type="hidden" class="opponent" value="'+ list[i].mbNick1 +'">';
							html += '	<input type="hidden" class="reqIdx" value="'+ list[i].reqIdx +'">';
							html += '	<span class="w3-bar-item w3-right w3-badge w3-blue badge"></span>';
							html += '	<img src="<c:url value="/resources/img/redheart.png"/>" class="w3-bar-item w3-circle w3-hide-small" style="height: 70px;">';
							html += '	<div class="w3-bar-item">';
							html += '		<span class="w3-large">'+ list[i].mbNick1 +'</span><br> ';
							html += '		<span>' + list[i].reqTitle+ '</span>';
							html += '	</div>';
							html += '</li>';
						}
					}
					cl.html(html);
					//채팅방 클릭이벤트
					$('.chatRoom').click(function() {
						$(this).children('.badge').css('visibility','hidden');
						$('#currChatRoom').val($(this).children('.roomIdx').val());
						$('#currChatUser').val($(this).children('.opponent').val());
						$('#chatRoom-reqIdx').val($(this).children('.reqIdx').val());
						currRoom = $('#currChatRoom').val();
						currUser = $('#currChatUser').val();
						chatRoomReqIdx = $('#chatRoom-reqIdx').val();
						getMsgIdx(currRoom);
					});
					for(var i=0;i<newMsgList.length;i++){
						$('.chatRoom'+newMsgList[i].roomIdx).find('.badge').text(newMsgList[i].newMsgCount);
					}
					$('.badge').each(function(i,x){
						if($(x).text()>0){
							console.log('보여줄게');
							$(x).css('visibility','visible');
						}else{
							console.log('지워줄게');
							$(x).css('visibility','hidden');
						}
					});
				}
			});
		}
		
		//가장 먼저 실행할 function
		function init(){
			chkNewMsg(chatList);
			
			if(${msgInfo != null}){
				//게시글 작성자에게 처음 메세지를 보낼때
				currRoom = -1;
				currUser ='${msgInfo.uNick}';
				chatRoomReqIdx='${msgInfo.reqIdx}';
				$('.receiver').html('<h3>'+currUser+'님과의 대화</h3>');
				
			}else{
				chatRoomReqIdx=-1;
			}
			$('#sendBtn').attr('disabled', true);
			$('#currChatRoom').val(currRoom);
			$('#currChatUser').val(currUser);
			$('#chatRoom-reqIdx').val(chatRoomReqIdx);			
		}
		
		init();
	</script>
	<script>
		
	</script>
	<%-- <script src="<c:url value="/resources/js/kjj.js"/>"></script> --%>
</body>
</html>