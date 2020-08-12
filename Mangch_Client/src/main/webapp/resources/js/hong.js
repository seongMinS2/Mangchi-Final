
function goWrite(frm) {
	var title = frm.title.value;
	var writer = frm.writer.value;
	var content = frm.content.value;
	
	if (title.trim() == ''){
		alert("제목을 입력해주세요");
		return false;
	}
	if (writer.trim() == ''){
		alert("작성자를 입력해주세요");
		return false;
	}
	if (content.trim() == ''){
		alert("내용을 입력해주세요");
		return false;
	}
	frm.submit();
}

function uploadSummernoteImageFile(file, editor) {
		data = new FormData();
		data.append("doImg", file);
		$.ajax({
			data : data,
			type : "POST",
			url : "http://localhost:8080/donate/donateBoard",
			contentType : false,
			processData : false,
			success : function(data) {
            	//항상 업로드된 파일의 url이 있어야 한다.
				$(editor).summernote('insertImage', data.url);
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
				html+='		<img src="'+data[i].doImg+'" style="width: 100%">';
				html+='		<h4 class="board_title">'+data[i].doTitle+'</h4>';
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
			view+='        <h2>'+data.doTitle+'</h2>';		
			view+='      </header>';		
			view+='      <div class="w3-container">';
			view+='        <p>'+data.doText+'</p>';
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
