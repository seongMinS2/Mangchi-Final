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
<script src="http://code.jquery.com/jquery-1.12.4.js"></script>
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
						<div class="w3-row w3-light-grey chatRooms">
						<!-- 채팅방 목록 -->
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
								<input class="w3-input w3-border w3-round-small" type="text"
									id="message">
							</div>
							<div class="w3-rest">
								<button type="button" class="w3-button w3-blue w3-center"
									id="sendBtn">
									전송 <i class="fa fa-plane"></i>
								</button>
								<input type="hidden" id="currChatRoom" value=""> 
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.27.0/moment.min.js"></script>
<!-- 채팅방 리스트, n번idx채팅방의 메세지 리스트 -->
<script>
	$(document).ready(function() {
		var loginUser = '${loginInfo.nick}';
		chatList(loginUser);
	});
	
	function chatList(loginUser) {
		const cl = $('.chatRooms');
		
		$.ajax({
			url : 'http://localhost:8080/mc-chat/chatRoom',
			type : 'get',
			data : {
				uNick : loginUser
			},
			success : function(list) {
				var html = '';
				for (var i = 0; i < list.length; i++) {
					html += '<div class="w3-blue w3-margin chatRoom" onclick="getMsgIdx('+ list[i].idx + ')">';
					html += '	<ul>';
					html += '		<li>게시글 : ' + list[i].reqTitle + '</li>';
					if(loginUser==list[i].mbNick1){
						html += '		<li> 상대방 : ' + list[i].mbNick2 + '</li>';
					}else{
						html += '		<li> 상대방 : ' + list[i].mbNick1 + '</li>';
					}
					html += '		<li>시간</li>';
					html += '	</ul>';
					html += '</div>';
				}
				cl.html(html);
				
			}
		});
	}
	var currVal;
	function getMsgIdx(idx){
		$('#currChatRoom').val(idx);
		currVal=$('#currChatRoom').val();
		getMsgList();
		listTimer();
	}
	
	//메세지 리스트 가져오기
	function getMsgList() {
		const ma=$('.msgArea');
		const rc=$('.receiver');
		var loginInfo='${loginInfo.nick}';
		$.ajax({
			url:'http://localhost:8080/mc-chat/chat/'+currVal,
			type:'get',
			data: {
				uNick:loginInfo
			},
			success : function(msgList){
				var html2='';
				if(msgList[0].sender==loginInfo){
					html2+='<h3>'+msgList[0].receiver+'님과의 대화</h3>';
				}else{
					html2+='<h3>'+msgList[0].sender+'님과의 대화</h3>';
				}
				rc.html(html2);
				var html = '';
				for (var i = 0; i < msgList.length; i++) {
					html+='<div class="w3-row w3-margin">';
					if(msgList[i].sender!=loginInfo){
						html+='	<div class="w3-container w3-left msg'+msgList[i].idx+'">';
						html+='		<p class="sender">'+msgList[i].sender+' &#40; '+moment(msgList[i].date).format('MM월DD일, HH:mm')+' &#41;</p>';
						html+='		<p class="w3-blue w3-padding">'+msgList[i].text+'</p>';
						html+=' </div>';
					}else{
						html+='	<div class="w3-container w3-right">';
						html+='		<p class="login">&#40; '+moment(msgList[i].date).format('MM월DD일, HH:mm')+' &#41; '+msgList[i].sender+'</p>';
						html+='		<p class="w3-green w3-padding">'+msgList[i].text+'</p>';
						html+=' </div>';
					}
					html+='</div>';
				}
				ma.html(html);
				$('.msgArea').scrollTop($('.msgArea')[0].scrollHeight);
			}
		});
	}
	
	function listTimer(){
		setInterval(function(){
			var loginInfo='${loginInfo.nick}';
			$.ajax({
				url:'http://localhost:8080/mc-chat/chat/',
				type:'get',
				data:{
					uNick:loginInfo,
					idx:currVal
				},
				success:function(data){
					if(data>0){
						getMsgList();
					}
				}
				
			});
		}, 3000);
	}
	
</script>
<script>
	
</script>
	<%-- <script src="<c:url value="/resources/js/kjj.js"/>"></script> --%>
</body>
</html>