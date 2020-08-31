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
	console.log('페이지번호 클릭시' + idx);
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
	alert(keyword + searchType);

	$.ajax({
		url: '/mc/qna/?idx='+idx+'&keyword='+keyword+'&searchType='+searchType,
		type: 'get',
		success: function (data) {
			console.log(JSON.stringify(data));
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
				//게시글 부모 컬럼이 0일때(i번째 글)
				if (data.boardList[i].parents === 0) {
					html += '		<tr>';
					html += '			<td class="w3-center w3-padding">' + data.boardList[i].idx + '</td>';
					html += '			<td class="w3-padding w3-border-left w3-border-white w3-hover-border-theme"><a class="qna-board-title" href="contents/' + data.boardList[i].idx + '">' +data.boardList[i].title + '</a></td>';
					html += '			<td class="w3-center w3-padding">' + data.boardList[i].memNick + '</td>';
					html += '			<td class="w3-center w3-padding">' + moment(data.boardList[i].regdate).format('YY년MM월DD일') + '</td>';
					html += '			<td class="w3-center w3-padding">' + data.boardList[i].count + '</td>';
					html += '		</tr>';
				}
				//i번째 글의 자식 글을 찾아 출력
				for (var j = 0; j < data.boardList.length; j++) {
					if (data.boardList[j].parents === data.boardList[i].idx) {
						html += '		<tr>';
						html += '			<td class="w3-center w3-padding">' + data.boardList[j].idx + '</td>';
						html += '			<td class="w3-padding w3-border-left w3-border-white w3-hover-border-theme"><a href="contents/' + data.boardList[j].idx + '">' + data.boardList[j].title + '</a></td>';
						html += '			<td class="w3-center w3-padding">' + data.boardList[j].memNick + '</td>';
						html += '			<td class="w3-center w3-padding">' + moment(data.boardList[j].regdate).format('YY년MM월DD일') + '</td>';
						html += '			<td class="w3-center w3-padding">' + data.boardList[j].count + '</td>';
						html += '		</tr>';
					}
				}
			}
			html += '	</table><br><br>';
			//페이징 처리 부분
			html += '		<div class="w3-bar w3-small w3-center">';
			html += '			<a href="#" class="w3-button" onclick="return firstPage()"><<</a>';
			html += '			<a href="#" class="w3-button" onclick="return prevPage()"><</a>';
			for(var i=data.startPage; i<=data.endPage; i++){
				html += '			<a href="#" class="w3-button" onclick="return pageNum('+i+')">'+i+'&nbsp;</a>';
			}
			html += '			<a href="#" class="w3-button" onclick="return nextPage('+data.endPage+')">></a>';
			html += '			<a href="#" class="w3-button" onclick="return endPage('+data.endPage+')">>></a>';
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
	
//게시물 출력 회원
function contentsList(idx, loginSession) {
	$.ajax({
		url: '/mc/qna/contents/' + idx,
		type: 'get',
		success: function (data) {
			console.log(JSON.stringify(data));
			//$('.contentBox').html(JSON.stringify(data));

			var html = '';
			html += '<div class="header">';
			html += '	<h1 id="qna-header">' + data.title + '</h1>';
			html += '</div>';
			html += '	<div class="articleContainer">';
			html += '		<div class="mainContainer">';
			html += '			<p class="text">' + data.contents + '</p>';
			html += '		</div>';
			html += '			<div class="commentBox">';
			html += '			<h3 class="comment_title">';
			html += '				<b>댓글</b>';
			html += '			</h3>';
			//댓글
			for (var i = 0; i < data.comment.length; i++) {
				//댓글 부모 컬럼이 0일때(i번째 댓글)
				if (data.comment[i].parents === 0) {
					html += '				<div class="comment_area">';
					html += '					<div class="comment_Box">';
					if(loginSession!=null)
					html += '						<div class="comment_tool"><i class="xi-ellipsis-v"></i>';
					html += '						<div class="layerMore w3-card-2"><a href="#" class="modify_button">수정</a><br><a href="#" onclick="commentDelete(' + data.comment[i].idx + ')">삭제</a></div>';
					html += '						</div>';
					html += '						<div class="comment_nick_box">' + data.comment[i].writer;
					html += '						</div>';
					html += '						<div class="comment_text_box">' + data.comment[i].contents + '</div>';
					html += '						<div class="comment_info_box">';
					html += '							<span class="comment_info_date"> ' + moment(data.comment[i].regdate).format('YYYY.MM.DD, HH:mm') + ' </span>';
					//비회원 대댓글 toggle button 제한
					if(loginSession!=null)
						html += '						 <button class="comment_reply_button w3-button w3-theme-l1">답글쓰기</button>';
						html += '					</div>';
						html += '				</div>';
						html += '			</div>';
					//비회원 대댓글 쓰기 제한
					if(loginSession!=null){
						html += '			<div class="comment_reply">';
						html += '				<div class="commentWriter">';
						html += '					<div class="comment_inbox">';
						html += '						<div class="comment_inbox_name">';
						html += '							<p class="commet_comment_nick">' + loginSession.mNick + '</p>';
						html += '						</div>';
						html += '						<div class="comment_inbox_text">';
						html += '							<textarea cols="50" class="comment_insert"></textarea>';
						html += '						</div>';
						html += '						<div class="comment_submit">';
						html += '							<button class="w3-button w3-theme-l1" onclick="writeHirachyComment(' + idx +','+ data.comment[i].idx +',this)">등록</button>';
						html += '						</div>';
						html += '					</div>';
						html += '				</div>';
						html += '			</div>';
						//수정일시 보여줄 뷰 
						html += '			<div class="comment_reply_modify">';
						html += '				<div class="commentWriter">';
						html += '					<div class="comment_inbox">';
						html += '						<div class="comment_inbox_name">';
						html += '							<p class="commet_comment_nick">' + loginSession.mNick + '</p>';
						html += '						</div>';
						html += '						<div class="comment_inbox_text">';
						html += '						<textarea cols="50" class="comment_insert">'+data.comment[i].contents+'</textarea>';
						html += '						</div>';
						html += '						<div class="comment_submit">';
						html += '							<button class="comment_modify_cancel w3-button w3-theme-l4">취소</button>';
						html += `							<button class="w3-button w3-theme-l1" id="modifySub" onclick="qnaModifyComment(${data.comment[i].idx},this)">등록</button>`;
						html += '						</div>';
						html += '					</div>';
						html += '				</div>';
						html += '			</div>';
					}
				}
				//i번째 댓글의 자식 댓글(대댓글)을 찾아 출력
				for (var j = 0; j < data.comment.length; j++) {
					if (data.comment[j].parents === data.comment[i].idx) {
						html += '			<div class="comment_coment_area">';
						html += '				<div class="comment_Box w3-row">';
						if(loginSession!=null)
						html += '					<div class="comment_tool"><i class="xi-ellipsis-v"></i>';
						html += '					<div class="layerMore w3-card-2"><a href="#" class="modify_button">수정</a><br><a href="#" onclick="commentDelete(' + data.comment[j].idx + ')">삭제</a></div>';
						html += '					</div>';
						html += '					<div class="comment_nick_box">' + data.comment[i].writer;
						html += '					</div>';
						html += '					<div class="comment_textView">대댓글 :' + data.comment[j].contents + '</div>';
						html += '					<div class="comment_info_box">';
						html += '						<span class="comment_info_date"> ' + moment(data.comment[j].regdate).format('YYYY.MM.DD, HH:mm') + '</span>';
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
							html += '				<div class="comment_inbox">';
							html += '					<div class="comment_inbox_name">';
							html += '						<p class="commet_comment_nick">' + loginSession.mNick + '</p>';
							html += '					</div>';
							html += '					<div class="comment_inbox_text">';
							html += '					<textarea class="comment_insert"></textarea>';
							html += '					</div>';
							html += '					<div class="comment_submit">';
															//댓글쓰기 요청
							html += '						<button class="w3-button w3-theme-l1" onclick="writeHirachyComment(' + idx +','+ data.comment[j].idx +',this)">등록</button>';
							html += '					</div>';
							html += '				</div>';
							html += '			</div>';
							html += '		</div>';
							//수정일시 보여줄 뷰 
							html += '		<div class="comment_reply_modify">';
							html += '			<div class="commentWriter">';
							html += '				<div class="comment_inbox">';
							html += '					<div class="comment_inbox_name">';
							html += '						<p class="comment_nick">' + loginSession.mNick + '</p>';
							html += '					</div>';
							html += '					<div class="comment_inbox_text">';
							html += '					<textarea cols="50" class="comment_insert">'+data.comment[j].contents+'</textarea>';
							html += '					</div>';
							html += '					<div class="comment_submit" id="submit">';
							html += '						<button class="comment_modify_cancel w3-button w3-theme-l4">취소</button>';
							html += `						<button class="w3-button w3-theme-l1" id="modifySub" onclick="qnaModifyComment(${data.comment[j].idx},this)">등록</button>`;
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
			html += '						<div class="commentWriter">';
			html += '							<div class="comment_inbox">';
			html += '								<div class="comment_inbox_name">';
			html += '									<p class="commet_nick">' + loginSession.mNick + '</p>';
			html += '								</div>';
			html += '								<div class="comment_inbox_text">';
			html += '									<textarea cols="50" class="comment_insert"></textarea>';
			html += '								</div>';
			html += '								<div class="comment_submit">';
			html += '									<button class="w3-button w3-theme-l1" onclick="qnaWritComment(' + idx + ')">등록</button>';
			html += '								</div>';
			html += '							</div>';
			html += '						</div>';
			}
			html += '					</div>';
			html += '				</div>';
			html += '			</table>';
			html += '			<div class="articleBottomBtns">';
				//로그인 한 회원만 수정/답글이 가능
				if(loginSession != null){
					html += '		<a class="w3-button w3-right w3-theme-l4" href="#">TOP</a>';
					html += '<a class="w3-button w3-right w3-theme-l4" href="/mangh/qna/reply-board/' + idx + '">답글쓰기</a>';
					//로그인 한 회원과 게시글의 작성자가 같아야 수정이 가능
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
				a.next().toggle();
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
		url: '/mc/qna/contents/',
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
		url: '/mc/qna/contents/hirachy',
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

	// var regFormData = new FormData();
	// regFormData.append('memberNick', $('#qnaWriter').val());
	// regFormData.append('title', $('#qnaTitle').val());
	// regFormData.append('contents', $('#summernote').val());
	// regFormData.append('pw', $('#qnaPw').val());

	var writeData = {
		memberNick: $('#qnaWriter').val(),
		title: $('#qnaTitle').val(),
		contents: $('#summernote').val(),
		pw: $('#qnaPw').val()
	};

	$.ajax({
		url: '/mc/qna/',
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

	// var regFormData = new FormData();
	// regFormData.append('memberNick', $('#qnaWriter').val());
	// regFormData.append('title', $('#qnaTitle').val());
	// regFormData.append('contents', $('#summernote').val());
	// regFormData.append('pw', $('#qnaPw').val());

	var writeData = {
		memberNick: $('#qnaWriter').val(),
		title: '답글: ' + $('#qnaTitle').val(),
		contents: $('#summernote').val(),
		pw: $('#qnaPw').val()
	};

	$.ajax({
		url: '/mc/qna/reply-board/' + idx,
		type: 'post',
		data: JSON.stringify(writeData),
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

//글 수정 페이지 이동
function qnaModify(idx) {
	$.ajax({
		url: '/mc/qna/update-board/' + idx,
		type: 'GET',
		success: function (data) {
			$('#qnaWriter').val(data.memberNick);
			$('#qnaTitle').val(data.title);
			$('#qnaPw').val(data.pw);
			$('#summernote').summernote('insertText', data.contents);
			$('#qnaTitle').focus();

			//console.log('섬머노트값: ' + $('#summernote').val());
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
		url: '/mc/qna/update-board/' + num,
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
		url: '/mc/qna/contents/',
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
			url: '/mc/qna/contents/' + idx,
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
			url: '/mc/qna/' + idx,
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
});

