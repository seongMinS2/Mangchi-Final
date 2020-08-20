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
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-blue-grey.css">
<div id="donateWrap">
	<h3>나눔 게시판</h3>
	<c:if test="${loginInfo!=null}">
		<input type="hidden" id="loginUser" value="${loginInfo.mNick}">
	</c:if>

	<div id="contentsBox">
		<div id="listBox"></div>
		<div id="categoryBox" style="paddind:10px;">
			<button class="w3-button w3-block w3-theme-l5" id="writeForm" onclick="location.href='<c:url value="/donateForm"/>'">글쓰기</button>
			<form>
				<input type="text" id="searchKey" name="searchKey" placeholder="닉네임 혹은 제목을 검색하세요" style="width: 60%;"> 
				<input type="button" id="searchBar" class="w3-button w3-theme-l3" style="width: 30%;" value="검색">
				<input type="button" class="w3-button w3-block w3-theme-l2" id="subscribe" value="나눔게시판 구독하기" onclick="subscribeDonate()">
				<input type="button" class="w3-button w3-block w3-theme-l1" id="notification" value="키워드 알람 설정"
				onclick="noticeForm()">
			</form>

		</div>
	</div>
	<div id="pageBox"></div>


</div>
<div id="moreView" class="w3-theme-l5" style="width:100%; height: 50px; text-align:center;"></div>

<div id="id01" class="w3-modal"></div>
<div id="donateEdit" class="w3-modal"></div>
<div id="keywordNot" class="w3-modal"></div>

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

messaging.onMessage(function(payload){
    console.log('onMessage: ', payload);
    const title = "동네에서 대여하기 :: MANGCHI!";
    const options = {
            body: payload.notification.body,
            icon: payload.notification.icon
    };
    var notification = new Notification(title, options);
    return self.registration.showNotification(notification);
});



function deleteKeyword(idx) {
	$.ajax({
		url : 'http://localhost:8080/subscribe/fcmKey/'+idx,
		type : 'delete',
		success : function(data){
			noticeList($('#loginUser').val());	
		}
	});
}


function noticeList(user){
	
	$.ajax({
		url : 'http://localhost:8080/subscribe/fcmKey/'+user,
		type : 'get',
		success : function(data){
			console.log(data);
			var keyList='';
			keyList+='<table>';

			for(var i=0; i<data.length; i++) {
				keyList+='	<tr>';
				keyList+='		<td>'+data[i].keyword+'</td>';
				keyList+='		<td><button type="button" onclick="deleteKeyword('+data[i].noticeIdx+')">x</button></td>';
				keyList+='	</tr>';
			}
			keyList+='	</tr>';
			keyList+='</table>';
			$('#noticList').html(keyList);
		}
		
	});
	
}


function notificationConfig(){
	
	messaging.requestPermission()
	.then(function() {
		console.log('알림 허가');
		return messaging.getToken(); //토큰을 받는 함수를 추가
		
	})
	.then(function(token) {
		console.log(token); //토큰을 출력
		$.ajax({
			url : 'http://localhost:8080/subscribe/fcmKey/'+token,
			type : 'post',
			data : {
				memberNick : $('#loginUser').val(),
				keyword : $('#notificKeyword').val(),
				token : token
			},
			success : function(data){
				alert($('#notificKeyword').val()+'를 키워드 등록하였습니다.');
				noticeList($('#loginUser').val());
			}
			
		});
		 
	})
	.catch(function(err) {
		console.log('fcm에러 : ', err);
	})
	
}


function noticeForm(){
	var loginUser=$('#loginUser').val();
	if(loginUser==null) {
		alert('키워드 알람 서비스는 로그인 한 사용자만 이용 가능합니다.');
		history.go(0);
	} else {
			
		$('#keywordNot').css('display','block');
		var notice='';
		notice+='<div class="w3-modal-content" style="width:400px;">';
		notice+='	<header class="w3-container">';
		notice+='		<h4>푸시알림을 받을 키워드를 입력하세요. </h4>';
		notice+='        <span onclick="$(\'#keywordNot\').css(\'display\',\'none\')"';
		notice+='        class="w3-button w3-display-topright">&times;</span>';	
		notice+='	</header>';
		notice+='	<div class="w3-container">';
		notice+='		<form id="noticeConfig" onsubmit="return false">';
		notice+='			<input type="text" name="noticeKeyword" id="notificKeyword">';
		notice+='			<input type="submit" id="notificSubmit" value="키워드 구독" onclick="notificationConfig()">';
		notice+='		</form>';
		notice+='		<div id="noticList"></div>';
		notice+='		<hr>';
		notice+='	</div>';
		notice+='</div>';
		$('#keywordNot').html(notice);
		noticeList(loginUser);
		
	}
}

function subscribeDonate() {
	var loginUser=$('#loginUser').val();
	if(loginUser==null) {
		alert('구독은 로그인 한 사용자만 가능합니다.');
		history.go(0);
	} else {
		messaging.requestPermission()
		.then(function() {
			console.log('구독 알림 허가');
			return messaging.getToken(); //토큰을 받는 함수를 추가
			
		})
		.then(function(token) {
			console.log(token); //토큰을 출력
			$.ajax({
				url : 'http://localhost:8080/subscribe/sub/'+token,
				type : 'post',
				data : {
					memberNick : $('#loginUser').val(),
					token : token
				},
				success : function(data){
					alert('나눔게시판 구독 알림이 시작됩니다.');
				}
			});
			
		})
		.catch(function(err) {
			console.log('fcm에러 : ', err);
		})
	}
}

</script>

</body>
</html>
