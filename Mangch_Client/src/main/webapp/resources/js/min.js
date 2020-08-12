function memberList() {
		
		$.ajax({
			url: 'http://localhost:8080/mc/qna/qna' ,
			type: 'get',
			success: function(data){
				// alert(JSON.stringify(data));
				
				// $('#QnABoardList').html(JSON.stringify(data));
				
				var html = '';
				html += '<div class="card">';
				html += '	<table>';
				html += '		<th>번호</th>';
				html += '		<th>제목</th>';
				html += '		<th>작성자</th>';
				html += '		<th>작성일</th>';
				html += '		<th>조회</th>';
				for(var i=0; i<data.length; i++){
					html += '		<tr>';
					html += '			<td>글번호 : '+data[i].idx+'</td>';
					html += '			<td>제목 : <a href="#">'+data[i].title+'</a></td>';
					html += '			<td>닉네임 : '+data[i].memNick+'</td>';
					html += '			<td>작성일 : '+data[i].regdate+'</td>';
					html += '			<td>조회수 :'+data[i].count+'</td>';
					html += '		</tr>';
				}
				html += '	</table>';
				html += '</div>';
				$('#QnABoardList').html(html);
				
			} 
		});
	}
	
	
$(document).ready(function(){

	memberList();
});