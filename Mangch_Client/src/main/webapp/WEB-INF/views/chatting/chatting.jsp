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
					<div class="w3-container w3-third">
						<div class="w3-row-padding chatRooms">
							<div class="w3-blue msg w3-margin w3-padding">
								<p>유저1</p>
							</div>
						</div>
					</div>
					<div class="w3-container w3-twothird chatArea">
						<div class="w3-row w3-blue w3-padding receiver">
							<h3>상대방 닉네임</h3>
						</div>
						<div class="w3-row w3-light-grey w3-padding msgArea">
							<div class="w3-row">
								<div class="w3-blue msg w3-margin w3-padding">
									<p>ㅎㅇ</p>
								</div>
							</div>
							<div class="w3-row">
								<div class="w3-green msg w3-margin w3-padding">
									<p>ㅎㅇ</p>
								</div>
							</div>
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

	<script type="text/javascript">
		/* $("#sendBtn").click(function() {
			sendMessage();
			$('#message').val('');
			$('#message').focus();
		});
		let sock = new SockJS("http://localhost:8080/mc-chat/echo/");
		sock.onmessage
		console.log(sock);
		sock.onmessage = onMessage;
		sock.onclose = onClose;
		// 메시지 전송
		function sendMessage() {
			sock.send('${loginInfo.nick}&12&유저1')
			//sock.send('${loginInfo.nick},' + $("#message").val());
		}
		// 서버로부터 메시지를 받았을 때
		function onMessage(msg) {
			var data = msg.data;
			console.log(data);
			//$("#messageArea").append(data + "<br/>");
		}
		// 서버와 연결을 끊었을 때
		function onClose(evt) {
			//$("#messageArea").append("연결 끊김");

		} */
	</script>
	<%-- <script src="<c:url value="/resources/js/kjj.js"/>"></script> --%>
</body>
</html>