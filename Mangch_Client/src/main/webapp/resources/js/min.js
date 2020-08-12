function memberList() {
		
		$.ajax({
			url: 'http://localhost:8080/mc/qna/qna' ,
			type: 'get',
			success: function(data){
				console.log(JSON.stringify(data));
				
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
					html += '			<td class="w3-padding-16"><a href="contents">'+data[i].title+'</a></td>';
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
	
	function contentsList() {
		
		$.ajax({
			url: 'http://localhost:8080/mc/qna/qna' ,
			type: 'get',
			success: function(data){
				console.log(JSON.stringify(data));
				
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
					html += '			<td class="w3-padding-16"><a href="contents">'+data[i].title+'</a></td>';
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
	
	
$(document).ready(function(){

	memberList();
});