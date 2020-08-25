function evClickDots(){
    $('.bi-three-dots-vertical').on('click',function(){
		$(this).parent().next().slideToggle('fast');
	});
	$('.video-chat').on('click',function(){
		console.log('영상통화 버튼 클릭');
	});
}

function rmClickDots(){
	$('.bi-three-dots-vertical').off();
	$('.video-chat').off();
}
function evClickVideoChat(){
	$('.video-chat').on('click',function(){
		console.log('영상통화 버튼 클릭');
	});
}

function evClickDelRoom(){
	$('.confirm-room-del').on('click',function(){
		$('#ask-delroom-modal').show();
	});
	$('.delRoomYes').on('click',function(){
		console.log('삭제 확인버튼 클릭');
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
		console.log('이미지 선택완료');
		if(roomIdx>-2 && $('#msgPhoto')[0].files[0]!=null){
			sendMsg();
			$('#msgPhoto').val(null);
		}else if($('#msgPhoto')[0].files[0]==null){
			alert('전송실패');
		}
		$('#img-modal').hide();
	});
}

function evClickMsg(){
	$('.send-msg').on('click',function(){
			console.log('메세지전송 메서드들어옴 ');
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
