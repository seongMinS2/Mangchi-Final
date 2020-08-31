<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.12.4.js"></script>

<style>

li {
	float: left;
	list-style: none;
}

td {
	padding: 5px;
	width: 150px;
}

/* css */

#tbox{
	padding: 30px 0px 0px 0px;
}

#title{
	display:inline;
}

#chat_Box{
    display: inline;
    float: right;
}
#chat{
	height: 50px;
    width: 107px;
    text-align: center;
    background-color: #FFD201;
    border-radius: 5px;
    border: 1px solid #f7f7f7;
}
#mInfo{
	margin-left: 30%;
}
#mNick{
	border-left: 2px solid #DDD;
   padding-left: 16px;
    font-size: 16px;
}
#mImg{
	width: 58px;
    height: 58px;
    border-radius: 50%;
}


</style>

</head>
<body>
	
	<jsp:include page="/WEB-INF/views/include/header.jsp" />


		
		<div class="w3-content" id="tbox">
			<h1 id="title"></h1>
			<div id="chat_Box"> </div>
			<hr>
		</div>
		
			
	<div class="w3-content w3-margin-bottom" >
					

			<!-- 1 -->
			<div class="w3-cell-row">

				
					<!-- 요청 게시글 상세 정보 -->
					<div class="w3-cell" id="reqInfo">
						<h3 id="info_h3"></h3>
						<div id="reqInfo"></div>
					</div>
		
					<!-- 요청자 정보 -->
					<div id="mInfo">
						<!-- <h3 id="writer_h3"></h3> -->
						<span>
						<img id="mImg" src="http://localhost:8080/rl/upload/34743447620100_image1.jpg">
						</span>
						
						
						<h6>요청자 이름</h6>
						<span id="mNick"></span>
						
						
						<h6>요청자 평점</h6>
						<span id="mAvg"></span>
						
					</div>
	
			</div>

			<!-- 지도 -->
			<!-- <div class="w3-cell-row" id="mapContent">
				<hr>
				<h1>지도</h1>
				<div id="map">요청자 위치 지도</div>
			</div> -->

			<hr>

			<!-- 상세내용 -->
			<div class="w3-cell-row">
				<h3 id="content_h3"></h3>
				<div id="req_contents"></div>
			</div>

	</div>

	<div class="w3-modal" id="modal"></div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

	<script>

	
//매칭 취소 버튼 삭제

<%Cookie[] cookies = request.getCookies();
int cancelStatus = 0;
for (int i = 0; i < cookies.length; i++) {
	if (cookies[i].getName().equals("cancelStatus")) {
		cancelStatus = 1;
	}
}%>

var cancelStatus = <%=cancelStatus%>;
//취소 버튼 삭제

//채팅하기 	
function chat(reqIdx,uNick){

	//로그인 체크
	if('${loginInfo}' != ''){
		//채팅하기로 링크 이동 ------------------------		
		location.href="/mangh/chat?reqIdx="+reqIdx+"&uNick="+uNick; 
		
		/*  var form = $('<form></form>');
		    form.attr('action', '/mangh/chat');
		    form.attr('method', 'post');
		    form.appendTo('body');
		    var idx = $("<input type='hidden' value="+reqIdx+" name='reqIdx'>"); //게시글 번호
		    var mNick = $("<input type='hidden' value="+uNick+" name='uNick'>"); //게시글 상태 
		    form.append(idx);
		    form.append(mNick);
		    form.submit();  */
		
		
		
	}else{
		alert('로그인 후 이용해주세요.');
	 location.href="/mangh/member/memberLogin"; 
	}
}

//모달 닫기
function modalClose(){
	$('#modal').css('display','none');
}

//매칭 상대 정하기
function complete(){
	$('#modal').css('display','block');
	
	 $.ajax({
 		//url : 'http://ec2-15-164-228-147.ap-northeast-2.compute.amazonaws.com:8080/rl/chat/complete/'+ ${idx},
 		url : 'http://localhost:8080/rl/chat/complete/'+ ${idx},
		 type : 'get',
		 success : function(data){ 
			 
		 		var html = '<div class="w3-modal-content">';
				html += '	 <header class="w3-container">';
				html += '  		<span onclick="modalClose('+')" class="w3-button w3-display-topright">&times;</span>'; 
				html += '  		<h2>Modal Header</h2>';
				html += ' 	</header>';
				html += '		<div class="w3-container">';
				
				 if(data.length <= 0 ){
					html +='<div>매칭 상대가 없습니다.</div>';
				}else {
		 			for(var i=0;i<data.length;i++){ //채팅을 요청한 사람  
						html += ' 			<div onclick="updateHelper( \''+data[i].helper+'\', \''+data[i].writer+'\' )">'+data[i].helper+'</div>';
		 			}
		 		} 
				//html += ' 			<div onclick="updateHelper(\''+helper+'\', \''+writer+'\') ">'+helper+'</div>';
				html += ' 		</div>';
		 		html += "</div>";
					 		
		 		$('#modal').html(html);
	 	 }
	 }); 
}

//매칭 완료 데이터 업데이트
function updateHelper(helper,writer){
	
	if(confirm(helper+"님을 선택하시겠습니까?") == true){
		
		//매칭 완료 시 쿠키 생성 				
		$.ajax({
//			url : 'http://ec2-15-164-228-147.ap-northeast-2.compute.amazonaws.com:8080/rl/chat/'+${idx},
			url : 'http://localhost:8080/rl/chat/'+${idx},
			type : 'get',
			data : {
				helper : helper,
				writer : writer,
				mNick : '${loginInfo.mNick}',
			},
			success : function(data){
				if(data == -1){
					alert('동일한 매칭 상대입니다. 다른 상대를 선택하세요.');
				}else if( data == 2){
					alert('매칭이 완료되었습니다.');
					location.href= "/mangh/makeCookie?idx="+${idx}+"&distance="+${distance}+"&count="+${count};
					modalClose();
				}
			}
			
		});
	}
}



//매칭 취소 버튼
function cancel(reqStatus){
		
	if(cancelStatus == 0){
		alert('취소 불가능합니다.');
		history.go(0);
	} else {
	
	//로그인한 사용자가 취소 버튼을 누르면 DB 업데이트
	if(confirm('매칭을 취소하겠습니까?') == true){
	
		 $.ajax({
//			 url : 'http://ec2-15-164-228-147.ap-northeast-2.compute.amazonaws.com:8080/rl/request/'+ ${idx},
			 url : 'http://localhost:8080/rl/request/'+ ${idx},
			 type : 'PUT',
			 success : function(data){
				 alert('매칭이 취소되었습니다.');
				 history.go(0);
			 }
			 
		 });	
	}	 
	
	}
}




//리뷰 작성 
function review(reviewWriter,reviewStatus){
	
	 if(reviewStatus == 1){
		 alert('이미 리뷰가 작성되었습니다.');
	 }else if(reviewStatus == 0){
		 
		 //상대방 선택 하기 
		  $.ajax({
	 		//url : 'http://ec2-15-164-228-147.ap-northeast-2.compute.amazonaws.com:8080/rl/review/'+ reviewWriter,
	 		url : 'http://localhost:8080/rl/review/'+ reviewWriter,
			 type : 'post',
			 success : function(data){ 
				 $('#modal').css('display','block');
			 		var html = '<div class="w3-modal-content">';
					html += '	 <header class="w3-container">';
					html += '  		<span onclick="modalClose('+')" class="w3-button w3-display-topright">&times;</span>'; 
					html += '  		<h2>Modal Header</h2>';
					html += ' 	</header>';
					html += '		<div class="w3-container">';
					
		 			for(var i=0;i<data.length;i++){ //채팅을 요청한 사람  
		 				if(data[i].status == 0){
							html += ' 			<div onclick="reviewWrite('+data[i].reviewIdx+','+data[i].status+',\''+data[i].receiver+'\')">'+data[i].receiver+'</div>';
		 				}
		 				}
					html += ' 		</div>';
			 		html += "</div>";
						 		
			 		$('#modal').html(html); 
			 }
		 });
		 
	 }
			 
	
} 


//리뷰 작성 하기
function reviewWrite(reviewIdx,rstatus,rReceiver){
	  var form = $('<form></form>');
	    form.attr('action', '/mangh/review/reviewForm');
	    form.attr('method', 'post');
	    form.appendTo('body');
	    var idx = $("<input type='hidden' value="+reviewIdx+" name='reviewIdx'>"); //게시글 번호
	    var reviewStatus = $("<input type='hidden' value="+rstatus+" name='rstatus'>"); //게시글 상태 
	    var reviewReceiver = $("<input type='hidden' value="+rReceiver+" name='receiver'>"); //게시글 받는 사람
	    form.append(idx);
	    form.append(reviewStatus);
	    form.append(reviewReceiver);
	    
	    form.submit(); 
}
	 
	 
	
//글 수정
function reqEdit(reqIdx){
	
	var form = $('<form></form>');
    form.attr('action', '/mangh/request/edit');
    form.attr('method', 'post');
    form.appendTo('body');
    var idx = $("<input type='hidden' value="+reqIdx+" name='reqIdx'>"); //게시글 번호
    form.append(idx);
    form.submit(); 
}

//글 삭제
function reqDelete(reqIdx){
	
	//로그인 안했을 때 
	if('${loginInfo}' != ''){
		if(confirm("정말로 삭제하시겠습니까?") == true){
			 $.ajax({
			//	url : 'http://ec2-15-164-228-147.ap-northeast-2.compute.amazonaws.com:8080/rl/request/'+reqIdx,
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
		
		//url : 'http://ec2-15-164-228-147.ap-northeast-2.compute.amazonaws.com:8080/rl/request/'+${idx},
		url : 'http://localhost:8080/rl/request/'+${idx},
		type : 'GET',
		data : {
			count : ${count},
			mNick : '${loginInfo.mNick}',
			writer : '${writer}'
		},
		success : function(data){
			var title=data.reqTitle;
			$('#title').text(title);
			$('#info_h3').text('요청 요약' );
			$('#writer_h3').text('요청자 정보');
			$('#content_h3').text('요청 상세 내용'); 
			
			$('#mNick').text(data.reqWriter); 
			
			if(data.avg > 0){
				for (var i = 1; i <= 5; i++) {
					if (data.avg <= i) {
						var avg = '&#11088;';
						$('#mAvg').append(avg); 
					}
				}
				
				
			}else {
				$('#mAvg').text('평점이 없습니다.');
			}
			
		//요청 게시글 상세 정보
		var html =	'<table>';
			/* html += '<tr>';
			html +=	'	<td>요청자</td>';
			html +=	'<td>'+data.reqWriter+'</td>';
			html += '</tr>'; */
			
			html += '<tr>';
			html +=	'	<td>요청자 위치</td>';
			html +=	'	<td>'+data.reqAddr.substr(2,5)+'</td>';
			html += '</tr>';
			
			html += '<tr>';
			html +=	'	<td>등록일</td>';
			html +=	'	<td>'+data.reqDateTime+'</td>';
			html += '</tr>';
			
			html += '<tr>';
			html	+='<td>조회수</td>';
			html+=	'	<td>'+data.reqCount+'</td>';
			html += '</tr>';
			if ('${loginInfo}' != '') {
			html += '<tr>';
			html	+='<td>거리</td>';
			if ('${loginInfo}' != '') {
				if( ${distance} >= 1000){
					var calDistance = ${distance};
					calDistance = (Math.round(calDistance/100))/10;
					html += ' <td>' + calDistance + ' km</td>';
				}else{
					html += '	<td>'+${distance}+'m</td>';
				}	
				
				}
			html += '</tr>';
			}
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
				
				if(data.reqStatus == 1){ // 매칭 완료 상태
					if(cancelStatus == 1){ //취소 버튼 쿠키가 있을 때 취소 가능
						html +='	<td><button onclick="cancel('+data.reqStatus+')" id="cancelBtn" >매칭취소</button></td>';
					} 
				} else if(data.reqStatus == 0){ //매칭 전 상태
					html +='	<td><button onclick="complete()">매칭완료</button></td>';
				} 
				//수정, 삭제
				html += '	<td><button onclick="reqEdit('+data.reqIdx+')">수정</button></td>';
				html += '	<td><button  onclick="reqDelete('+data.reqIdx+')">삭제</button></td>';
			}
	
			//로그인 한 회원이 리뷰 작성자 일 때 - 권한 확인 
			if('${loginInfo.mNick}' == data.reviewWriter){
					html += '	<td><button onclick="review(\''+data.reviewWriter+'\','+data.reviewStatus+')">리뷰작성</button></td>';
			}
			
			//로그인 한 사용자가 리뷰 권한이 없을 때
			/* else if('${loginInfo.mNick}' != data.reviewWriter && '${loginInfo.mNick}' != data.reqWriter){ 
				if(data.reqStatus == 0){ //매칭 완료 상태가 아닐 때 	
					html +='	<td><button onclick="chat('+data.reqIdx+',\''+data.reqWriter +' \')" id="chat">매칭하기</button></td>';
					
				} 
			} */
			  //비회원 일 때
			/* else if('${loginInfo}' == ''){		
				if(data.reqStatus == 0){
					html +='	<td><button onclick="chat('+data.reqIdx+',\''+data.reqWriter +' \')" id="chat">매칭하기</button></td>'; 
					
				}
			}  */
			html += '</tr>';
	 		/* html +='<tr>';
			html += '<td>';
			//html += '	<img src="http://ec2-15-164-228-147.ap-northeast-2.compute.amazonaws.com:8080/rl/upload/'+data.reqImg+'" style="width: 50%"> ';
			html += '	<img src="http://localhost:8080/rl/upload/'+data.reqImg+'" style="width: 50%"> ';
			html += '</td>';
			html +='</tr>'; */
			html +=	'</table>';	
			
			
			
			if('${loginInfo.mNick}' != data.reviewWriter && '${loginInfo.mNick}' != data.reqWriter){ 
				if(data.reqStatus == 0){ //매칭 완료 상태가 아닐 때 	
					/* html +='	<td><button onclick="chat('+data.reqIdx+',\''+data.reqWriter +' \')" id="chat">매칭하기</button></td>'; */
					var chatBtn = '<button onclick="chat('+data.reqIdx+',\''+data.reqWriter +' \')" id="chat">매칭하기</button>';
					$('#chat_Box').html(chatBtn);
					
				} 
			}
			
			
			 //비회원 일 때
			if('${loginInfo}' == ''){		
				if(data.reqStatus == 0){
					var chatBtn = '<button onclick="chat('+data.reqIdx+',\''+data.reqWriter +' \')" id="chat">매칭하기</button>';
					$('#chat_Box').html(chatBtn);
				}
			} 
			
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