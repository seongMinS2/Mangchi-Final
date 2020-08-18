<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>나눔 게시판</title>
</head>
<jsp:include page="/WEB-INF/views/include/header.jsp" />

<script type="text/javascript"
	src='<c:url value="/resources/js/hong.js"/>'></script>
<link rel="stylesheet" href="<c:url value="/resources/css/hong.css"/>">

<div id="donateWrap">
	<h3>나눔 게시판</h3>
	<c:if test="${loginInfo!=null}">
		<input type="hidden" id="loginUser" value="${loginInfo.mNick}">
	</c:if>

	<div id="contentsBox">
		<div id="listBox"></div>
		<div id="categoryBox">
			<button class="w3-button w3-block w3-black" style="width: 100%"
				id="writeForm"
				onclick="location.href='<c:url value="/donateForm"/>'">글쓰기</button>

			<form>
				<input type="text" id="searchKey" name="searchKey"
					placeholder="닉네임 혹은 제목을 검색하세요" style="width: 60%;"> <input
					type="button" id="searchBar" style="width: 30%;" value="검색">
			</form>

		</div>
	</div>
	<div id="pageBox"></div>


</div>

<div id="id01" class="w3-modal"></div>
<div id="donateEdit" class="w3-modal"></div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script src="https://www.gstatic.com/firebasejs/6.6.0/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/5.10.1/firebase-messaging.js"></script>
<script>
//키등록
var config = {
    apiKey: "AIzaSyDDYOCHCJe-_sOTVkVo-Hi63oRTE1dVlgs",
    authDomain: "donataboard-mangchi-project.firebaseapp.com",
    databaseURL: "https://donataboard-mangchi-project.firebaseio.com",
    projectId: "donataboard-mangchi-project",
    storageBucket: "donataboard-mangchi-project.appspot.com",
    messagingSenderId: "178872893699",
    appId: "1:178872893699:web:94f9afe628778e2ad1a936",
    measurementId: "G-N8HPT4GQ8G"
};
//firebase 초기화
firebase.initializeApp(config);

//메시지 메서드 생성
const messaging = firebase.messaging();

//웹 푸쉬 인증키 등록
messaging.usePublicVapidKey('BPSYuV8DZh_GVPCu74wa9ve8HhPcA-MFBJ7sWJSIcufcqXGyDLuakZSQhCylTuIdcZBft0LDf0ESX1Mfxsxb5hU');

//알람 허용 요청시 토큰 검색
Notification.requestPermission().then((permission) => {
	if (permission === 'granted') {
		console.log('Notification permission granted.');
		messaging.getToken().then((currentToken) => {
			if (currentToken) {
				console.log(currentToken);
				sendTokenToServer(currentToken);
			    updateUIForPushEnabled(currentToken);
			  } else {
			    // Show permission request.
			    console.log('No Instance ID token available. Request permission to generate one.');
			    // Show permission UI.
			    updateUIForPushPermissionRequired();
			    setTokenSentToServer(false);
			  }
			
		}).catch((err) => {
			console.log('An error occurred while retrieving token. ', err);
			showToken('Error retrieving Instance ID token. ', err);
			setTokenSentToServer(false);
		});

	} else {
		console.log('Unable to get permission to notify.');
	}
});


</script>

</body>
</html>
