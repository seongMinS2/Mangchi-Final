function commReg(donateIdx) {



}

function commList() {
	$.ajax({
		url : 'http://localhost:8080/donate/comments',
		type: 'get',
		success : function(data) {
			for(var i=0; i<data.length; i++) {
				var list='';
				
			
			
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





function boardList(){

	$.ajax({
		url : 'http://localhost:8080/donate/donateBoard',
		type : 'get',
		success : function(data){
			var html= '';
			for(var i=0;i<data.length; i++) {
				html+='<button type="button" class="menu_card" style="width: 250px; height: 350px; background-color:white; border-radius:10%; margin:10px;" onclick="viewBoard('+data[i].donateIdx+')">';
				html+='		<p class="board_loc" style="text-align:left;">'+data[i].doLoc+'</p>';
				html+='		<p class="board_writer">'+data[i].writer+'</p>';
				html+='		<img src="'+data[i].doImg+'" style="width: 100%">';
				html+='		<h4 class="board_title">'+data[i].title+'</h4>';
				html+='		<p class="board_date">'+data[i].doDate+'</p>';
				html+='		<p class="board_viewcnt">'+data[i].doViewCnt+'</p>';
				html+='</button>';
			}
			$('#listBox').html(html);
		
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
			view+='    <div class="w3-modal-content">';
			view+='     <header class="w3-container">';
			view+='        <span onclick="$(\'#id01\').css(\'display\',\'none\')"';
			view+='        class="w3-button w3-display-topright">&times;</span>';
			view+='        <h2>'+data.title+'</h2>';		
			
			if(loginUser==data.writer) {
				view+='<button id="deleteDonate" style="float:right;" onclick="deleteBoard('+data.donataIdx+')">삭제</button>';
				view+='<button id="editDonate" style="float:right;" onclick="editBoard('+data.donateIdx+')">수정</button>';
			};
			
			view+='        <p>작성자 ' + data.writer+'</p>';
			view+='        <p>조회수 ' + data.doViewCnt+'</p>';
			view+='      </header>';		
			view+='      <div class="w3-container">';
			view+='        <p><img src="'+data.doImg+'" style="width:200px;"></p>';
			view+='        <p>'+data.content+'</p>';
			view+='      </div>';
			view+='      <footer class="w3-container">';
			view+='        <p>comments</p>';
			view+='        <form id="commentForm" onsubmit="return false">';
			view+='				<input type="hidden" value="'+data.donateIdx+'" id="commDonIdx" name="commDonIdx">'
			view+='				<input type="text" value="'+loginUser+'" id="commWriter" name="commWriter" readonly> <br>'
			view+='				<input type="textarea" id="commForm" name="commContent" style="width: 80%; height: 100px; margin:10px;">'
			view+='				<input type="submit" id="commSubmit" value="댓글 작성" onclick="commReg('+data.donateIdx+')">'
			view+='        </form>';	
			view+='			<div id="commList">'
			view+='			</div>'		
			view+='      </footer>';
			view+='    </div>';
			$('#id01').html(view);
		}
	
	});
}



$(document).ready(function(){
	boardList();
});
