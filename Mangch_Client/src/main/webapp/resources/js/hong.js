var loading=false;
var page=1;
var commPage=1;
var search=null;

//ContextPath 얻기
function getContextPath() {
  var hostIndex = location.href.indexOf( location.host ) + location.host.length;
  return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
};



//댓글 삭제
function deleteComm(idx){

		if(confirm('정말로 삭제하시겠습니까?')) {
		$.ajax({
			url : "http://ec2-15-164-163-60.ap-northeast-2.compute.amazonaws.com:8080/donateBoard/comments/"+idx,
			type : "delete",
			success : function(data){
				alert('댓글을 삭제하였습니다.');
				history.go(0);
			}
		
		});
	}


}


//댓글의 댓글 달기
function reply(idx) {

	$.ajax({
		url : 'http://ec2-15-164-163-60.ap-northeast-2.compute.amazonaws.com:8080/donateBoard/comments/reply',
		type : 'post',
		data : {
			donateIdx : $('.commReplyDonIdx'+idx).val(),
			commParent : $('.commReplyParIdx'+idx).val(),
			commDepth : $('.commReplyDepth'+idx).val(),
			commWriter : $('.commReplyWriter'+idx).val(),
			commText : $('.commReplyText'+idx).val(),
		},
		success : function(data){
			alert('대댓글을 작성하였습니다.');
			commList($('#commDonIdx').val());
			document.getElementById('replayForm'+idx).reset();
			$('.replyForm'+idx).css('display', 'none');
		}
	
	});

}


//댓글 달기
function commReg() {

	$.ajax({
		url : 'http://ec2-15-164-163-60.ap-northeast-2.compute.amazonaws.com:8080/donateBoard/comments',
		type : 'post',
		data : {
			donateIdx : $('#commDonIdx').val(),
			commWriter : $('#commWriter').val(),
			commText : $('#commText').val(),
		},
		success : function(data){
			alert('댓글을 작성였습니다.');
			commList($('#commDonIdx').val());
			document.getElementById('commentForm').reset();		
		}
	
	});



}

//댓글달기 폼 열기
function replyFormToggle(commIdx) {
  var x = document.getElementById("replyForm"+commIdx);
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
  } else {
    x.className = x.className.replace(" w3-show", "");
  }


}



//댓글 페이징
function commPageUp(donateIdx, x){
	commPage=x;
	commList(donateIdx);
}


//댓글 리스트
function commList(donateIdx) {
	var loginUser=$('#loginUser').val();
	$.ajax({
		url : 'http://ec2-15-164-163-60.ap-northeast-2.compute.amazonaws.com:8080/donateBoard/comments/'+donateIdx,
		type: 'get',
		data : {
			'page' : commPage 
		},
		success : function(data) {
			var list='';
			list+='<div id="commpageBox" style="text-align:center;">';
			for (var x=1; x<=data.pageTotalCount; x++){
				list+='<button type="button" class="w3-button w3-theme-l1" onclick="commPageUp('+donateIdx+', '+x+')">'+x+'</button>';
			}
			list+='</div>';			
			list+='<hr>';
			for(var i=0; i<data.commList.length; i++)  {

			
				if(data.commList[i].commParent===0) {
					list+='<div class="commOrigin" style="overflow:hidden;">';
					list+='	<p>작성자 : '+data.commList[i].commWriter+'</p>';
					if(loginUser==data.commList[i].commWriter) {
						list+='	<button class="w3-button w3-theme-l3" style="float:right;" onclick="deleteComm('+data.commList[i].commIdx+')">댓글 삭제</button>';
					}
					list+='	<p>'+data.commList[i].commText+'</p>';
					list+='	<p style="font-size:0.8em; display:inline;">'+data.commList[i].commRegdate+'</p>';
					
					if(loginUser!=null) {
						
						list+='	<button type="button" class="w3-button w3-theme-l5" onclick="replyFormToggle('+data.commList[i].commIdx+')">답글쓰기</button>';
						list+='	<div class="w3-hide" id="replyForm'+data.commList[i].commIdx+'">';
						list+='	<form id="replayForm'+data.commList[i].commIdx+'">';
						list+='		<input type="hidden" name="donateIdx" value="'+data.commList[i].donateIdx+'" class="commReplyDonIdx'+data.commList[i].commIdx+'">';
						list+='		<input type="hidden" name="commParent" value="'+data.commList[i].commIdx+'" class="commReplyParIdx'+data.commList[i].commIdx+'">';
						list+='		<input type="hidden" name="commDepth" value="'+data.commList[i].commDepth+'" class="commReplyDepth'+data.commList[i].commIdx+'">';
						list+='		<input type="hidden" name="commWriter" value="'+loginUser+'" class="commReplyWriter'+data.commList[i].commIdx+'">';
						list+='		<input type="textarea" name="commText" style="width: 80%; height: 70px; margin:10px;" class="commReplyText'+data.commList[i].commIdx+'" placeholder="댓글을 입력해주세요." required>';
						list+='		<input type="submit" class="replySubmit'+data.commList[i].commIdx+'" value="댓글 작성" onclick="reply('+data.commList[i].commIdx+')">';
						list+='	</form>';
						list+='	</div>';
					}
					
					list+='</div>';
					list+='<hr>';
	
				} 
				
				for(var j=0; j<data.commList.length; j++) {
					if (data.commList[j].commParent===data.commList[i].commIdx) {
						list+='<div class="commRe" style="overflow:hidden;">';
						list+='<div style="diplay:inline; width:95%; float:right;">';
						list+='	<p>작성자 : '+data.commList[j].commWriter+'</p>';
						
						if(loginUser==data.commList[i].commWriter) {
							list+='	<button class="w3-button w3-theme-l3" style="float:right;" onclick="deleteComm('+data.commList[i].commIdx+')">댓글 삭제</button>'
						}

						list+='	<p>'+data.commList[j].commText+'</p>'
						list+='	<p style="font-size:0.8em; display:inline;">'+data.commList[j].commRegdate+'</p>'
						list+='</div>';
						list+='</div>';		
						list+='<hr>';							
					}
				}


			}

			$('#commList').html(list);
		} 
		
	});
}


//글 수정하기
function editBoard(idx) {

		var editBoard=new FormData();
		editBoard.append('donateIdx', $('#editIdx').val());
		editBoard.append('writer', $('#editWriter').val());
		editBoard.append('title', $('#editTitle').val());
		editBoard.append('content', $('#summernote').val());
		editBoard.append('doLoc', $('#editDoLoc').val());
		editBoard.append('oldImg', $('#oldImg').val());
		editBoard.append('doStatus', $('#editStatus').val());
		
		if($('#editDoImg')[0].files[0]!=null) {
			editBoard.append('doImg', $('#editDoImg')[0].files[0]);
		}
		

		$.ajax({
			url : "http://ec2-15-164-163-60.ap-northeast-2.compute.amazonaws.com:8080/donateBoard/donateBoard/"+idx,
			data : editBoard,
			type : "POST",
			contentType : false,
			processData : false,
			success : function(data) {
            	alert('나눔글을 수정하였습니다.')
            	location.href=getContextPath()+"/donateBoard";
			},
			error : function(){
				
				console.log('실패한 수정 정보 : '+editBoard);				
			}
		});

	

}

//글 삭제하기
function deleteBoard(idx) {
	if(confirm('정말로 삭제하시겠습니까?')) {
		$.ajax({
			url : "http://ec2-15-164-163-60.ap-northeast-2.compute.amazonaws.com:8080/donateBoard/donateBoard/"+idx,
			type : "delete",
			success : function(data){
				alert('나눔글을 삭제하였습니다.');
				history.go(0);
			}
		
		});
	}


}


//글쓰기
function goWrite() {

		var subTitle=$('#title').val();
		
		var regBoard=new FormData();
		regBoard.append('writer', $('#writer').val());
		regBoard.append('title', $('#title').val());
		regBoard.append('content', $('#summernote').val());
		regBoard.append('doLoc', $('#doLoc').val());
		
		if($('#doImg')[0].files[0]!=null) {
			regBoard.append('doImg', $('#doImg')[0].files[0]);
		}
		

		$.ajax({
			url : "http://ec2-15-164-163-60.ap-northeast-2.compute.amazonaws.com:8080/donateBoard/donateBoard",
			data : regBoard,
			type : "POST",
			contentType : false,
			processData : false,
			success : function(data) {
            	alert('나눔글을 작성하였습니다. 좋은 사람...')
            	location.href=getContextPath()+"/donateBoard";
            	
			},
			error : function(){
				console.log('실패한 글쓰기 정보 : '+regBoard);				
			}
		});
	}
	
	
	
//수정 폼 열기
function editForm(idx) {
	$('#donateEdit').css('display','block');
	var loginUser=$('#loginUser').val();
	
	$.ajax({
		url : "http://ec2-15-164-163-60.ap-northeast-2.compute.amazonaws.com:8080/donateBoard/donateBoard/"+idx,
		type : 'get',
		success : function(data){
			
			var post='';
			post+='    <div class="w3-modal-content" style="overflow:auto;">';
			post+='     <header class="w3-container">';
			post+='			<h2>나눔글 수정하기</h2>'
			post+='        <span onclick="$(\'#donateEdit\').css(\'display\', \'none\')" class="w3-button w3-display-topright">&times;</span>';
			post+='      </header>';		
			post+='      <div class="w3-container" style="overflow:hidden;">';
			post+='			<form onsubmit="return false">';
			post+='				<select id="editStatus" style="display:block; float:right;">';
			post+='					<option value="0" selected>나눔중</option>';
			post+='					<option value="1">나눔완료</option>';
			post+='				</select>';
			post+='				<input type="hidden" id="editIdx" name="donateIdx" value="'+data.donateIdx+'">';
			post+='				<input type="hidden" id="editDoLoc" name="doLoc" value="'+data.doLoc+'">';
			post+='				작성자 : <input type="text" id="editWriter" name="writer" style="width: 20%;" readonly><br>'; 
			post+='				제    목 : <input type="text" id="editTitle" name="title" style="width: 40%;" required/> <br> <br>';
			post+='				<textarea id="summernote" name="content"></textarea>';
			post+='				<input type="text" name="oldImg" id="oldImg" style="width:500px;">'
			post+='				<input type="file" name="doImg" id="editDoImg" style="display:block;">';
			post+='				<input type="reset" style="float: right;" >';
			post+='				<input type="submit" value="글 수정" style="float: right;" onclick="editBoard('+data.donateIdx+')" >';
			post+='			</form>';
			post+='      </div>';
			post+='		<footer class="w3-container">';
			post+='		<br>'
			post+='		</footer>';
			post+='    </div>';
			$('#donateEdit').html(post);
			$('#editWriter').val(data.writer);
			$('#editTitle').val(data.title);
			$('#oldImg').val(data.doImg);
			$('#summernote').val(data.content);
			$('#summernote').summernote({
				minHeight : 370,
				maxHeight : null,
				focus : true,
				lang : 'ko-KR',
				toolbar: [
				    ['fontname', ['fontname']],
				    ['fontsize', ['fontsize']],
				    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
				    ['color', ['forecolor','color']],
				    ['table', ['table']],
				    ['para', ['ul', 'ol', 'paragraph']],
				    ['height', ['height']],
				    ['view', ['fullscreen', 'help']]
				  ],
				fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
				fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
			});
		
		
		}
	
	});
	


}




//상세 글 보기
function viewBoard(idx){
	
	$('#id01').css('display','block');
	var loginUser=$('#loginUser').val();
	
	$.ajax({
		url : 'http://ec2-15-164-163-60.ap-northeast-2.compute.amazonaws.com:8080/donateBoard/donateBoard/'+idx,
		type : 'get',
		success : function(data){
			var view=''; 
			view+='    <div class="w3-modal-content" style="overflow:auto;">';
			view+='     <header class="w3-container">';
			view+='        <span onclick="$(\'#id01\').css(\'display\',\'none\')"';
			view+='        class="w3-button w3-display-topright">&times;</span>';
			view+='        <h2>'+data.title+'</h2>';		
			
			if(loginUser==data.writer ) {
				console.log(loginUser);
				view+='<button class="w3-button w3-theme-l5" id="deleteDonate" style="float:right;" onclick="deleteBoard('+data.donateIdx+')">삭제</button>';
				view+='<button class="w3-button w3-theme-l5" id="editDonate" style="float:right;" onclick="editForm('+data.donateIdx+')">수정</button>';
			};
			
			if(data.doStatus===0) {
				view+='	<p style="display:inline; background-color:green; color:white;">나눔중</p>';
			} else if(data.doStatus===1) {
				view+='	<p style="display:inline; background-color:grey; color:white;">나눔완료</p>';			
			
			};
			view+='<br>';
			view+='        작성자 <p style="display:inline;">'+ data.writer+'</p>';
			view+='<br>';
			view+='        조회수 <p style="display:inline;" id="ReadViewCnt">'+ data.doViewCnt+'</p>';
			view+='			<hr>';
			view+='      </header>';		
			view+='      <div class="w3-container">';
			view+='        <p><img src="http://ec2-15-164-163-60.ap-northeast-2.compute.amazonaws.com:8080/donateBoard/upload/'+data.doImg+'" style="width:200px;"></p>';
			view+='        <p>'+data.content+'</p>';
			view+='			<hr>';
			view+='      </div>';
			view+='      <footer class="w3-container">';
			view+='        <p>comments</p>';
			
			if(loginUser!=null) {
				view+='        <form id="commentForm" onsubmit="return false">';
				view+='				<input type="hidden" value="'+data.donateIdx+'" id="commDonIdx" name="commDonIdx">';
				view+='				<input type="hidden" value="'+loginUser+'" id="commWriter" name="commWriter" readonly>';
				view+='				<input type="textarea" id="commText" name="commText" placeholder="댓글을 입력해주세요" style="width: 80%; height: 70px; margin:10px;" required>';
				view+='				<input type="submit" class="w3-button w3-theme-l5" id="commSubmit" value="댓글 작성" onclick="commReg('+data.donateIdx+')">';
				view+='        </form>';	
			} else {
				view+='	<p>로그인 한 사용자만 댓글을 달 수 있습니다.</p>'			
			};
			view+='			<hr>';
			view+='			<div id="commList">';
			view+='			</div>'	;
			view+='			<hr>';
			
	
			view+='      </footer>';
			view+='    </div>';
			commList(data.donateIdx);		
			$('#id01').html(view);

		}
	
	});
	
	$.ajax({
		url : 'http://ec2-15-164-163-60.ap-northeast-2.compute.amazonaws.com:8080/donateBoard/viewCnt/'+idx,
		type : 'get',
		success : function(data){
			console.log('조회수 업데이트 처리 1이면 성공 : '+data);
			$('.board_viewcnt'+idx).text($('#ReadViewCnt').text());
		}
		
	});
}






//게시판 리스트
function boardList(){
	

	$.ajax({
		url : 'http://ec2-15-164-163-60.ap-northeast-2.compute.amazonaws.com:8080/donateBoard/donateBoard',
		type : 'get',
		data : {
			'page':page,
		},
		success : function(data){
			console.log(page+' page load');
			if(page>data.pageTotalCount) {
				$(window).off();
			}
			var html= '';
			for(var i=0; i<data.boardList.length; i++) {
				html+='<button type="button" class="menu_card w3-hover-shadow" style="width: 250px; height: 400px; background-color:white; border-radius:10%; margin:10px;" onclick="viewBoard('+data.boardList[i].donateIdx+')">';
				html+='		<input type="hidden" class="donIdx" value="'+data.boardList[i].donateIdx+'">';
				if(data.boardList[i].doStatus===0) {
					html+='	<p style="display:inline; background-color:green; color:white;">나눔중</p>';
					
				} else if(data.boardList[i].doStatus===1) {
					html+='	<p style="display:inline; background-color:gray; color:white;">나눔완료</p>';			
				
				};
				html+='		<input type="hidden" class="board_loc" value="'+data.boardList[i].doLoc+'">';
				html+='		<p class="board_writer"> 작성자 : '+data.boardList[i].writer+'</p>';
				html+='		<img src="http://ec2-15-164-163-60.ap-northeast-2.compute.amazonaws.com:8080/donateBoard/upload/'+data.boardList[i].doImg+'" style="width: 100%; height:150px;">';
				html+='		<p class="board_title">'+data.boardList[i].title+'</p>';
				html+='		<p class="board_date">'+data.boardList[i].toDate+'</p>';
				html+='		조회수 <p class="board_viewcnt'+data.boardList[i].donateIdx+'" style="display:inline;">'+data.boardList[i].doViewCnt+'</p>';
				html+='</button>';
				
			}
			$('#listBox').append(html);
			page++;
			loading=false;
			
		}
	});
	
		//무한 스크롤 페이징
	$(window).scroll(function() {
		if($(window).scrollTop()+200>=$(document).height() - $(window).height()) {
			if(!loading) {
				loading=true;
				boardList();
			} 
        } 
    }); 	
	
	
}

//검색하기
function boardSearchList(search){
	
	loading=false;
	$.ajax({
		url : 'http://ec2-15-164-163-60.ap-northeast-2.compute.amazonaws.com:8080/donateBoard/donateBoard',
		type : 'get',
		data : {
			'searchKey':search

		},
		success : function(data){
			console.log(search+' 검색 중');
			if(page>data.pageTotalCount) {
				$(window).off();
			}
			
			var searchHtml= '';
			for(var i=0; i<data.boardList.length; i++) {
				searchHtml+='<button type="button" class="menu_card w3-hover-shadow" style="width: 250px; height: 400px; background-color:white; border-radius:10%; margin:10px;" onclick="viewBoard('+data.boardList[i].donateIdx+')">';
				searchHtml+='		<input type="hidden" class="donIdx" value="'+data.boardList[i].donateIdx+'">';
				if(data.boardList[i].doStatus===0) {
					searchHtml+='	<p style="display:inline; background-color:green; color:white;">나눔중</p>';
					
				} else if(data.boardList[i].doStatus===1) {
					searchHtml+='	<p style="display:inline; background-color:gray; color:white;">나눔완료</p>';			
				
				};
				searchHtml+='		<input type="hidden" class="board_loc" value="'+data.boardList[i].doLoc+'">';
				searchHtml+='		<p class="board_writer"> 작성자 : '+data.boardList[i].writer+'</p>';
				searchHtml+='		<img src="http://ec2-15-164-163-60.ap-northeast-2.compute.amazonaws.com:8080/donateBoard/upload/'+data.boardList[i].doImg+'" style="width: 100%; height:150px;">';
				searchHtml+='		<p class="board_title">'+data.boardList[i].title+'</p>';
				searchHtml+='		<p class="board_date">'+data.boardList[i].toDate+'</p>';
				searchHtml+='		조회수 : <p class="board_viewcnt'+data.boardList[i].donateIdx+'" style="display:inline;"> '+data.boardList[i].doViewCnt+'</p>';
				searchHtml+='</button>';
				
			}
			$('#listBox').html(searchHtml);
			
		}
	});
	
			//무한 스크롤 페이징
	$(window).scroll(function() {
		if($(window).scrollTop()+200>=$(document).height() - $(window).height()) {
			if(!loading) {
				loading=true;
				boardSearchList(search);
			} 
        } 
    }); 	
	
}



$(document).ready(function(){

	boardList();

	//검색 버튼을 누르면
	$('#searchBar').click(function(){
		search=$('#searchKey').val();
		console.log('검색어 :'+search);
		boardSearchList(search);

	});
	

	
});
