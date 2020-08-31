//메세지 선택하지 않았을때 상단바에
var notChoiceMsg ='<div class="w3-padding w3-xlarge">메세지를 선택해주세요</div>';

//채팅방 리스트 출력
function makeChatRoomList(chkNewMsg){
	console.log('리스트출력');
	$.ajax({
		url : path+'/mc-chat/chat/chatRoom',
		type : 'get',
		data : {
			uNick : loginUser
		},
		success : function(list) {
            var html='';
            for(var i=0;i<list.length;i++){
                if(loginUser!=list[i].delUser){
                    html+='<li class="w3-row chat-room" style="border:0" id="chat-room'+list[i].idx+'" i="'+list[i].idx+'" qi="'+list[i].reqIdx+'" >';
                    html+='    <div class="w3-col m10 l0 w3-padding-small title-chatRoom">';
                    if(list[i].mbNick1!=loginUser){
                    html+='        <b class="chat-nick">'+list[i].mbNick1+'</b><br>';
                    }else{
                    html+='        <b class="chat-nick">'+list[i].mbNick2+'</b><br>';
                    }
                    if(list[i].delUser!=null){
                    html+='        <input type="hidden" id="delUser" value="'+list[i].delUser+'">';
                    html+='        <span class="chat-title w3-red"> 상대방이 채팅방을 떠났습니다 </span>';
                    }else{
                    html+='        <span class="chat-title">제목 : '+list[i].reqTitle+'</span>';
                    }
                    html+='    </div>';
                    html+='</li>';
                }
            }
            $('#chat-room-list').html(html);
            $('.chat-room').on('click',evClickChatRoom);
            chkNewMsg();
        }
    });
}
//채팅방 삭제
function removeRoom(idx){
	$.ajax({
		url : path+'/mc-chat/chat/chatRoom',
		type : 'post',
		data : {
			delUser:delUser,
			loginUser:loginUser,
			roomIdx:idx
		},
		success : function(data) {
            //내가먼저 채팅방을 나갔을때 상대방에게 보냄
            if(data==0){
                var msgData = {
                        code : code.deleteRoom,
                        idx : null,
                        roomIdx : idx,
                        sender : loginUser, // 현재 페이지 작성자의 id를 작성
                        receiver : roomUser,
                        text : null,
                        img : null
                };
                sendMsgToSocket(msgData);
                //makeChatRoomList(chkNewMsg);
            }
            $('li[id=chat-room'+idx+']').remove();
            leaveChatRoom();
		}
		
	});
}
//대화방 나가기
function leaveChatRoom(){
    $('.msg-area').empty();
    $('.top-bar-title').html(notChoiceMsg);
    $('#chatuserImg').empty();
    $('#req-writer').empty();
    $('#req-loc').empty();
    $('#req-title').empty();
    $('.dropdown-content').hide();
    $('li').removeClass('w3-theme');
    delUser=null;
    roomReqIdx=null;
    roomUser=null;
    roomIdx=-2;
    roomReqTitle=null;
    $('.bi-three-dots-vertical').off();
}
//메세지 전송 
function sendMsg() {
	var regFormData = new FormData();
	regFormData.append('roomIdx',roomIdx);
	regFormData.append('sender',loginUser);
	regFormData.append('receiver',roomUser);
	if($('#msg-text').val().length>0){
		regFormData.append('text',$('#msg-text').val());
	}else{
		regFormData.append('text',null);
	}
	regFormData.append('reqIdx',roomReqIdx);
	if($('#msgPhoto')[0].files[0]!=null){
		regFormData.append('msgPhoto',$('#msgPhoto')[0].files[0]); //file
    }
	$.ajax({
		url : path+'/mc-chat/chat',
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
		}
	});
}

//채팅방 클릭시 이벤트
var delUser=null;
var roomReqIdx=null;
var roomUser=null;
var roomIdx=-2;
var roomReqTitle=null;

function evClickChatRoom(){
    //같은방을 눌럿을땐 이벤트가 동작하지 않음
    console.log("$(this).attr('i')==roomIdx : "+$(this).attr('i')==roomIdx)
    if($(this).attr('i')!=roomIdx){
        console.log('클릭');
        
        $('li').removeClass('w3-theme');
        $(this).addClass('w3-theme');
        $('.dropdown-content').hide();
        delUser=null;
        roomReqIdx=null;
        roomUser=null;
        roomIdx=-2;
        roomReqTitle=null;
        
        $('#req-writer').text('');
        $('#req-loc').text('');
        $('#req-title').text('');
        
        roomIdx=$(this).attr('i');
        roomReqIdx = $(this).attr('qi');
        roomUser = $(this).find('.chat-nick').text();
        roomReqTitle = $(this).find('.chat-title').text();
        
        if($(this).find('#delUser').val() !=null){
            delUser=$(this).find('#delUser').val();
        }
        readMsg(roomIdx);
        insertTopBarImg(roomUser);
        insertTopBarReq(roomReqIdx);
        insertTopBarTitle(roomUser);
        $('.msg-area').html('');
        page=0;
        insertMsgList(roomIdx,delUser);
        $('#req-title').text(roomReqTitle);
        $(this).find('#badge').remove();
        $('.bi-three-dots-vertical').off();
        //3점클릭
        $('.bi-three-dots-vertical').on('click',function(){
            $(this).parent().next().slideToggle('fast');
        });
        $('.out-room').on('click',function(){
            leaveChatRoom();
        });
        $('.confirm-room-del').on('click',function(){
            $('#ask-delroom-modal').show();
        });
        $('.delRoomYes').on('click',function(){
            $('#ask-delroom-modal').hide();
            removeRoom(roomIdx);
        });
        $('.delRoomNo').on('click',function(){
            $('#ask-delroom-modal').hide();
        });
        $('#msg-text').focus();
    }
}
    
function insertTopBarTitle(nick){
    var html='<b id="chat-user-nick" style="font-size: 1.3em; font-weight: bold;">'+nick+'</b>&nbsp;&nbsp;님과의 대화';
    $('.top-bar-title').html(html);
}

//메세지 읽음 처리
function readMsg(roomIdx){
    $.ajax({
        url : path+'/mc-chat/chat/msg/' + roomIdx,
		type : 'get',
		data : {
			uNick : loginUser
        },
        success:function(data){
        }
    });
}
//스크롤 페이징 처리
var page = 0;
//메세지 리스트 출력
function insertMsgList(roomIdx,delUser){
    console.log(roomIdx);
    var scHeight='';
    var html='';
    scHeight=$('.msg-area').prop('scrollHeight');
    $.ajax({
		url : path+'/mc-chat/chat/' + roomIdx,
		type : 'get',
		data : {
            uNick : loginUser,
            page : page
		},
		success : function(msgList) {
			console.log(msgList.length);
            if(msgList.length==0){
                $('.msg-area').off();
            }else{
                for(var i=msgList.length-1;i>=0;i--){
                    if(i==0){
                        if(msgList[i].sender == $('.msg-area').find('.msg-sender').first().text()){
                            $('.msg-area').find('.msg-sender').first().text('');
                        }
                        if(moment(msgList[i].date).format('MM월 DD일')==$('.msg-area').find('.dateCon').first().text()){
                            $('.msg-area').find('.last-msg-date').first().remove();
                        }
                    }
                    if(i===msgList.length-1||(i<msgList.length-1&&moment(msgList[i].date).format('YYYYMMDD')!=moment(msgList[i+1].date).format('YYYYMMDD'))){
                        html +='<div class="w3-cell-row w3-container w3-center last-msg-date">';
                        html +='	<p class="w3-round-xxlarge w3-theme-l5 dateCon">'+moment(msgList[i].date).format('MM월 DD일')+'</p>';
                        html +='</div>';
                    }
                    if(loginUser!=msgList[i].sender){
                        html+='<div class="w3-row w3-padding msg-box" i="'+msgList[i].idx+'">';
                        if(i===msgList.length-1){
                        html+='    <div class="w3-cell-row">';
                        html+='        <b class="msg-sender">'+msgList[i].sender+'</b>';
                        html+='    </div>';
                        }else if((i<msgList.length-1&&msgList[i].sender!=msgList[i+1].sender)||(i<msgList.length-1&&moment(msgList[i].date).format('YYYYMMDD')!=moment(msgList[i+1].date).format('YYYYMMDD'))){
                        html+='    <div class="w3-cell-row">';
                        html+='        <b class="msg-sender">'+msgList[i].sender+'</b>';
                        html+='    </div>';
                        }
                        html+='    <div class="w3-cell-row">';
                        html+='        <div class="w3-cell w3-left w3-padding w3-light-grey message" id="left-msg">';
                        if(msgList[i].img!=null&&msgList[i].img.length>0){
                        html+='		       <span>';
                        html+='                 <img src="'+path+'/mc-chat/resources/image/room'+msgList[i].roomIdx+'/'+msgList[i].img+'" id="msgimgtag" class="msgimgtag">';
                        html+='            </span>';
                        }else{
                        html+='		       <span>';
                        html+=                  msgList[i].text;
                        html+='            </span>';
                        }
                        html+='        </div>';
                        html+='        <div class="w3-left w3-left-align msg-date">';
                        html+=          moment(msgList[i].date).format('a HH:MM');
                        html+='        </div>';
                        html+='    </div>';
                        html+='</div>';
                    }else{
                        html+='<div class="w3-row w3-padding msg-box" i="'+msgList[i].idx+'">';
                        if(i===msgList.length-1){
                        html+='    <div class="w3-cell-row w3-right-align">';
                        html+='        <b class="msg-sender">'+msgList[i].sender+'</b>';
                        html+='    </div>';
                        }else if((i<msgList.length-1&&msgList[i].sender!=msgList[i+1].sender)||(i<msgList.length-1&&moment(msgList[i].date).format('YYYYMMDD')!=moment(msgList[i+1].date).format('YYYYMMDD'))){
                        html+='    <div class="w3-cell-row w3-right-align">';
                        html+='        <b class="msg-sender">'+msgList[i].sender+'</b>';
                        html+='    </div>';
                        }
                        html+='    <div class="w3-cell-row">';
                        html+='        <div class="w3-cell w3-right w3-padding w3-theme4-l3 message" id="right-msg">';
                        if(msgList[i].img!=null&&msgList[i].img.length>0){
                        html+='		       <span class="w3-right">';
                        html+='                 <img src="'+path+'/mc-chat/resources/image/room'+msgList[i].roomIdx+'/'+msgList[i].img+'" id="msgimgtag" class="msgimgtag">';
                        html+='            </span>';
                        }else{
                        html+='		       <span class="w3-right">';
                        html+=                  msgList[i].text;
                        html+='            </span>';
                        }
                        html+='        </div>';
                        html+='        <div class="w3-right w3-right-align msg-date">';
                        html+=          moment(msgList[i].date).format('a HH:MM');
                        html+='        </div>';
                        html+='    </div>';
                        html+='</div>';
                    }
                }
                $('.msg-area').prepend(html);


                //상대가 나간 채팅방이라면 채팅종료 문구 띄우기
                if(delUser!=null){
                    var html2 ="<div class='w3-cell-row w3-container w3-center'>";
                    html2 +="	<p class='w3-round-xxlarge w3-red'>상대방이 채팅을 종료했습니다.<br> 메세지를 보낼 수 없습니다</p>";
                    html2 +="	<button class='w3-button w3-large w3-round-large w3-red confirm-room-del'>삭제</button>";
                    html2 +="</div>";
                    $('.msg-area').append(html2);
                    $('.confirm-room-del').on('click',function(){
                        $('#ask-delroom-modal').show();
                    });
                    /* $('.delRoomYes').on('click',function(){
                        $('#ask-delroom-modal').hide();
                        removeRoom(roomIdx);
                    });
                    $('.delRoomNo').on('click',function(){
                        $('#ask-delroom-modal').hide();
                    }); */
                }
                
                var a= true;
                $('.msg-area').on('mousewheel',function(e){
                    var wheel = e.originalEvent.wheelDelta;
                    var scroll = $('.msg-area').scrollTop();
                    console.log();
                    if(wheel>0&&scroll==0&&roomIdx>-1&&a==true){
                        a=false;                        
                        insertMsgList(roomIdx,delUser);
                    }
                });
                //처음 뽑는 메세지리스트라면 스크롤 맨밑으로 
                if(page===0){
                    $('.msg-area').scrollTop($('.msg-area')[0].scrollHeight);
                }else{
                    $('.msg-area').scrollTop( $('.msg-area').prop('scrollHeight')-scHeight);
                }
                $('.msgimgtag').on('click',function(){
                    console.log($(this).attr('src'));
                    $('.clickImg').attr('src',$(this).attr('src'));
                    $('.img-zoom-modal').show();
                });
                $('.message').on('click',function(){
                    var text = $(this).find('span');
                    if($(this).attr('id')=='right-msg'){
                        $('#msg-modal').show();
                    }
                    var idx = $(this).closest('.msg-box').attr('i');
                    $('#msg-del').off();
                    $('#msg-del').on('click',function(){
                        delMessage(idx);
                        text.addClass('w3-text-theme5');
                        text.text('(삭제된 메세지입니다)');
                        $('#msg-modal').hide();
                    });
                    $('#msg-modal-close').off();
                    $('#msg-modal-close').on('click',function(){
                        $('#msg-modal').hide();
                    });
                });
            }
            page++;
        }
    });
}
function delMessage(idx){
    $.ajax({
        url:path+'/mc-chat/chat/msg/'+idx,
        type:'post',
        success: function(data){
            if(data>0){
                alert('해당 메세지가 삭제되었습니다');
            }
        }
    });
}
//클릭한 채팅방이 어떤 요청글에대한 채팅인지 정보표시
function insertTopBarReq(idx){
        $.ajax({
            url: path+'/mc-chat/chat/req',
            type: 'get',
            data:{reqIdx:idx},
        success: function(data){
            $('#req-writer').text('요청글 작성자 : '+data.reqNick);
            $('#req-loc').text('요청지역 : '+data.reqLoc);
            $('#req-title').text('제목 : '+data.reqTitle);
        }
    });
}

//채팅 상대방의 이미지 표시
function insertTopBarImg(nick){
    $.ajax({
        url: path+'/mc-chat/chat/img',
        type: 'get',
        data:{nick:nick},
        success: function(data){
            if(!data.includes('http',0)){
                data = uploadPath+data;
            }
            var html='<img src="'+data+'" id="chatuser" class="w3-circle"/>';
            $('#chatuserImg').html(html);
        }
    });
}


//새로운 메세지 확인
function chkNewMsg() {
	$.ajax({
		url : path+'/mc-chat/chat',
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
				if(roomIdx != newMsgList[i].roomIdx){
					var html='';
					html+='<span class="w3-col m1 l1 w3-badge w3-red" id="badge">'+newMsgList[i].newMsgCount+'</span>';
					$('#chat-room'+newMsgList[i].roomIdx).append(html);
				}
			}
		}
	});
}
makeChatRoomList(chkNewMsg);