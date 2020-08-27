function evClickDots(){
    $('.bi-three-dots-vertical').on('click',function(){
		$(this).parent().next().slideToggle('fast');
	});
	$('.out-room').on('click',function(){
		leaveChatRoom();
	});
}

function rmClickDots(){
	$('.bi-three-dots-vertical').off();
	$('.out-room').off();
}
function evMsgClick(){
	$('.message').off();
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
function evClickDelRoom(){
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
}
function rmClickDelRoom(){
	$('.confirm-room-del').off();
	$('.delRoomYes').off();
	$('.delRoomNo').off();
}
function evClickSelectImg(){
	$('.img-select-btn').on('click',function(){
		$('#msg-text').val('');
		$('#img-modal').show();
	});
	$('.closeImgModal').on('click',function(){
		$('#img-modal').hide();
	});
	$('.imgSelect').on('click',function(){
		if(roomIdx>-2 && $('#msgPhoto')[0].files[0]!=null&&delUser==null){
			console.log('메세지전송 !!');
			sendMsg();
		}else if($('#msgPhoto')[0].files[0]==null){
			alert('사진을 선택하지 않았어요 ');
		}else if(delUser!=null){
			alert('대화 종료한 상대에게는 메세지를 보낼수 없어요');
		}else if(roomIdx==-2){
			alert('메세지를 선택해주세요');
		}
		$('#msgPhoto').val(null);
		$('.send-msg').attr('disabled', true);
		$('#img-modal').hide();
	});
}

function evClickMsg(){
	$('.send-msg').on('click',function(){
		if (roomIdx > -2 && $('#msg-text').val().length > 0&&delUser==null) {
			console.log('메세지전송 !!');
			sendMsg();
		}else if(delUser!=null){
			alert('대화 종료한 상대에게는 메세지를 보낼수 없어요');
		}else if(roomIdx==-2){
			alert('메세지를 선택해주세요');
		}else if($('#msg-text').val().length == 0){
			alert('메세지를 입력해주세요 ');
		}
		$('#msg-text').val('');
		$('.send-msg').attr('disabled', true);
		$('#img-modal').hide();
	});
	
	$('#msg-text').on('keyup',function(e){
		if(roomIdx<-1||$(this).val().length==0){
			$('.send-msg').attr('disabled', true);
		}else{
			$('.send-msg').attr('disabled', false);
		}
		if(e.keyCode===13){
			$('.send-msg').attr('disabled', true);
		}
	});
	$('#msg-text').on('keypress',function(e){
		if(e.keyCode===13){
			$('.send-msg').trigger('click');
		}
	});
}
function rmClickMsg(){
	$('.send-msg').off();
	$('#msg-text').off();
}
function evClickSearch(){
	$('#room-search-btn').on('click',function(){
		console.log('검색 실행');
		$('#roomSearch').val('');
	});
	$('#roomSearch').on('keypress',function(e){
		if(e.keyCode===13){
			$('#room-search-btn').trigger('click');
		}
	});
}
