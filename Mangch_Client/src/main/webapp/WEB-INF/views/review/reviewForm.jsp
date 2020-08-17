<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<h1>리뷰</h1>

<!-- 	<form  action="/mangh/review/reviewReg"; method="post" onsubmit="return false;"> -->
	<form onsubmit="return false;">
		<table>
			<tr>
				<td>리뷰내용</td>
				<td><textarea id="reviewText"></textarea></td>
			</tr>
			<tr>
				<td>평점</td>
				<td><select id="avg" >
						<option id="1" value="1">1</option>
						<option id="2" value="2">2</option>
						<option id="3" value="3">3</option>
						<option id="4" value="4">4</option>
						<option id="5" value="5">5</option>
				</select>
				
				<input type="hidden"  id="reqIdx" value="${reqIdx}">
				<input type="hidden"  id="reqWriter" value="${reqWriter}">
				<input type="hidden"  id="reqHelper" value="${reqHelper}">
				
				</td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="리뷰 등록" onclick="reviewSubmit()"></td>
			</tr>
		</table>
	</form>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	
	<script>
		//리뷰 등록
		function reviewSubmit(){
			
		 	var receiverChk;
			
			if('${loginInfo.mNick}' ==  $('#reqWriter').val()){ //로그인 한 사용자가 요청자 일 떄
				receiverChk = $('#reqHelper').val(); //리뷰 받는 사람
			}else if('${loginInfo.mNick}' ==  $('#reqHelper').val()){ //로그인 한 사용자가 수행자 일 떄
				receiverChk = $('#reqWriter').val(); //리뷰 받는 사람
			}
			 
			
			console.log('${loginInfo.mNick}');	
			var reviewInfo = {
					reqIdx	: $('#reqIdx').val(),
					receiver : receiverChk, //상대방
					writer : '${loginInfo.mNick}', //로그인 한 사용자 
					text : $('#reviewText').val(),
					avg : $('#avg').val()
			};
			
			console.log(reviewInfo);
			
			 $.ajax({
				url : 'http://localhost:8080/rl/review',
				type : 'post',
				data : reviewInfo,
				success : function(data){
					alert('리뷰가 등록되었습니다.');
					location.href="/mangh/request/requestList"; 
				}
			}); 
			
					
		}
		
		
		
	</script>
	
</body>


</html>