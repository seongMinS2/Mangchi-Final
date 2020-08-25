var code = {
    connection:'connection',
    message : 'message',
    delRoom : 'delete'
};

var sock = new SockJS(localhost+'/chatting');

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
			url:url
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

}
function onClose(evt) {
	//$("#data").append("연결 끊김");
}