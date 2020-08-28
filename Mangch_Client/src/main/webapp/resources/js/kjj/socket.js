var code = {
    connection:'connection',
    message : 'message',
    deleteRoom : 'delete'
};

var sock = new SockJS(path+'/mc-chat/chatting');

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
	//console.log(moment(new Date()).format('YYYY년 MM월 DD일'));
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
	var msg = JSON.parse(evt.data);
	var $scHeight = $('.msg-area').prop('scrollHeight');

	var $updateLi = $('#chat-room'+msg.roomIdx);
	var $lastDate = $('.msg-area').find('.dateCon').last();
	if(msg.code=='message'){
		var html='';
		if(roomIdx==msg.roomIdx){
			readMsg(msg.roomIdx);

			if($lastDate.text()!=moment(msg.date).format('MM월 DD일')){
				html +='<div class="w3-cell-row w3-container w3-center last-msg-date">';
				html +='	<p class="w3-round-xxlarge w3-theme-l5 dateCon">'+moment(msg.date).format('MM월 DD일')+'</p>';
				html +='</div>';
			}
			if(msg.sender==loginUser){
				html+='<div class="w3-row w3-padding">';
				if(!$lastDate.length||$lastDate.text()!=moment(msg.date).format('MM월 DD일')||$('.msg-sender').last().text()!=msg.sender){
				html+='    <div class="w3-cell-row w3-right-align">';
				html+='        <b class="msg-sender">'+msg.sender+'</b>';
				html+='    </div>';
				}
				html+='    <div class="w3-cell-row">';
				html+='        <div class="w3-cell w3-padding w3-right w3-theme4-l3" id="right-msg">';
				if(msg.img!=null&&msg.img.length>0){
				html+='		       <span class="w3-right">';
				html+='                 <img src="'+path+'/mc-chat/resources/image/room'+msg.roomIdx+'/'+msg.img+'" id="msgimgtag" class="msgimgtag">';
				html+='            </span>';
				}else{
				html+='		       <span class="w3-right">';
				html+=                  msg.text;
				html+='            </span>';
				}
				html+='        </div>';
				html+='        <div class="w3-right w3-right-align">';
				html+=          moment(msg.date).format('a HH:MM');
				html+='        </div>';
				html+='    </div>';
				html+='</div>';
				$('.msg-area').append(html);
				$('.msg-area').scrollTop($('.msg-area')[0].scrollHeight);
			}else{
				html+='<div class="w3-row w3-padding">';
				if(!$lastDate.length||$lastDate.text()!=moment(msg.date).format('MM월 DD일')||$('.msg-sender').last().text()!=msg.sender){
				html+='    <div class="w3-cell-row">';
				html+='        <b class="msg-sender">'+msg.sender+'</b>';
				html+='    </div>';
				}
				html+='    <div class="w3-cell-row">';
				html+='        <div class="w3-cell  w3-left w3-padding w3-light-grey" id="left-msg">';
				if(msg.img!=null&&msg.img.length>0){
				html+='		       <span>';
				html+='                 <img src="'+path+'/mc-chat/resources/image/room'+msg.roomIdx+'/'+msg.img+'" id="msgimgtag" class="msgimgtag">';
				html+='            </span>';
				}else{
				html+='		       <span>';
				html+=                  msg.text;
				html+='            </span>';
				}
				html+='        </div>';
				html+='        <div class="w3-left w3-left-align">';
				html+=          moment(msg.date).format('a HH:MM');
				html+='        </div>';
				html+='    </div>';
				html+='</div>';
				$('.msg-area').append(html);
				//스크롤이 맨밑에 있을때만 새로운 메세지에 포커스 
				var scLoc= $('.msg-area').scrollTop()+parseInt($('.msg-area').height());
				if(scLoc==$scHeight){
					$('.msg-area').scrollTop($('.msg-area')[0].scrollHeight);
				}
			}
			// if($('.msg-area').prop('scrollHeight')==$scHeight) {
			// 	$('.msg-area').scrollTop(2000);
			// }
		}else{
			//채팅방의 뱃지 업데이트
			if($updateLi.children('#badge').length){
				var $badge = $updateLi.children('#badge');
				$badge.text(Number($badge.text())+1);

			//뱃지가 없으면 달아주기
			}else{
				var html='';
				html+='<span class="w3-col m1 l1 w3-badge w3-red" id="badge">1</span>';
				$updateLi.append(html);
			}
		}
		$updateLi.prependTo('#chat-room-list');

	//상대방이 채팅을 삭제하면 삭제했다는 메세지를 받음
	}else if(msg.code=='delete'){
		$updateLi.append('<input type="hidden" id="delUser" value="'+msg.sender+'">');
		$updateLi.find('.chat-title').addClass('w3-red');
		$updateLi.find('.chat-title').text('상대방이 채팅방을 떠났습니다');
		if(roomIdx==msg.roomIdx){
			delUser=msg.sender;
			var html2 ="<div class='w3-cell-row w3-container w3-center'>";
			html2 +="	<p class='w3-round-xxlarge w3-red'>상대방이 채팅을 종료했습니다.<br> 메세지를 보낼 수 없습니다</p>";
			html2 +="	<button class='w3-button w3-large w3-round-large w3-red confirm-room-del'>삭제</button>";
			html2 +="</div>";
			$('.msg-area').append(html2);
			$('.confirm-room-del').on('click',function(){
				$('#ask-delroom-modal').show();
			});
			$('.msg-area').scrollTop($('.msg-area')[0].scrollHeight);
		}
		$updateLi.prependTo('#chat-room-list');
	}
	$('.msgimgtag').on('click',function(){
		console.log($(this).attr('src'));
		$('.clickImg').attr('src',$(this).attr('src'));
		$('.img-zoom-modal').show();
	});

}
function onClose(evt) {
	//$("#data").append("연결 끊김");
}