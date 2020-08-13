<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.12.4.js"></script>

<style>
#info {
	/* border: 3px solid #DDD; */
}



li {
	float: left;
	list-style: none;
}
#reqest, #writer{
	
}
</style>

</head>
<body>

	<jsp:include page="/WEB-INF/views/include/header.jsp" />


	<div class="w3-container w3-margin-bottom " id="contents">
		<h1 class="w3-center" id="title"></h1>

		<div class="w3-border w3-margin-top" id="detailReq">

			<!-- 1 -->
			<div class="w3-cell-row" id="info">

				
						<!-- 요청 게시글 상세 정보 -->
						<div  class="w3-cell">
							<h1 id="info_h1"></h1>
							<div  id="reqInfo"></div>
						</div>
			
						<!-- 요청자 정보 -->
						<div  class="w3-cell">
							<h1 id="writer_h1"></h1>
							<div id="wirterInfo"></div>
						</div>
			</div>

			<!-- 지도 -->
			<div class="w3-cell-row" id="mapContent">
				<hr>
				<h1>지도</h1>
				<div id="map">요청자 위치 지도</div>
			</div>

			<hr>

			<!-- 상세내용 -->
			<div class="w3-cell-row">
				<h1 id="content_h1">상세 내용</h1>
				<div id="req_contents"></div>
			</div>

		</div>
	</div>


	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<script>

$(document).ready(function(){
	
	
	$.ajax({
		
		url : 'http://localhost:8080/rl/request/'+${idx},
		type : 'GET',
		success : function(data){
			
			var title=data.reqTitle;
			$('#title').text(title);
			$('#info_h1').text('요청 내용 ');
			$('#writer_h1').text('요청자 정보');
			$('#content_h1').text('상세내용');
			
		//요청 게시글 상세 정보
		var html =	'<table>';
			html += '<tr>';
			html +=	'	<td>요청자</td>';
			html +=	'<td>'+data.reqWriter+'</td>';
			html += '</tr>';
			
			html += '<tr>';
			html +=	'	<td>요청자위치</td>';
			html +=	'	<td>'+data.reqAddr+'</td>';
			html += '</tr>';
			
			html += '<tr>';
			html +=	'	<td>등록일</td>';
			html +=	'	<td>'+data.reqDateTime+'</td>';
			html += '</tr>';
			
			html += '<tr>';
			html	+='<td>조회수</td>';
			html+=	'	<td>'+data.reqCount+'</td>';
			html += '</tr>';
			
			html += '<tr>';
			html +='	<td>매칭 상태</td>';
			html +='	<td>';
			html +='		'+data.reqStatus+'';
			html +='	<button>매칭하기</button>';
			html += '	</td>';
			html += '</tr>';
			
			html +=	'</table>';	
			
			$('#reqInfo').append(html);
			
			
			//회원 정보 출력
			var member = '';
			
			$('#wirterInfo').append(member);	
			
			
			//요청 게시글 내용 
			var content = ''+data.reqContents;
			$('#req_contents').append(content);
			
			
		}
		
	}); 
	
	
	
});
	
</script>

</body>
</html>