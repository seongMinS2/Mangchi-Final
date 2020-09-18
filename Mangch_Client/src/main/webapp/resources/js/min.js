/*============================================================================================================================================================*/
/*전역 변수 정리*/

//페이지 번호(start = 1)
var idx = 1;

//검색 텍스트
var keyword = '';

//검색 타입
var searchType = '';

/*============================================================================================================================================================*/
/*페이징 함수들*/

//페이지번호
function pageNum(num){
	this.idx = num;
	//console.log('페이지번호 클릭시' + idx);
	qnaboardList();
	return false;
}

//다음페이지 버튼
function nextPage(endNum){
	this.idx++;
	if(idx>endNum)
		idx=endNum;
	qnaboardList();
	return false;
}

//이전페이지 버튼
function prevPage(){
	this.idx--;
	if(idx<=1)
		idx= 1;
	qnaboardList();
	return false;
}

//마지막 페이지 리스트 버튼
function endPage(endNum){
	this.idx = endNum;
	qnaboardList();
	return false;
}
//첫 페이지 리스트 버튼
function firstPage(){
	this.idx = 1;
	qnaboardList();
	return false;
} 
/*============================================================================================================================================================*/




/*============================================================================================================================================================*/

//게시판 리스트 출력
function qnaboardList() {
//	alert(keyword + searchType);

	$.ajax({
		url: 'http://ec2-13-125-52-199.ap-northeast-2.compute.amazonaws.com:8080/mc/qna/?idx='+idx+'&keyword='+keyword+'&searchType='+searchType,
		type: 'get',
		success: function (data) {
			//console.log(JSON.stringify(data));
			// $('#QnABoardList').html(JSON.stringify(data));

			var html = '';
			html += '<div class="table-wrap">'; 
			html += '	<table class="w3-table">';
			html += '		<th class="w3-center w3-padding">번호</th>';
			html += '		<th class="w3-padding">제목</th>';
			html += '		<th class="w3-center w3-padding">작성자</th>';
			html += '		<th class="w3-center w3-padding">작성일</th>';
			html += '		<th class="w3-center w3-padding">조회</th>';
			//게시글
			for (var i = 0; i < data.boardList.length; i++) {
				html += '		<tr>';
				html += '			<td class="w3-center w3-padding">' + data.boardList[i].idx + '</td>';
				html += '			<td class="w3-padding w3-border-left w3-border-white w3-hover-border-theme"><a class="qna-board-title" href="#" onclick="return qnaDetailView(' + data.boardList[i].pwCheck + ','+data.boardList[i].idx+')">'+data.boardList[i].title+'</a>';
				if(data.boardList[i].pwCheck != 0)
				html += '<span class="w3-right">🔒</span>'
				html += '</td>';
				html += '			<td class="w3-center w3-padding">' + data.boardList[i].memNick + '</td>';
				html += '			<td class="w3-center w3-padding">' + moment(data.boardList[i].regdate).format('YY년MM월DD일') + '</td>';
				html += '			<td class="w3-center w3-padding">' + data.boardList[i].count + '</td>';
				html += '		</tr>';
			}
			html += '	</table><br><br>';
			//페이징 처리 부분
			html += '		<div class="w3-bar w3-small w3-center">';
			html += '			<a href="#" class="w3-button" onclick="return firstPage()"><<</a>';
			html += '			<a href="#" class="w3-button" onclick="return prevPage()"><</a>';
			for(var i=data.startPage; i<=data.endPage; i++){
				html += '			<a href="#" class="w3-button" onclick="return pageNum('+i+')">'+i+'&nbsp;</a>';
			}
			html += '			<a href="#" class="w3-button" onclick="return nextPage('+data.totalPage+')">></a>';
			html += '			<a href="#" class="w3-button" onclick="return endPage('+data.totalPage+')">>></a>';
			html += '		</div>';
			html += '</div>';
			html += '<hr>';
			$('#QnABoardList').html(html);

			//마우스hover
			$('.qna-board-title').addClass('w3-hover-theme5');

		}
	});
}


/*============================================================================================================================================================*/
	
//게시물 출력
function contentsList(idx, loginSession) {
	$.ajax({
		url: 'http://ec2-13-125-52-199.ap-northeast-2.compute.amazonaws.com:8080/mc/qna/contents/' + idx,
		type: 'get',
		success: function (data) {
			//console.log(JSON.stringify(data));
			//$('.contentBox').html(JSON.stringify(data));

			var html = '';
			html += '<div class="header">';
			html += '	<h4 id="qna-header" class="w3-border-bottom w3-border-theme"> 제목 : ' + data.title + '</h4>';
			html += '</div>';
			html += '	<div class="articleContainer">';
			html += '		<div class="mainContainer">';
			html += '			<p class="text">' + data.contents + '</p>';
			html += '		</div>';
			html += '			<div class="commentBox">';
			html += '			<h3 class="comment_title w3-topbar w3-border-theme5-d5">';
			html += '				<b>댓글</b>';
			html += '			</h3>';
			//댓글
			for (var i = 0; i < data.comment.length; i++) {
				//댓글 부모 컬럼이 0일때(i번째 댓글)
				if (data.comment[i].parents === 0) {
					html += '				<hr><div class="comment_area">';
					html += '					<div class="comment_Box">';
					//자신의 댓글만 수정/삭제 가능
					if(loginSession!=null && loginSession.mNick === data.comment[i].writer){
							html += '						<div class="comment_tool"><i class="xi-ellipsis-v"></i>';
							html += '						<div class="layerMore w3-card-2"><button class="modify_button w3-button w3-theme-l4">수정</button><br><button class="w3-button w3-theme-l4" onclick="commentDelete(' + data.comment[i].idx + ')">삭제</button></div>';
							html += '						</div>';
					}
					html += '						<div class="comment_nick_box" style="font-weight: bold;">' + data.comment[i].writer;
					html += '						</div>';
					html += '						<div class="comment_text_box">' + data.comment[i].contents + '</div>';
					html += '						<div class="comment_info_box">';
					html += '							<span class="comment_info_date" style="color: slategray"> ' + moment(data.comment[i].regdate).format('YYYY.MM.DD, HH:mm') + ' </span>';
					//비회원 대댓글 toggle button 제한
					if(loginSession!=null)
						html += '						 <button class="comment_reply_button w3-button w3-theme5" style="padding:5px">답글쓰기</button>';
						html += '					</div>';
						html += '				</div>';
						html += '			</div>';
					//비회원 대댓글 쓰기 제한
					if(loginSession!=null){
						html += '			<div class="comment_reply">';
						html += '				<div class="commentWriter w3-border w3-round-xlarge">';
						html += '					<div class="comment_inbox">';
						html += '						<div class="comment_inbox_name">';
						html += '							<span class="commet_comment_nick" style="font-weight: bold;">' + loginSession.mNick + '</span>';
						html += '						</div>';
						html += '						<div class="comment_inbox_text">';
						html += '							<textarea cols="50" class="comment_insert"></textarea>';
						html += '						</div>';
						html += '						<div class="comment_submit">';
						html += '							<button class="w3-button w3-theme2-l1" onclick="writeHirachyComment(' + idx +','+ data.comment[i].idx +',this)">등록</button>';
						html += '						</div>';
						html += '					</div>';
						html += '				</div>';
						html += '			</div>';
						//수정일시 보여줄 뷰 
						html += '			<div class="comment_reply_modify">';
						html += '				<div class="commentWriter w3-border w3-round-xlarge">';
						html += '					<div class="comment_inbox">';
						html += '						<div class="comment_inbox_name">';
						html += '							<span class="commet_comment_nick" style="font-weight: bold;">' + loginSession.mNick + '</span>';
						html += '						</div>';
						html += '						<div class="comment_inbox_text">';
						html += '						<textarea cols="50" class="comment_insert">'+data.comment[i].contents+'</textarea>';
						html += '						</div>';
						html += '						<div class="comment_submit">';
						html += '							<button class="comment_modify_cancel w3-button w3-theme-l4">취소</button>';
						html += `							<button class="w3-button w3-theme2-l1" id="modifySub" onclick="qnaModifyComment(${data.comment[i].idx},this)">등록</button>`;
						html += '						</div>';
						html += '					</div>';
						html += '				</div>';
						html += '			</div>';
					}
				}
				//i번째 댓글의 자식 댓글(대댓글)을 찾아 출력
				for (var j = 0; j < data.comment.length; j++) {
					if (data.comment[j].parents === data.comment[i].idx) {
						html += '			<hr><div class="comment_coment_area">';
						html += '				<div class="comment_Box w3-row">';
						//자신의 댓글만 수정/삭제 가능
						if(loginSession!=null && loginSession.mNick === data.comment[i].writer){
								html += '					<div class="comment_tool"><i class="xi-ellipsis-v"></i>';
								html += '					<div class="layerMore w3-card-2"><button class="modify_button w3-button w3-theme-l4">수정</button><br><button class="w3-button w3-theme-l4" onclick="commentDelete(' + data.comment[j].idx + ')">삭제</button></div>';
								html += '					</div>';
						}
						html += '					<div class="comment_nick_box" style="font-weight: bold;">' + data.comment[j].writer;
						html += '					</div>';
						html += '					<div class="comment_textView">' + data.comment[j].contents + '</div>';
						html += '					<div class="comment_info_box">';
						html += '						<span class="comment_info_date" style="color: slategray"> ' + moment(data.comment[j].regdate).format('YYYY.MM.DD, HH:mm') + '</span>';
						// //비회원 답대댓글 toggle button 제한
						// if(loginSession!=null)
						// 	html += '					<button class="comment_reply_button">답글쓰기</button>';
							html += '				</div>';
							html += '			</div>';
							html += '		</div>';
						//비회원 대댓글 쓰기 제한
						if(loginSession != null){
							html += '		<div class="comment_reply">';
							html += '			<div class="commentWriter">';
							html += '				<div class="comment_inbox w3-border w3-round-xlarge">';
							html += '					<div class="comment_inbox_name">';
							html += '						<span class="commet_comment_nick" style="font-weight: bold;">' + loginSession.mNick + '</span>';
							html += '					</div>';
							html += '					<div class="comment_inbox_text">';
							html += '					<textarea class="comment_insert"></textarea>';
							html += '					</div>';
							html += '					<div class="comment_submit">';
							//댓글쓰기 요청
							html += '						<button class="w3-button w3-theme2-l1" onclick="writeHirachyComment(' + idx +','+ data.comment[j].idx +',this)">등록</button>';
							html += '					</div>';
							html += '				</div>';
							html += '			</div>';
							html += '		</div>';
							//수정일시 보여줄 뷰 
							html += '		<div class="comment_reply_modify">';
							html += '			<div class="commentWriter w3-border w3-round-xlarge">';
							html += '				<div class="comment_inbox">';
							html += '					<div class="comment_inbox_name">';
							html += '						<span class="comment_nick" style="font-weight: bold;">' + loginSession.mNick + '</span>';
							html += '					</div>';
							html += '					<div class="comment_inbox_text">';
							html += '					<textarea cols="50" class="comment_insert">'+data.comment[j].contents+'</textarea>';
							html += '					</div>';
							html += '					<div class="comment_submit" id="submit">';
							html += '						<button class="comment_modify_cancel w3-button w3-theme-l4">취소</button>';
							html += `						<button class="w3-button w3-theme2-l1" id="modifySub" onclick="qnaModifyComment(${data.comment[j].idx},this)">등록</button>`;
							html += '					</div>';
							html += '				</div>';
							html += '			</div>';
							html += '		</div>';
							
						}

					}
				}
			}
			//비회원 댓글 쓰기 제한
			if(loginSession != null){
			html += '					<hr>	<div class="commentWriter">';
			html += '							<div class="comment_inbox w3-border w3-round-xlarge">';
			html += '								<div class="comment_inbox_name">';
			html += '									<span class="commet_nick" style="font-weight:bold">' + loginSession.mNick + '</span>';
			html += '								</div>';
			html += '								<div class="comment_inbox_text">';
			html += '									<textarea cols="50" class="comment_insert"></textarea>';
			html += '								</div>';
			html += '								<div class="comment_submit">';
			html += '									<button class="w3-button w3-theme2-l1" onclick="qnaWritComment(' + idx + ')">등록</button>';
			html += '								</div>';
			html += '							</div>';
			html += '						</div>';
			}
			html += '					</div>';
			html += '				</div>';
			html += '			</table>';
			html += '			<div class="articleBottomBtns w3-margin-top">';
				//로그인 한 회원만 수정/답글이 가능
				if(loginSession != null){
					html += '		<a class="w3-button w3-right w3-theme-l4" href="#">TOP</a>';
					html += '<a class="w3-button w3-right w3-theme-l4" href="/mangh/qna/reply-board/' + idx + '">답글쓰기</a>';
					//로그인 한 회원과 게시글의 작성자가 같아야 삭제/수정이 가능
					if(loginSession.mNick === data.memNick){
						html += '		<a class="w3-button w3-right w3-theme-l4" href="#" onclick="qnaDelete(' + idx + ')">글 삭제</a>';
							html += '<a class="w3-button w3-right w3-theme-l4" href="/mangh/qna/update-board/' + idx + '">수정하기</a>';
							}
				}
			html += '	</div>';
			html += '</div>';
			html += '<hr>';
			$('.contentBox').html(html);
			
			//답댓글쓰기 숨김
			$('.comment_reply').hide();
			//댓글 수정폼 숨김
			$('.comment_reply_modify').hide();
			//수정,삭제폼 숨김
			$('.layerMore').hide();

			//:클릭시 수정,삭제폼 보여주기
			$('.comment_tool').click(function(){
				$(this).find('.layerMore').toggle();
			});

			//답댓글쓰기 토글
			$('.comment_reply_button').click(function(){
				var a= $(this).parent().parent().parent();
				a.next().slideToggle('fast');
			});
			//수정 취소 버튼 이벤트
			$('.comment_modify_cancel').click(function(){
				$(this).parent().parent().parent().parent().hide();
				$(this).parent().parent().parent().parent().prev().prev().show();
			});
			//수정버튼 클릭시 댓글뷰 폼 hide 답글쓰기폼 hide 수정폼 show
			$('.modify_button').click(function(){
				$(this).parent().parent().parent().parent().hide();
				$(this).parent().parent().parent().parent().next().hide();
				$(this).parent().parent().parent().parent().next().next().show();
			});

		}
	});
}

/*============================================================================================================================================================*/



//댓글쓰기
function qnaWritComment(idx) {

	var writeData = {
		boardIdx: idx,
		writer: $('.commet_nick:last').text(),
		contents: $('.comment_insert:last').val(),
	};
	$.ajax({
		url: 'http://ec2-13-125-52-199.ap-northeast-2.compute.amazonaws.com:8080/mc/qna/contents/',
		type: 'post',
		data: JSON.stringify(writeData),
		dataType: 'text',
		contentType: 'application/json; charset=UTF-8',
		success: function (data) {
			if (data === "1") {
				alert('댓글 쓰기가 완료되었습니다.');
				location.href = '/mangh/qna/contents/' + idx;
			}
			else if (data === "0") {
				alert('댓글 쓰기가 실패 하였습니다. 관리자에게 문의하세요.');
				location.href = '/mangh/qna/contents/' + idx;
			}
		}
	});
}

//대댓글쓰기
function writeHirachyComment(boIdx,idx,locThis) {

	var writeData = {
		boardIdx: boIdx,
		parents: idx,
		writer: $('.commet_nick').text(),
		contents: $(locThis).parent().prev().children().val()
	};
	$.ajax({
		url: 'http://ec2-13-125-52-199.ap-northeast-2.compute.amazonaws.com:8080/mc/qna/contents/hirachy',
		type: 'post',
		data: JSON.stringify(writeData),
		dataType: 'text',
		contentType: 'application/json; charset=UTF-8',
		success: function (data) {
			if (data === "1") {
				alert('대댓글 쓰기가 완료되었습니다.');
				location.reload(true);
			}
			else if (data === "0") {
				alert('대댓글 쓰기가 실패 하였습니다. 관리자에게 문의하세요.');
				location.reload(true);
			}
		}
	});
}

//글쓰기
function qnaWriteBoard() {
	
	var qnaTitle = $('#qnaTitle').val();
	var qnaWriter = $('#qnaWriter').val();
	var qnaContent = $('#summernote').val();
	var qnaPw = $.trim($('#qnaPw').val());
	var qnaCheck = 0;
	if (qnaTitle.trim() == ''){
		alert("제목을 입력해주세요");
		return false;
	}
	if (qnaWriter.trim() == ''){
		alert("작성자를 입력해주세요");
		return false;
	}
	if (qnaContent.trim() == ''){
		alert("내용을 입력해주세요");
		return false;
	}
	if (qnaPw == null || qnaPw == ''){
		qnaCheck = 0;
	} else {
		qnaCheck = 1;
	}
	

	var writeData = {
		memberNick: qnaWriter,
		title: qnaTitle,
		contents: qnaContent,
		pw: qnaPw,
		pwCheck: qnaCheck
	};

	$.ajax({
		url: 'http://ec2-13-125-52-199.ap-northeast-2.compute.amazonaws.com:8080/mc/qna/',
		type: 'post',
		data: JSON.stringify(writeData),
		dataType: 'text',
		contentType: 'application/json; charset=UTF-8',
		success: function (data) {
			if (data === "1") {
				alert('글쓰기가 완료되었습니다.');
				location.href = '/mangh/qna/qnaBoard';
			}
			else if (data === "0") {
				alert('글쓰기가 실패 하였습니다. 관리자에게 문의하세요.');
				location.href = '/mangh/qna/qnaBoard';
			}
		}
	});
}

//답글쓰기
function qnaWriteSubmit(idx) {

	var reTitle = $('#qnaTitle').val();
	var reWriter = $('#qnaWriter').val();
	var reContent = $('#summernote').val();
	var rePw = $.trim($('#qnaPw').val());
	var qnaReCheck = 0;
	if (reTitle.trim() == ''){
		alert("제목을 입력해주세요");
		return false;
	}
	if (reWriter.trim() == ''){
		alert("작성자를 입력해주세요");
		return false;
	}
	if (reContent.trim() == ''){
		alert("내용을 입력해주세요");
		return false;
	}
	if (rePw == null || rePw == ''){
		qnaReCheck = 0;
	} else {
		qnaReCheck = 1;
	}

	var replyWriteData = {
		memberNick: reWriter,
		title: 're: ' +reTitle,
		contents: reContent,
		pw: rePw,
		pwCheck:qnaReCheck
	};

	$.ajax({
		url: 'http://ec2-13-125-52-199.ap-northeast-2.compute.amazonaws.com:8080/mc/qna/reply-board/' + idx,
		type: 'post',
		data: JSON.stringify(replyWriteData),
		dataType: 'text',
		contentType: 'application/json; charset=UTF-8',
		success: function (data) {
			if (data === "1") {
				alert('답글쓰기가 완료되었습니다.');
				location.href = '/mangh/qna/qnaBoard';
			}
			else if (data === "0") {
				alert('답글쓰기가 실패 하였습니다. 관리자에게 문의하세요.');
				location.href = '/mangh/qna/qnaBoard';
			}
		}
	});
}

/*============================================================================================================================================================*/

//비밀글 유무에 따른 게시글 이동
function qnaDetailView(pwCheck,idx){
	if(pwCheck === 0){
		location.href='contents/'+idx;
	}
	if(pwCheck === 1){
		document.getElementById('pwModal').style.display='block';
		$('#pw-check-button').click(function(){
			var pwCheckVal = $('#board-pw').val();
			qnaPwCheck(pwCheckVal, idx);
			
		})
	}
	
}
//비밀글 체크 ajax
function qnaPwCheck(pw,idx){
	
	var pwCheckData={
		idx: idx,
		pw: pw
	};
	
	$.ajax({
		url:'http://ec2-13-125-52-199.ap-northeast-2.compute.amazonaws.com:8080/mc/qna/contents/pwCheck',
		type:'POST',
		data: JSON.stringify(pwCheckData),
		dataType:'text',
		contentType: 'application/json; charset=UTF-8',
		success: function (data) {
			if(data === '0'){
				$('#modal-pw-check-message').show();
				$('#pw-check-button').removeClass('w3-margin-top');
				$('#pw-check-cansel-button').removeClass('w3-margin-top');
				$('#board-pw').val('');
			}
			if(data === '1'){
				location.reload(true);
				location.href='contents/'+idx;
			}
		}
	});
}
function pwCheckCansel(){
	//document.getElementById('pwModal').style.display='none';
	$('#pwModal').hide();
	$('#modal-pw-check-message').hide();
	$('#pw-check-button').addClass('w3-margin-top');
	$('#pw-check-cansel-button').addClass('w3-margin-top');
}

//글 수정 페이지 이동
function qnaModify(idx) {
	$.ajax({
		url: 'http://ec2-13-125-52-199.ap-northeast-2.compute.amazonaws.com:8080/mc/qna/update-board/' + idx,
		type: 'GET',
		success: function (data) {
	
			$('#qnaWriter').val(data.memberNick);
			$('#qnaTitle').val(data.title);
			$('#qnaPw').val(data.pw);
			$('#summernote').summernote('code',data.contents);
			$('#qnaTitle').focus();

			//alert('섬머노트값: ' + $('#summernote').val());
		}
	});
}

//수정 폼 전송
function qnaModifySubmit(num) {
	var writeData = {
		idx: num,
		memberNick: $('#qnaWriter').val(),
		title: $('#qnaTitle').val(),
		contents: $('#summernote').val(),
		pw: $('#qnaPw').val()
	};

	$.ajax({
		url: 'http://ec2-13-125-52-199.ap-northeast-2.compute.amazonaws.com:8080/mc/qna/update-board/' + num,
		type: 'put',
		data: JSON.stringify(writeData),
		dataType: 'text',
		contentType: 'application/json; charset=UTF-8',
		success: function (data) {
			if (data === "1") {
				alert('글 수정이 완료되었습니다.');
				location.href = '/mangh/qna/contents/' + num;
			}
			else if (data === "0") {
				alert('글 수정이 실패 하였습니다. 관리자에게 문의하세요.');
				location.href = 'contents/' + num;
			}
		}
	});
}

//댓글수정
function qnaModifyComment(mdIdx,modify) {
	var writeData = {
		contents: $(modify).parent().prev().children().val(),
		idx: mdIdx
	};
 	$.ajax({
		url: 'http://ec2-13-125-52-199.ap-northeast-2.compute.amazonaws.com:8080/mc/qna/contents/',
		type: 'put',
		data: JSON.stringify(writeData),
		dataType: 'text',
		contentType: 'application/json; charset=UTF-8',
		success: function (data) {
			if (data === "1") {
				alert('댓글 수정이 완료되었습니다.');
				location.reload(true);
			}
			else if (data === "0") {
				alert('댓글 수정에 실패 하였습니다. 관리자에게 문의하세요.');
				location.reload(true);
			}
		}
	});
}

/*============================================================================================================================================================*/

//댓글삭제
function commentDelete(idx) {

	var deleteData = confirm('정말 삭제하시겠습니까?');

	if (deleteData === true) {
		$.ajax({
			url: 'http://ec2-13-125-52-199.ap-northeast-2.compute.amazonaws.com:8080/mc/qna/contents/' + idx,
			type: 'DELETE',
			success: function (data) {
				if (data === 0) {
					alert('삭제에 실패하였습니다. 관리자에게 문의하세요.');
					location.reload(true);
				} else if (data === 1) {
					alert('게시글을 성공적으로 삭제하였습니다.');
					location.reload(true);
				}
			}
		});
	}
}

//게시글 삭제
function qnaDelete(idx) {

	var deleteData = confirm('정말 삭제하시겠습니까?');

	if (deleteData === true) {
		$.ajax({
			url: 'http://ec2-13-125-52-199.ap-northeast-2.compute.amazonaws.com:8080/mc/qna/' + idx,
			type: 'DELETE',
			success: function (data) {
				if (data === 0)
					alert('삭제에 실패하였습니다. 관리자에게 문의하세요.');
				else if (data === 1)
					alert('게시글을 성공적으로 삭제하였습니다.');
				location.href = '/mangh/qna/qnaBoard';
			}
		});
	}
}

$(document).ready(() => {
	
	//검색 버튼 클릭 이벤트
	$('#SearchButton').on('click',() => {
		this.keyword = $('#keyword').val();
		this.searchType = $('#searchType').val();
		qnaboardList();
	});
	

	//비밀번호 모달창 외부클릭 닫기 이벤트
	//Get the modal
	var pwModal = document.getElementById('pwModal');

	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
		if (event.target == pwModal) {
			pwModal.style.display = "none";
			$('#modal-pw-check-message').hide();
			$('#pw-check-button').addClass('w3-margin-top');
			$('#pw-check-cansel-button').addClass('w3-margin-top');
		}
	}
	//모달 비밀번호 체크 메세지 비활성화
	$("#modal-pw-check-message").hide();
});

