<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<link rel="stylesheet"
	href="<c:url value='/resources/css/member/mypage.css'/>">

</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div class="w3-container container">
		<h2>ㅎㅅㅎ</h2>
		<hr>

		<div class="w3-row">
			<div id="profile-menu" class="w3-col m4 active">
				<a href="requestListForm">요청리스트</a> 
				<a href="lendingListForm">대여리스트</a>
				<a href="reviewListForm">나의리뷰</a> 
				<a href="commentListForm">나의댓글</a> 
				<a href="mypageForm">나의정보</a> 
				<a href="distSetForm">은아 연습장</a>
			</div>

			<div class="w3-col m8">
				<div id="Box" style="margin-left: 5%;">
					<h2>숫자 카운트 애니메이션</h2>
					<h2 class="number">100</h2>
					<br>
					<h2>전체 방문자 수</h2>
					<h1 class="visitor" style="color: #162d59;"><B>${allVisitor}</B></h1>
				</div>
			</div>
		</div>
		
		
	</div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<script>
$(function() {

	var cnt = 0;
	var count = 0;
	var allVisitor = ${allVisitor};
	
	counterFn();
	
	counter();
	
	function counterFn(){
		id0 = setInterval(count0Fn, 10);
		
		function count0Fn(){
			cnt++;
			if(cnt>100){
				clearInterval(id0);
			} else{
				$(".number").text(cnt);
			}
		}
	}
	
	function counter(){
		id1 = setInterval(countFn, 100);
		
		function countFn(){
			count++;
			if(count>allVisitor){
				clearInterval(id1);
			} else {
				$(".visitor").html('<B>'+count+'</B>');
			}
		}
	}
	

	
});
</script>
</body>
</html>









