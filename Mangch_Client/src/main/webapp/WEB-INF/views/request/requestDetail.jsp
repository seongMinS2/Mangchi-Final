<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>요청 게시판</title>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.12.4.js"></script>

<style>


td {
	padding: 5px;
    width: 200px;
}

/* css */

 #tbox {
    padding: 30px 0px 0px 0px;
}

#title {
    display: inline;
}

#chatBox {
    display: inline;
    float: right;
}

/* 채팅하기 버튼 */
#chat {
    height: 50px;
    width: 107px;
    text-align: center;
    background-color: #FFD201;
    border-radius: 5px;
    border: 1px solid #f7f7f7;
    font-weight: bold;
}

/* 채팅 완료 버튼 */
#chatCom{
 	height: 50px;
    width: 107px;
    text-align: center;
    background-color: #FFD201;
    border-radius: 5px;
    border: 1px solid #f7f7f7;
    font-weight: bold;
}

#chatCan{
height: 50px;
    width: 107px;
    text-align: center;
    background-color: #f7f7f7;
    border-radius: 5px;
    border: 1px solid #f7f7f7;
    font-weight: bold;

	
}




/* 리뷰 작성 버튼 */
#review{
    height: 50px;
    width: 107px;
    text-align: center;
    background-color: #FFD201;
    border-radius: 5px;
    border: 1px solid #f7f7f7;
    font-weight: bold;
    margin-left: 10px;
    margin-right: 10px;
}

/* 로그인 상태에서 수정 삭제 */
.checkBtn{
     margin-top: 50px;
     margin-right: 10px;
     height: 40px;
     width: 45%;
     float: left;
     text-align: center;
     font-weight: bold;
     background-color: #FFD201;
     border-radius: 5px;
     border: 1px solid #f7f7f7;
}


#infoBox {
	padding-top: 15px;
    width: 70%;
}



#mInfo {
    padding-top: 15px;
    padding-left: 30px;
}

#mNick,
#mAvg {
    border-left: 2px solid #DDD;
    padding-left: 16px;
    font-size: 16px;
}

#mImg {
    width: 58px;
    height: 58px;
    border-radius: 50%;
}

#info_h6,
#content_h6 {
    font-weight: bold;
}


/* 이미지  */
#reqImg {
    max-width: 500px;
    max-height: 500px;
    text-align: center;
}


/* 조회수 */
#reqCount {
    font-size: 12px;
}


/* 모달 창 */
/* 모달 상자 */
#comBox{
    margin-left: 50px;
    max-width: 800px;
    text-align: center;
}

/*모달 제목*/
#modalTitle {
    margin: 15px 0px 25px 0px;
    text-align: center;
}

/*매칭 상대 박스*/
#helpBox, #reviewBox {
    margin: 0px 15px 30px 15px;
    padding: 20px;
    width: 180px;
    border: 3px solid #f2f2f2;
    border-radius: 15px;
    display: inline-block;
}
/*매칭 상대 선택 버튼*/
.helperBtn {
    margin-top: 15px;
    width: 100%; 
    height: 35px;
    border-radius: 15px;
    font-size: 15px;
    font-weight: bold;
    background-color: #FFD201;
    border: 1px solid #f7f7f7;
}
#mImg {
    width: 130px;
    height: 130px;
    border-radius: 50%;
    margin: 0px 0px 15px 5px;
}

#modalAvg{
      text-align: center;
      font-size: 16px;
}

#reqInfo{
    margin-left: 17px;
}





</style>

</head>
<body>
	
	<jsp:include page="/WEB-INF/views/include/header.jsp" />


		
		<div class="w3-content" id="tbox">
			<h1 id="title"></h1>
			<div id="chatBox"> </div>
			<hr>
		</div>
		
			
	<div class="w3-content w3-margin-bottom" >
					

			<!-- 1 -->
			<div class="w3-cell-row">

					<!-- 요청 게시글 상세 정보 -->
					<div  id="infoBox">
						<h6 id="info_h6"></h6>
						<div id="reqInfo"></div>
		
					<hr>
					<!-- 상세내용 -->
						<h6 id="content_h6"></h6>
						  <div id="imgBox"></div>
						<div id="reqcontents"></div>
					</div>
					
					<!-- 요청자 정보 --> 
					
					<div class="w3-cell" id="mInfo">
						<!-- <h3 id="writer_h3"></h3> -->
						<span id="memImg">
						</span>
						
						<h6>요청자 이름</h6>
						<span id="mNick"></span>
						<h6>요청자 평점</h6>
						<span id="mAvg"></span>
						
						 <!-- 회원 로그인 시 -->
               			 <div id="infoBtn"></div>
						
						
					</div>
	
			</div>

		</div>


	<div class="w3-modal" id="modal" ></div>

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
		location.href="${pageContext.request.contextPath}/chat?reqIdx="+reqIdx+"&uNick="+uNick; 
		
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
	 location.href="${pageContext.request.contextPath}/member/memberLogin"; 
	}
}

//모달 데이터 출력 
var page = 1;	
var type ='';

var writer = '';
var rstatus = '';


//모달 닫기
function modalClose(){
	$('#modal').css('display','none');
	
}

//모달 이전
function prev(currentPage){
	
	if(currentPage == 1){
		alert('첫 페이지 입니다.');
	}else{
		page = currentPage - 1;
		if(type == 'comMsg'){
			complete();
		} else if(type.eq('reviewMsg')){
			review(writer,rstatus);
		}
	}
	
}
//모달 이후
function next(currentPage,pageTotalCount){
	
	if(page == pageTotalCount){
		alert('마지막 페이지 입니다.');
	}else{
		page = 	currentPage + 1;
		 if(type == 'comMsg'){
			complete();
		}  else if(type == 'reviewMsg'){
			review(writer,rstatus);
		} 
		
	}
}

var btn ='';

//매칭 상대 정하기
function complete(){
	
	 type = 'comMsg';
	 
	 $.ajax({
 		url : 'http://ec2-52-79-249-25.ap-northeast-2.compute.amazonaws.com:8080/rl/chat/complete/'+ ${idx},
 	//	url : 'http://localhost:8080/rl/chat/complete/'+ ${idx},
 		data : {
 			page : page
 		},
		 type : 'get',
		 success : function(data){
			 
			
			 
			 if(data.requestChat.length > 0 ){
				 //var chatBtn = '<button id="chatCom">매칭 선택</button>';
				 btn += '<button id="chatCom" onclick="comChat()">매칭 선택</button>';
				 $('#chatBox').html(btn);
		 	 }
			
				
				var html = '<div class="w3-modal-content">';
				html += '	 <header class="w3-container">';
				html += '  		<span onclick="modalClose()" class="w3-button w3-display-topright">&times;</span>'; 
				html += '  		<h2 id="modalTitle">매칭 상대 선택</h2>';
				html += ' 	</header>';
				
				html +=' <div id="comBox" >';
	 			for(var i=0;i<data.requestChat.length;i++){ //채팅을 요청한 사람  
					/* html += ' 			<div onclick="updateHelper( \''+data[i].helper+'\', \''+data[i].writer+'\' )">'+data[i].helper+'</div>'; */
					html += '		<div id="helpBox">';
					
					 if(data.requestChat[i].mImg.substring(0,4) =='http'){ //카카오 로그인
						 html += ' <img id="mImg" src="'+data.requestChat[i].mImg+'">'; //회원 이미지 경로 설정 변경하기  -- data.requestChat[i].mImg;	
					}else { //카카카오 로그인 아닐 때
						 if(data.mImg =='defalult.png') {
						 	html += ' <img id="mImg" src="${pageContext.request.contextPath}/resources/img/'+data.requestChat[i].mImg+'">';  //회원 이미지 경로 설정 변경하기  --->  data[i].member.mImg
						 }else{
							 html += ' <img id="mImg" src="${pageContext.request.contextPath}/resources/img/upload/'+data.requestChat[i].mImg+'">'; //회원 이미지 경로 설정 변경하기  --->  data[i].member.mImg						
						 }
						
					} 
					
					html +='<div id="modalAvg">';
					if(data.requestChat[i].avg > 0){
						for (var j = 0; j < 5; j++) {
							if (data.requestChat[i].avg > j) {
								html +='&#11088;';
							}
						}
						html +='</div>';
					}else {
						html += '<div id="modalAvg">평점이 없습니다.</div>';
					}
					
					html += ' 			<button class="helperBtn" onclick="updateHelper( \''+data.requestChat[i].helper+'\', \''+data.requestChat[i].writer+'\' )">'+data.requestChat[i].helper+'</button>';
					html += ' 		</div>';
	 			}
		 		
	 			
	 			//슬라이드 처리 
	 			html +='   <button class="w3-button w3-display-left" onclick="prev('+page+')">&#10094;</button>';
	 			html +='   <button class="w3-button w3-display-right" onclick="next('+page+','+data.pageTotalCount+')">&#10095;</button>';
	 			
	 			html += ' </div>';
		 		$('#modal').html(html);
			//html += ' 			<div onclick="updateHelper(\''+helper+'\', \''+writer+'\') ">'+helper+'</div>';
		

		 /* $('#chatCom').click(function () {
			 $('#modal').css('display','block');
		})  */
	 }
			 
 		
});
	/*  $('body').on( "click", $('#chatCom'), function() {
		alert('test');
		}); */
}


function comChat(){
	 $('#modal').css('display','block');
}


//매칭 완료 데이터 업데이트
function updateHelper(helper,writer){
	
	if(confirm(helper+"님을 선택하시겠습니까?") == true){
		
		//매칭 완료 시 쿠키 생성 				
		$.ajax({
			url : 'http://ec2-52-79-249-25.ap-northeast-2.compute.amazonaws.com:8080/rl/chat/'+${idx},
			//url : 'http://localhost:8080/rl/chat/'+${idx},
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
					location.href= "${pageContext.request.contextPath}/makeCookie?idx="+${idx}+"&distance="+${distance}+"&count="+${count}+"&writer="+writer;
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
		 
			 url : 'http://ec2-52-79-249-25.ap-northeast-2.compute.amazonaws.com:8080/rl/request/'+ ${idx},
			 //url : 'http://localhost:8080/rl/request/'+ ${idx},
			 type : 'PUT',
			 success : function(data){
				 if(data > 0){
				 	alert('매칭이 취소되었습니다.');
				 	history.go(0);
				 }
			 }
			 
		 });	
	}	 
	
	
	
	}
}


//리뷰 작성 
function review(reviewWriter,reviewStatus){
	
	 type = 'reviewMsg';

	 writer = reviewWriter;
	 rstatus = reviewStatus;
	 
	 
	 if(reviewStatus == 1){
		 alert('이미 리뷰가 작성되었습니다.');
	 }else if(reviewStatus == 0){
		 
		 //상대방 선택 하기 
		  $.ajax({
	 		url : 'http://ec2-52-79-249-25.ap-northeast-2.compute.amazonaws.com:8080/rl/review/'+ reviewWriter,
	 		//url : 'http://localhost:8080/rl/review/'+ reviewWriter,
	 		data : {
	 			reqIdx : ${idx},
	 			page : page
	 		},
			 type : 'post',
			 success : function(data){ 
				
				$('#modal').css('display','block');
			 		var html = '<div class="w3-modal-content">';
					html += '	 <header class="w3-container">';
					html += '  		<span onclick="modalClose()" class="w3-button w3-display-topright">&times;</span>'; 
					html += '  		<h2 id="modalTitle">리뷰 작성 할 상대 선택</h2>';
					html += ' 	</header>';
					html +=' <div id="comBox" >';
					for(var i=0;i<data.reviewList.length;i++){ //리뷰 작성 가능 자 
						/* html += ' 			<div onclick="updateHelper( \''+data[i].helper+'\', \''+data[i].writer+'\' )">'+data[i].helper+'</div>'; */
						if(data.reviewList[i].status == 0){
						html += '		<div id="reviewBox">';
						
						 if(data.reviewList[i].member.mImg.substring(0,4) =='http'){ //카카오 로그인
							 html += ' <img id="mImg" src="'+data.reviewList[i].member.mImg+'">'; 
						 }else { //카카카오 로그인 아닐 때
							 
							 if(data.mImg =='defalult.png') {
								html += ' <img id="mImg" src="${pageContext.request.contextPath}/resources/img/'+data.reviewList[i].member.mImg+'">'; //회원 이미지 경로 설정 변경하기  --->  data[i].member.mImg
							 }else{
								html += ' <img id="mImg" src="${pageContext.request.contextPath}/resources/img/upload/'+data.reviewList[i].member.mImg+'">'; //회원 이미지 경로 설정 변경하기  --->  data[i].member.mImg						
							 }
							 
						} 
						
						html += ' 			<button class="helperBtn" onclick="reviewWrite('+data.reviewList[i].reviewIdx+','+data.reviewList[i].status+',\''+data.reviewList[i].receiver+'\')">'+data.reviewList[i].receiver+'</button>';
						html += ' 		</div>';
		 				}
		 			}
					
					//슬라이드 처리 
		 			html +='   <button class="w3-button w3-display-left" onclick="prev('+page+')">&#10094;</button>';
		 			html +='   <button class="w3-button w3-display-right" onclick="next('+page+','+data.pageTotalCount+')">&#10095;</button>';
					
					html += ' 		</div>';
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
				url : 'http://ec2-52-79-249-25.ap-northeast-2.compute.amazonaws.com:8080/rl/request/'+reqIdx,
				//url : 'http://localhost:8080/rl/request/'+reqIdx,
				type : 'DELETE',
				success : function(data) {
					var message = '';
					if(data > 0 ){
						message = "게시글이 정상적으로 삭제되었습니다.";
					}else {
						message = "게시물을 삭제 할 수 없습니다.";
					}
					alert(message);
					location.href="${pageContext.request.contextPath}/request/requestList?headerCheck=1&text=no";
				}
			 
				
			});
			
		}	
	}
	
}


$(document).ready(function(){
	
	$.ajax({
		
		url : 'http://ec2-52-79-249-25.ap-northeast-2.compute.amazonaws.com:8080/rl/request/'+${idx},
		//url : 'http://localhost:8080/rl/request/'+${idx},
		type : 'GET',
		data : {
			count : ${count},
			mNick : '${loginInfo.mNick}',
			writer : '${writer}'
		},
		success : function(data){
			var title=data.reqTitle;
			$('#title').text(title);
			$('#info_h6').text('요청 요약' );
			/* $('#writer_h3').text('요청자 정보'); */
			$('#content_h6').text('요청 상세 정보'); 
			
			$('#mNick').text(data.reqWriter);
			
			var memberImg = '';
			console.log(data.mImg);
			
			 if(data.mImg.substring(0,4) =='http'){ //카카오 로그인
				 memberImg += '<img id="mImg" src="'+data.mImg+'">';	
			}else { //카카카오 로그인 아닐 때
				
				 
				 if(data.mImg =='defalult.png') {
					 memberImg += '<img id="mImg" src="${pageContext.request.contextPath}/resources/img/'+data.mImg+'">';
				 }else{
					 memberImg += '<img id="mImg" src="${pageContext.request.contextPath}/resources/img/upload/'+data.mImg+'">';
				 }
			} 
			
			
			$('#memImg').html(memberImg);
			
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
			
			var reqAddr = data.reqAddr.replace(/[a-z0-9]|[\[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g,"");
			
			html +=	'	<td>'+reqAddr+'</td>';
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
			html +='	<td style="color: '+color+'; font-weight:bold;">';
			html +='		'+status+'';
			html += '	</td>';
				
			
			
			var infoBtn ='';
			//로그인 한 사용자가 요청자 일 때 
			if('${loginInfo.mNick}' == data.reqWriter){
				if(data.reqStatus == 1){ // 매칭 완료 상태
					if(cancelStatus == 1){ //취소 버튼 쿠키가 있을 때 취소 가능
						//var chatBtn = '	<button onclick="cancel('+data.reqStatus+')" id="chatCan">매칭취소</button>';
						btn += '	<button onclick="cancel('+data.reqStatus+')" id="chatCan">매칭취소</button>';
						$('#chatBox').html(chatBtn);
					} 
				} else if(data.reqStatus == 0){ //매칭 전 상태
					infoBtn += '<button onclick="reqEdit('+data.reqIdx+')" class="checkBtn">수정</button>';
					complete();
//					html +='	<td><button onclick="complete()">매칭완료</button></td>';
					//$('#infoBtn').html(infoBtn);
				} 
				//수정, 삭제
				/* html += '	<td><button onclick="reqEdit('+data.reqIdx+')">수정</button></td>';
				html += '	<td><button  onclick="reqDelete('+data.reqIdx+')">삭제</button></td>'; */
				// infoBtn += '<button onclick="reqEdit('+data.reqIdx+')" class="checkBtn">수정</button>';
				infoBtn += '<button onclick="reqDelete('+data.reqIdx+')" class="checkBtn">삭제</button>'; 
				$('#infoBtn').html(infoBtn);
			}
	
			html += '</tr>';
			html +=	'</table>';	
			
			
//			if('${loginInfo.mNick}' != data.reviewWriter && '${loginInfo.mNick}' != data.reqWriter){ 
			if( '${loginInfo.mNick}' != data.reqWriter){ 
				if(data.reqStatus == 0){ //매칭 완료 상태가 아닐 때 	
					/* html +='	<td><button onclick="chat('+data.reqIdx+',\''+data.reqWriter +' \')" id="chat">매칭하기</button></td>'; */
					//var chatBtn = '<button onclick="chat('+data.reqIdx+',\''+data.reqWriter +' \')" id="chat">매칭하기</button>';
					btn += '<button onclick="chat('+data.reqIdx+',\''+data.reqWriter +' \')" id="chat">매칭하기</button>';
					//$('#chatBox').html(chatBtn);
					
				} 
			}
			
			
			//로그인 한 회원이 리뷰 작성자 일 때 - 권한 확인 
			if('${loginInfo.mNick}' == data.reviewWriter){
					//html += '	<td><button onclick="review(\''+data.reviewWriter+'\','+data.reviewStatus+')">리뷰작성</button></td>';
					//var reviewBtn = '<button id="review" onclick="review(\''+data.reviewWriter+'\','+data.reviewStatus+')">리뷰작성</button>';
					btn += '<button id="review" onclick="review(\''+data.reviewWriter+'\','+data.reviewStatus+')">리뷰작성</button>';
					//$('#chatBox').html(reviewBtn);
			}
			
			$('#chatBox').append(btn);
			
			 //비회원 일 때
			if('${loginInfo}' == ''){		
				if(data.reqStatus == 0){
					var chatBtn = '<button onclick="chat('+data.reqIdx+',\''+data.reqWriter +' \')" id="chat">매칭하기</button>';
					$('#chatBox').html(chatBtn);
				}
			} 
			
			$('#reqInfo').html(html);
			
			
			
			//이미지 넣기
			var img = '';
			if(data.reqImg !='defalult.png'){
				img += '<img id="reqImg" src="http://ec2-52-79-249-25.ap-northeast-2.compute.amazonaws.com:8080/rl/upload/'+data.reqImg+'">';
				$('#imgBox').html(img);
			} 
			//요청 게시글 내용 
			$('#reqcontents').html(data.reqContents);
			
			
		}
	
		
	}); 
	 
});
	
</script>

</body>
</html>