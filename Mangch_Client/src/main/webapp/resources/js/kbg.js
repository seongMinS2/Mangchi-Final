
function gbList() {
	$.ajax({
		url:'http://localhost:8080/guest/guest_book' ,
		type:'get',
		success : function (data) {
			
			var html='';
			for(var i=0; i<data.length; i++){
				if(data[i].guest_photo !=null){
				html+='<article class="have_photo">';
			    html+='<header>';
			    html+='<input type="hidden" name="guest_idx">';
			    //아래가 멤버프로필이미지 가져와야함
			    html+='<div class="hd_img"><img src="https://img1.daumcdn.net/thumb/R720x0.q80/?scode=mtistory2&fname=http%3A%2F%2Fcfile26.uf.tistory.com%2Fimage%2F2369374A56F366BB34731F"></div>';
			    //아래가 멤버닉네임가져와야함
			    html+='<div class="hd_nick">'+data[i].guest_writer+'</div>';
			    html+='</header>';
			    //html+='<div class="photo_body">'+data[i].guest_photo+'</div>';
			    html+='<div class="photo_body"><img src="https://img1.daumcdn.net/thumb/R720x0.q80/?scode=mtistory2&fname=http%3A%2F%2Fcfile26.uf.tistory.com%2Fimage%2F2369374A56F366BB34731F"></div>';
			    html+='<div class="text_body">';
			    html+='<section>';
			    html+='<button class="footers"><img src="https://p.kindpng.com/picc/s/169-1694281_heart-symbol-computer-icons-heart-icon-instagram-png.png"></button>';
			    html+='<button><img src="https://www.pngitem.com/pimgs/m/21-212930_transparent-square-speech-bubble-png-transparent-instagram-comment.png"></button>';
			    html+='<div class="likes">좋아요 '+data[i].guest_like+' 개</div>';
			    html+='</section>'; 
			    html+='<div class="content">';
			    html+='<div class="realtext">'+data[i].guest_text+'<br>';
			    html+='</div>';
			    html+='</div>';
			    html+='<div class="comment">';
			    html+='<div class="cmtnum">댓글 모두보기</div>';
			    html+='<section>';
			    html+='<div class="flex">';
			    html+='<div class="cmtnick">짱가</div>';
			    html+='<div class="cmttext">엌ㅋㅋㅋㅋ</div>';
			    html+='</div>';
			    html+='<div class="flex">';
			    html+='<div class="cmtnick">병장</div>';
			    html+='<div class="cmttext">앜ㅋㅋㅋㅋ</div>';
			    html+='</div>';
			    html+='</section>';
			    html+='</div>';
			    html+='<div class="cmtbunki">';
			    html+='<input type="text" class="cmtwr" id="cmtwr" placeholder="    댓글 달기">';
			    html+='<input type="submit" class="cmtsb" value="등록">';
			    html+='</div>';
			    html+='</div>'; 
			    html+='</article>';
				} else if(data[i].guest_photo ==null){
					html+='<article class="none_photo">';
				    html+='<header>';
				    html+='<input type="hidden" name="guest_idx">';
				    html+='<div class="hd_img"><img src="https://img1.daumcdn.net/thumb/R720x0.q80/?scode=mtistory2&fname=http%3A%2F%2Fcfile26.uf.tistory.com%2Fimage%2F2369374A56F366BB34731F"></div>';
				    html+='<div class="hd_nick">'+data[i].guest_writer+'</div>';
				    html+='</header>';
				   
				    
				    html+='<div class="null_content">'
				    html+='<div class="nonerealtext">'+data[i].guest_text+'</div>'
				    html+='</div>'
				    
				    html+='<div class="text_body">';
				    html+='<section>';
				    html+='<button class="footers"><img src="https://p.kindpng.com/picc/s/169-1694281_heart-symbol-computer-icons-heart-icon-instagram-png.png"></button>';
			    	html+='<button><img src="https://www.pngitem.com/pimgs/m/21-212930_transparent-square-speech-bubble-png-transparent-instagram-comment.png"></button>';
				    html+='<div class="likes">좋아요 '+data[i].guest_like+' 개</div>';
				    html+='</section>'; 
				    
				 
				    html+='<div class="comment">';
				    html+='<div class="cmtnum">댓글 모두보기</div>';
				    html+='<section>';
				    html+='<div class="flex">';
				    html+='<div class="cmtnick">짱가</div>';
				    html+='<div class="cmttext">엌ㅋㅋㅋㅋ</div>';
				    html+='</div>';
				    html+='<div class="flex">';
				    html+='<div class="cmtnick">병장</div>';
				    html+='<div class="cmttext">앜ㅋㅋㅋㅋ</div>';
				    html+='</div>';
				    html+='</section>';
				    html+='</div>';
				    html+='<div class="cmtbunki">';
				    html+='<input type="text" class="cmtwr" id="cmtwr" placeholder="    댓글 달기">';
				    html+='<input type="submit" class="cmtsb" value="등록">';
				    html+='</div>';
				    html+='</div>'; 
				    html+='</article>';
				}
			
			
			
			} // for문 끝 
			
			$('#guestbookList').html(html);
			
		} // success끝 
		
		
	}); // ajax끝 
	
}




$(document).ready(function () {
	
	gbList();

});