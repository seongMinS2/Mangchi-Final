/**
 * 
 */
$(document).ready(function(){
	//3점 클릭이벤트 (영상채팅, 채팅방 삭제)
	evClickDots();
});

function evClickDots(){
    $('.bi-three-dots-vertical').on('click',function(){
		$(this).parent().next().slideToggle('fast');
    });
}

