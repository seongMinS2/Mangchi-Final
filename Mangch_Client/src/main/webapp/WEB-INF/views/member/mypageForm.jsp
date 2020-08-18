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
		<h2>마이페이지</h2>
		<hr>

		<div class="w3-cell-row">
			<!-- <div class="w3-cell" style="width: 25%"> -->
				<div id="profile-menu" class="active">
					<a href="requestListForm">요청 리스트</a> <a href="lendingListForm">대여리스트</a>
					<a href="reviewListForm">나의 리뷰</a> <a href="commentListForm">나의
						댓글</a> <a href="mypageForm">나의 정보</a> <a href="distSetForm">거리 설정</a>
					<a href="keywordSetForm">키워드 설정</a>
				</div>
			<!-- </div> -->
			<div class="w3-cell" style="width: 75%">
				<div id="mypageBox" style="margin-right: 10%">
	
<!-- 				<div id="modal" style="border: 1px solid black;">
						<div class="modalcontent">
							<div class="w3-container">
								<p>정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인합니다.</p>
								<input type="password" id="mPw">
								<button id="btn" onclick="javasrcipt:modalButton();">확인</button>
							</div>
						</div>
					</div> -->
					
					<div id="mypage" style="margin-left:5%;">
						<img src="<c:url value="${loginInfo.mImg}"/>" width="200px"
							height="200px" style="border-radius: 100px;">
					</div>
				</div>
			</div>
		</div>
	</div>


	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<script>


		function modalButton() {

			var mPw = $('#mPw').val();
			var mId = '${loginInfo.mId}';

			$.ajax({
				url : 'chkmPw',
				type: 'post',
				data : {
					mId : mId,
					mPw : mPw
				},
				success : function(data) {
					if (data == 1) {
						document.getElementById('modal').style.display = 'none';
						document.getElementById('mypage').style.display = 'block';
					} else {
						alert(data);
						alert('비밀번호가 일치하지 않습니다.');
						}
				}

			});
		}
	</script>
</body>
</html>