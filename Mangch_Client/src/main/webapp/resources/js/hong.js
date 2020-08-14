function reply(parentIdx){


}



function commReg() {

	$.ajax({
		url : 'http://localhost:8080/donate/comments/',
		type : 'post',
		data : {
			donateIdx : $('#commDonIdx').val(),
			commWriter : $('#commWriter').val(),
			commText : $('#commText').val(),
		},
		success : function(data){
			commList($('#commDonIdx').val());
			document.getElementById('commentForm').reset();		
		}
	
	});



}

function commList(donateIdx) {
	$.ajax({
		url : 'http://localhost:8080/donate/comments/'+donateIdx,
		type: 'get',
		success : function(data) {
			var list='';
			for(var i=0; i<data.length; i++)  {
				list+='<div class="comm">';
				list+='	<p>작성자 : '+data[i].commWriter+'</p>';
				list+='	<p>'+data[i].commText+'</p>'
				list+='	<p style="font-size:0.8em;">'+data[i].commRegdate+'</p>'
				list+='	<button type="button" onclick="reply('+data[i].commIdx+')">답글쓰기</button>'
				list+='</div>';
			}
			$('#commList').html(list);
		} 
		
	});
}



function editBoard(idx) {

	

}

function deleteBoard(idx) {
	if(confirm('정말로 삭제하시겠습니까?')) {
		$.ajax({
			url : "http://localhost:8080/donate/donateBoard"+idx,
			type : "delete",
			success : function(data){
				alert('나눔글을 삭제하였습니다.');
				history.go(-1);
			}
		
		});
	}


}



function goWrite() {
		var regBoard=new FormData();
		regBoard.append('writer', $('#writer').val());
		regBoard.append('title', $('#title').val());
		regBoard.append('content', $('#summernote').val());
		regBoard.append('doLoc', $('#doLoc').val());
		
		if($('#doImg')[0].files[0]!=null) {
			regBoard.append('doImg', $('#doImg')[0].files[0]);
		}
		

		$.ajax({
			url : "http://localhost:8080/donate/donateBoard",
			data : regBoard,
			type : "POST",
			contentType : false,
			processData : false,
			success : function(data) {
            	alert('나눔글을 작성하였습니다. 좋은 사람...')
            	history.go(-1);
			},
			error : function(){
				console.log(regBoard);				
			}
		});
	}






function viewBoard(idx){
	
	$('#id01').css('display','block');
	var loginUser=$('#loginUser').val();
	$.ajax({
		url : 'http://localhost:8080/donate/donateBoard/'+idx,
		type : 'get',
		success : function(data){
			var view=''; 
			view+='    <div class="w3-modal-content" style="overflow:auto;">';
			view+='     <header class="w3-container">';
			view+='        <span onclick="$(\'#id01\').css(\'display\',\'none\')"';
			view+='        class="w3-button w3-display-topright">&times;</span>';
			view+='        <h2>'+data.title+'</h2>';		
			
			if(loginUser==data.writer) {
				console.log(loginUser);
				view+='<button id="deleteDonate" style="float:right;" onclick="deleteBoard('+data.donataIdx+')">삭제</button>';
				view+='<button id="editDonate" style="float:right;" onclick="editBoard('+data.donateIdx+')">수정</button>';
			};
			
			view+='        <p>작성자 ' + data.writer+'</p>';
			view+='        <p>조회수 ' + data.doViewCnt+'</p>';
			view+='			<hr>';
			view+='      </header>';		
			view+='      <div class="w3-container">';
			view+='        <p><img src="'+data.doImg+'" style="width:200px;"></p>';
			view+='        <p>'+data.content+'</p>';
			view+='			<hr>';
			view+='      </div>';
			view+='      <footer class="w3-container">';
			view+='        <p>comments</p>';
			
			
			if(loginUser!=null) {
				view+='        <form id="commentForm" onsubmit="return false">';
				view+='				<input type="hidden" value="'+data.donateIdx+'" id="commDonIdx" name="commDonIdx">'
				view+='				<input type="hidden" value="'+loginUser+'" id="commWriter" name="commWriter" readonly>'
				view+='				<input type="textarea" id="commText" name="commText" placeholder="댓글을 입력해주세요" style="width: 80%; height: 70px; margin:10px;">'
				view+='				<input type="submit" id="commSubmit" value="댓글 작성" onclick="commReg('+data.donateIdx+')">'
				view+='        </form>';	
			} else {
				view+='	<p>로그인 한 사용자만 댓글을 달 수 있습니다.</p>'			
			};
			
			view+='			<hr>'
			view+='			<div id="commList">'
			view+='			</div>'		
			view+='      </footer>';
			view+='    </div>';
			commList(data.donateIdx);		
			$('#id01').html(view);

		}
	
	});
	
	$.ajax({
		url : 'http://localhost:8080/donate/viewCnt/'+idx,
		success : function(data){
			boardList();
		}
		
	});
}


function boardList(){

	$.ajax({
		url : 'http://localhost:8080/donate/donateBoard',
		type : 'get',
		success : function(data){
			var html= '';
			for(var i=0;i<data.length; i++) {
				html+='<button type="button" class="menu_card" style="width: 250px; height: 350px; background-color:white; border-radius:10%; margin:10px;" onclick="viewBoard('+data[i].donateIdx+')">';
				html+='		<input type="hidden" class="donIdx" value="'+data[i].donateIdx+'">'
				html+='		<p class="board_loc" style="text-align:left;">'+data[i].doLoc+'</p>';
				html+='		<p class="board_writer"> 작성자 : '+data[i].writer+'</p>';
				html+='		<img src="'+data[i].doImg+'" style="width: 100%;">';
				html+='		<h4 class="board_title">'+data[i].title+'</h4>';
				html+='		<p class="board_date">'+data[i].doDate+'</p>';
				html+='		<p class="board_viewcnt"> 조회수 : '+data[i].doViewCnt+'</p>';
				html+='</button>';
			}
			$('#listBox').html(html);
		
		}
	});
}




$(document).ready(function(){

	boardList();
	
	
});
