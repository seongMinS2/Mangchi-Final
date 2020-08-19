<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>
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
								<td>${loginInfo.mScore}
								</td>
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



	
//매칭 취소 버튼 삭제
setTimeout(function() { 
		$('#cancel').remove();
}, 5000);

	
//채팅하기 	
function chat(reqIdx,uNick){

	//로그인 체크
	if('${loginInfo}' != ''){
		//채팅하기로 링크 이동 ------------------------		
		location.href="/mangh/chat?reqIdx="+reqIdx+"&uNick="+uNick; 
	}else{
		alert('로그인 후 이용해주세요.');
	 location.href="/mangh/member/memberLogin"; 
	}
}

//매칭 완료 버튼 
function complete(){
	
	
 	$.ajax({
 		url : 'http://localhost:8080/rl/request/'+ ${idx},
		 type : 'PUT',
		 success : function(data){
				alert('1');
		 }
		 
	 });
	
}

//매칭 취소 버튼
function cancel(reqStatus){
	
	//로그인한 사용자가 취소 버튼을 누르면 DB 업데이트
	if(confirm('매칭을 취소하겠습니까?') == true){

		 $.ajax({
			 url : 'http://localhost:8080/rl/request/'+ ${idx},
			 type : 'PUT',
			 success : function(data){
				 alert('매칭이 취소되었습니다.');
				 history.go(0);
			 }
			 
		 });	
	}	 
}




//리뷰 작성 
function review(reqIdx,reqWriter,reqHelper){
		
	 $.ajax({
		 url : 'http://localhost:8080/rl/review/'+ '${loginInfo.mNick}',
		 type : 'post',
		 success : function(data){
			
			 if(data.writer == '${loginInfo.mNick}'){
				 alert('리뷰를 작성했습니다.');
			 }else{
				 var form = $('<form></form>');
				    form.attr('action', '/mangh/review/reviewForm');
				    form.attr('method', 'post');
				    form.appendTo('body');
				    var reqIdx = $("<input type='hidden' value="+reqIdx+" name='reqIdx'>"); //게시글 번호
				    var reqWriter = $("<input type='hidden' value="+reqWriter+" name='reqWriter'>"); //글쓴이
				    var reqHelper = $("<input type='hidden' value="+reqHelper+" name='reqHelper'>"); //로그인 한 사용자  
				    form.append(reqIdx);
				    form.append(reqWriter);
				    form.append(reqHelper);
				    form.submit();
			 }
			 
		 }
		 
	 }); 
		
	
}



//글 수정
function reqEdit(reqIdx){
	
	location.href="/mangh/request/edit?reqIdx="+reqIdx;
	
}

//글 삭제
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
	}
	
}


$(document).ready(function(){
	
	
	$.ajax({
		
		url : 'http://localhost:8080/rl/request/'+${idx},
		type : 'GET',
		data : {
			count : ${count}
		},
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
			
			html += '<tr>';
			html	+='<td>거리</td>';
			
			if ('${loginInfo}' != '') {
				if( ${distance} >= 1000){
					var calDistance = ${distance};
					calDistance = (Math.round(calDistance/100))/10;
					html += ' <td>' + calDistance + ' km</td>';
				}else{
					html += '	<td>'+${distance}+'Km</td>';
				}	
				
				}
			
			
			
			
			html += '</tr>';
			
			var status,color;
			if(data.reqStatus == 0){
				status = '대기중';
				color = 'red';
			}else if(data.reqStatus == 1){
				status = '요청 완료';
				color = 'gray';
			}
			
			html += '<tr>';
			html +='	<td>매칭 상태</td>';
			html +='	<td style="color: '+color+'">';
			html +='		'+status+'';
			html += '	</td>';
				
			
			//로그인 한 사용자가 요청자 일 때 
			if('${loginInfo.mNick}' == data.reqWriter){
				
				if(data.reqStatus == 1){
					html +='	<td id="canceltd"><button onclick="cancel('+data.reqStatus+')" id="cancel">매칭취소</button></td>';
					html += '	<td><button onclick="review('+data.reqIdx+',\''+data.reqWriter +' \' ,\' '+data.reqHelper+' \')">리뷰작성</button></td>';
					//수정, 삭제
					html += '	<td><button onclick="reqEdit('+data.reqIdx+')">수정</button></td>';
					html += '	<td><button  onclick="reqDelete('+data.reqIdx+')">삭제</button></td>';
				} else if(data.reqStatus == 0){
					html +='	<td id="canceltd"><button onclick="complete()">매칭완료</button></td>';
				}
			}
	
			//로그인 한 회원이 수행자 일 때 
			else if('${loginInfo.mNick}' == data.reqHelper){
				if(data.reqStatus == 1){
					html += '	<td id="review" ><button onclick="review('+data.reqIdx+',\''+data.reqWriter +' \' ,\' '+data.reqHelper+' \')">리뷰작성</button></td>';
				}
				
			}
			
			//로그인 한 사용자가 요청자도 수행자도 아닐 때 
			else if('${loginInfo.mNick}' != data.reqHelper && '${loginInfo.mNick}' != data.reqWriter){
				if(data.reqStatus == 0){
					html +='	<td><button onclick="chat('+data.reqIdx+',\''+data.reqWriter +' \')" id="chat">매칭하기</button></td>';
				}
				
			}
			
			 //비회원 일 때
			else if('${loginInfo}' == ''){		
				if(data.reqStatus == 0){
					html +='	<td><button onclick="chat('+data.reqIdx+',\''+data.reqWriter +' \')" id="chat">매칭하기</button></td>';
				}
			} 
			html += '</tr>';

			
	 		html +='<tr>';
			html += '<td>';
			html += '	<img src="http://localhost:8080/rl/upload/'+data.reqImg+'" style="width: 50%"> ';
			html += '</td>';
			html +='</tr>'; 
			
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