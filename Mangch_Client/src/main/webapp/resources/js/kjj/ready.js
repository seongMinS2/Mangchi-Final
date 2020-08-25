function evClickDots(){
    $('.bi-three-dots-vertical').on('click',function(){
		$(this).parent().next().slideToggle('fast');
	});
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
	});
	$('.delRoomNo').on('click',function(){
		$('#ask-delroom-modal').hide();
	});
}

function evClickSelectImg(){
	$('.img-select-btn').on('click',function(){
		$('#img-modal').show();
	});
	$('.closeImgModal').on('click',function(){
		$('#img-modal').hide();
	});
	$('.imgSelect').on('click',function(){
		console.log('이미지 선택완료');
		$('#img-modal').hide();
	});
}

function evClickMsg(){
	$('.send-msg').on('click',function(){
		console.log('메세지전송 실행');
		$('#msg-text').val('');
	});
	
	$('#msg-text').on('keyup',function(e){
		if($(this).val().length==0){
			$('.send-msg').attr('disabled', true);
		}else{
			$('.send-msg').attr('disabled', false);
		}
	});
	$('#msg-text').on('keypress',function(e){
		if(e.keyCode===13){
			$('.send-msg').trigger('click');
		}
	});
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
