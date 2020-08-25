//채팅방 리스트 출력
function makeChatRoomList(chkNewMsg){
	console.log('리스트출력');
	$.ajax({
		url : localhost+'/mc-chat/chat/chatRoom',
		type : 'get',
		data : {
			uNick : loginUser
		},
		success : function(list) {
            var html='';
            for(var i=0;i<list.length;i++){
                if(loginUser!=list[i].delUser){
                    html+='<li class="w3-row chat-room" style="border:0" id="chat-room'+list[i].idx+'" qi="'+list[i].reqIdx+'" >';
                    html+='    <div class="w3-col m10 l0 w3-padding-small title-chatRoom">';
                    if(list[i].mbNick1!=loginUser){
                    html+='        <b class="chat-nick">'+list[i].mbNick1+'</b><br>';
                    }else{
                    html+='        <b class="chat-nick">'+list[i].mbNick2+'</b><br>';
                    }
                    html+='        <span class="chat-title">제목 : '+list[i].reqTitle+'</span>';
                    html+='    </div>';
                    html+='</li>';
                }
            }
            $('#chat-room-list').html(html);
            evClickChatRoom();
            chkNewMsg();
        }
    });
}

function evClickChatRoom(){
    var roomReqIdx;
    var memberNick;
    $('.chat-room').on('click',function(){
        $('#req-writer').text('');
        $('#req-loc').text('');
         roomReqIdx = $(this).attr('qi');
         memberNick = $(this).find('.chat-nick').text();
         roomReqTitle = $(this).find('.chat-title').text();
         insertTopBarImg(memberNick);
         if(roomReqIdx!=0){
             insertTopBarReq(roomReqIdx);
        }
         $('#chat-user-nick').text(memberNick);
         $('#req-title').text(roomReqTitle);
    });
}

function insertTopBarReq(idx){
    $.ajax({
        url: localhost+'/mc-chat/chat/req',
        type: 'get',
        data:{reqIdx:idx},
        success: function(data){
            $('#req-writer').text('요청글 작성자 : '+data.reqNick);
            $('#req-loc').text('요청지역 : '+data.reqLoc);
        }
    });
}

function insertTopBarImg(nick){
    $.ajax({
        url: localhost+'/mc-chat/chat/img',
        type: 'get',
        data:{nick:nick},
        success: function(data){
            if(!data.includes('http',0)){
                data = uploadPath+data;
            }
            $('#chatuser').attr('src',data);
        }
    });
}

//새로운 메세지 확인
function chkNewMsg() {
	$.ajax({
		url : localhost+'/mc-chat/chat',
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
					html+='<span class="w3-col m1 l1 w3-badge w3-red" id="badge">'+newMsgList[i].newMsgCount+'</span>';
					$('#chat-room'+newMsgList[i].roomIdx).append(html);
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
makeChatRoomList(chkNewMsg);