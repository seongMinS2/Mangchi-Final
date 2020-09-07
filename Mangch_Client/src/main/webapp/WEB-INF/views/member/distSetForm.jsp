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
					<h1 class="allVisitor" style="color: #162d59;"><B>${allVisitor}</B></h1>
					<h2>오늘 방문자 수</h2>
					<h1 class="todayVisitor" style="color: #162d59;"><B>${todayVisitor}</B></h1>
				</div>
			</div>
		</div>
		
		
	</div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

<script>
$(function() {

	var cnt = 0;
	var allCount = 0;
	var todayCount = 0;
	var allVisitor = ${allVisitor};
	var todayVisitor = ${todayVisitor};
	
	counterFn();
	allCounter();
	todayCounter();
	
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
	
	function allCounter(){
		id1 = setInterval(countFn1, 100);
		
		function countFn1(){
			allCount++;
			if(allCount>allVisitor){
				clearInterval(id1);
			} else {
				$(".allVisitor").html('<B>'+allCount+'</B>');
			}
		}
	}
	
	function todayCounter(){
		id2 = setInterval(countFn2, 100);
		
		function countFn2(){
			todayCount++;
			if(todayCount>todayVisitor){
				clearInterval(id2);
			} else {
				$(".todayVisitor").html('<B>'+todayCount+'</B>');
			}
		}
	}
	
});
</script>
</body>
</html>









