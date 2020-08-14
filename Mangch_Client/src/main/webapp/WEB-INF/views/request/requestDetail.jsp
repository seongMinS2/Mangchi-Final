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

td {
	padding: 5px;
}

#detailReq {
	padding: 5%;
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
				<div class="w3-cell" id="reqInfo">
					<h1 id="info_h1"></h1>
					<div id="reqInfo"></div>
				</div>

				<!-- 요청자 정보 -->
				<div class="w3-cell" id="mInfo">
					<h1 id="writer_h1"></h1>
					<div id="wirterInfo">

						<table>
							<tr>
								<td>회원 닉네임</td>
								<td id="mNick"></td>
							</tr>
							<tr>
								<td>회원 평점</td>
								<td>${loginInfo.mScore}</td>
							</tr>
						</table>


					</div>
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

function chat(reqIdx,uNick){

	//로그인 안했을 때 
	if('${loginInfo}' != ''){
		
		//채팅하기로 링크 이동 ------------------------		
		//location.href="/mangh/chat?reqIdx="+reqIdx+"&uNick="+uNick; 
	
		 var timer = setInterval(function(){
        console.log("Hello!!");
   		 }, 1000);
		
	
	}else{
		alert('로그인 후 이용해주세요.');
	 location.href="/mangh/member/loginForm"; 
		
	}
}

function reqEdit(reqIdx){
	
	location.href="/mangh/request/edit?reqIdx="+reqIdx;
	
}
function reqDelete(reqIdx){
	
	//로그인 안했을 때 
	if('${loginInfo}' != ''){
		
		if(confirm("정말로 삭제하시겠습니까?") == true){
			
			 $.ajax({
				url : 'http://localhost:8080/rl/request/'+reqIdx,
				type : 'DELETE',
				success : function(data) {
					var message = '';
					if(data > 0 ){
						message = "게시글이 정상적으로 삭제되었습니다.";
					}else {
						message = "게시물을 삭제 할 수 없습니다.";
					}
					alert(message);
					location.href="/mangh/request/requestList";
				}
			 
				
			});
			
		}	
	}else{
		alert('로그인 후 이용해주세요.');
	 location.href="/mangh/member/loginForm"; 
		
	}
	
	

	
}

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
			$('#mNick').text(data.reqWriter);
			
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
			
			var status = '';
			var color = '';
			if(data.reqStatus == 0){
				status = '대기중';
				color = 'red';
			}else if(data.reqStatus == 1){
				satus = '요청 완료';
				color = 'gray';
			}
			html += '<tr>';
			html +='	<td>매칭 상태</td>';
			html +='	<td style="color: '+color+'">';
			html +='		'+status+'';
			html +='	<button onclick="chat('+data.reqIdx+',\''+data.reqWriter +' \')">매칭하기</button>';
			html += '	</td>';
			//수정, 삭제
			html += '<td><button onclick="reqEdit('+data.reqIdx+')">수정</button></td>';
			html += '<td><button  onclick="reqDelete('+data.reqIdx+')">삭제</button></td>';
			html += '</tr>';
			
			html += '<tr style="display: none;">';
			html +='<td>이미지 경로</td>';
			html +=	'	<td id="imgPath">'+data.reqImg+'</td>';
			html += '</tr>';
			
			html +=	'</table>';	
			
			$('#reqInfo').append(html);
			
			
			//요청 게시글 내용 
			var content = ''+data.reqContents;
			$('#req_contents').append(content);
			
			
		}
	
		
	}); 
	 
});
	
</script>

</body>
</html>