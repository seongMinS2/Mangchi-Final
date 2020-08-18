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
		<h2>요청리스트</h2>
		<hr>
		<div class="w3-cell-row">
			<div class="w3-cell" style="width:25%">
				<div id="profile-menu" class="active">
					<a href="requestListForm">요청 리스트</a> 
					<a href="lendingListForm">대여리스트</a>
					<a href="reviewListForm">나의 리뷰</a> 
					<a href="commentListForm">나의 댓글</a> 
					<a href="mypageForm">나의 정보</a> 
					<a href="distSetForm">거리 설정</a> 
					<a href="keywordSetForm">키워드 설정</a>
				</div>
			</div>
			<div class="w3-cell" style="width:75%">
			<div id="requestList" style="margin-right:10%">
					<table>
						<tr>
							<td>글번호</td>
							<td>글제목</td>
							<td>상태</td>
							<td>작성 지역</td>
							<td>작성자</td>
							<td>작성 날짜</td>
							<td>조회수</td>
						</tr>
						<tr>
							
						</tr>
					</table>
				</div>
			</div>
		</div>
</div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script>
	$(document).ready(function(){
		
		// 요청리스트 출력
/* 		var mNick = '${loginInfo.mNick}';
		alert(mNick);
		
		$.ajax({
			url : 'memberLogin',
			type : 'post',
			data : {
				mId : $('#mId').val(),
				mPw : $('#mPw').val()
			},
			success : function(data) {
				if (data == 'Y') {
					alert('환영합니다 !!!');
					location.href='memberMypage/mypageForm';
				} else if (data == 'N') {
					alert('아이디와 비밀번호를 확인해주세요.');
					document.getElementById('loginForm').reset();
				} else {

				}
			}
		}); */
		
		
		
		
		
		
		
		
	});
</script>
</body>
</html>