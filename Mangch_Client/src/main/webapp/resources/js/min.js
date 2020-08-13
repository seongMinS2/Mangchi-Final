function memberList() {
		
		$.ajax({
			url: '/mc/qna/',
			type: 'get',
			success: function(data){
				//console.log(JSON.stringify(data));
				
				// $('#QnABoardList').html(JSON.stringify(data));
				
				var html = '';
				html += '<div class="w3-table">';
				html += '	<table>';
				html += '		<th class="w3-center w3-padding-16">번호</th>';
				html += '		<th class="w3-padding-16">제목</th>';
				html += '		<th class="w3-center w3-padding-16">작성자</th>';
				html += '		<th class="w3-center w3-padding-16">작성일</th>';
				html += '		<th class="w3-center w3-padding-16">조회</th>';
				for(var i=0; i<data.length; i++){
					html += '		<tr>';
					html += '			<td class="w3-center w3-padding-16">'+data[i].idx+'</td>';
					html += '			<td class="w3-padding-16"><a href="contents/'+data[i].idx+'">'+data[i].title+'</a></td>';
					html += '			<td class="w3-center w3-padding-16">'+data[i].memNick+'</td>';
					html += '			<td class="w3-center w3-padding-16">'+data[i].regdate+'</td>';
					html += '			<td class="w3-center w3-padding-16">'+data[i].count+'</td>';
					html += '		</tr>';
				}
				html += '	</table>';
				html += '</div>';
				$('#QnABoardList').html(html);
				
			} 
		});
	}
	
	function contentsList(idx) {
		
		$.ajax({
			url: 'http://localhost:8080/mc/qna/contents/'+idx ,
			type: 'get',
			success: function(data){
				console.log(JSON.stringify(data));
				
				//$('.contentBox').html(JSON.stringify(data));
				
				var html = '';
				html += '<div class="header">';
				html += '	<h1>'+data.title+'</h1>';
				html += '</div>';
				html += '	<div class="articleContainer">';
				html += '		<div class="mainContainer">';
				html += '			<p class="text">'+data.contents+'</p>';
				html += '		</div>';
				html += '			<div class="commentBox">';
				html += '			<h3 class="comment_title">';
				html += '				<b>댓글</b>';
				html += '			</h3>';
				html += '				<div class="comment_area">';
				html += '					<div class="comment_Box">';
				html += '						<div class="comment_nickBox">댓글 유저 닉네임 들어갈 자리</div>';
				html += '						<div class="comment_textView">댓글 텍스트 들어갈자리</div>';
				html += '						<div class="comment_info_box">';
				html += '							<span class="comment_info_date"> 날짜정보들어갈 자리 </span> <a href="#">답글쓰기</a>';
				html += '						</div>';
				html += '					</div>';
				html += '					</div>';
				html += '				<div class="commentWriter">';
				html += '					<div class="comment_inbox">';
				html += '						<div class="comment_inbox_name">';
				html += '							<p>닉네임 자리</p>';
				html += '							<i class="xi-ellipsis-v"></i>';
				html += '						</div>';
				html += '						<div class="comment_inbox_text">';
				html += '							<p>댓글 쓸 내용 들어갈 자리</p>';
				html += '						</div>';
				html += '						<div class="comment_submit">';
				html += '							<button">등록</button>';
				html += '						</div>';
				html += '					</div>';
				html += '				</div>';
				html += '			</div>';
				html += '		</div>';
				html += '	</table>';
				html += '	<div class="articleBottomBtns">';
				html += '		<button">글쓰기</button>';
				html += '		<button">답글</button>';
				html += '		<button=">TOP</button>';
				html += '	</div>';
				html += '</div>';
				$('.contentBox').html(html);
				
			} 
		});
	}
	
	