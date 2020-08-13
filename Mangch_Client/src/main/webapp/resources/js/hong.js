

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
			view+='        <p>'+data.writer+'</p>';
			view+='        <p>'+data.doViewCnt+'</p>';
			view+='      </header>';		
			view+='      <div class="w3-container">';
			view+='        <p><img src="'+data.doImg+'" style="width:200px;"></p>';
			view+='        <p>'+data.content+'</p>';
			view+='      </div>';
			view+='      <footer class="w3-container">';
			view+='        <p>댓글공간</p>';
			view+='      </footer>';
			view+='    </div>';
			$('#id01').html(view);
		}
	
	});
}



$(document).ready(function(){
	boardList();
});
