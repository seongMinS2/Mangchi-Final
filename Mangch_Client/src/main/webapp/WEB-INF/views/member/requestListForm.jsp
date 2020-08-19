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
			<div class="w3-cell" style="width: 25%">
				<div id="profile-menu" class="active">
					<a href="requestListForm">요청 리스트</a> <a href="lendingListForm">대여리스트</a>
					<a href="reviewListForm">나의 리뷰</a> <a href="commentListForm">나의
						댓글</a> <a href="mypageForm">나의 정보</a> <a href="distSetForm">거리 설정</a>
					<a href="keywordSetForm">키워드 설정</a>
				</div>
			</div>
			<div class="w3-cell" style="width: 75%">
				<div id="requestList" style="margin-right: 10%"></div>
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<script>
		function listpage(data) {
			page = data;
			list();
		}

		var page = 1;
		// 요청리스트 출력
		var type = "request";

		function list() {
			$
					.ajax({
						url : 'http://localhost:8080/rl/mypage/'
								+ '${loginInfo.mNick}',
						type : 'GET',
						data : {
							type : type,
							page : page
						},
						success : function(data) {

							var html = '';
							html += '<table class="w3-table w3-border w3-hoverable">';
							html += '	<tr class="w3-hover-grayscale">';
							html += '	<th>번호</th>';
							html += '	<th>글 제목</th>';
							html += '	<th>지역</th>';
							html += '	<th>상태</th>';
							html += '	<th>작성자</th>';
							html += '	<th>조회수</th>';
							html += '	<th>등록날짜</th>';
							html += '	</tr>';

							for (var i = 0; i < data.requestReg.length; i++) {
								html += '<tr>';
								html += ' <td>' + (i + data.startRow + 1)
										+ '</td>';
								html += ' <td> <a href="<c:url value="/request/requestDetail?idx='
										+ data.requestReg[i].reqIdx
										+ '&distance='
										+ data.requestReg[i].calDistance
										+ '&count='
										+ data.requestReg[i].reqCount
										+ '" />" >'
										+ data.requestReg[i].reqTitle
										+ '</a></td>';
								html += ' <td>' + data.requestReg[i].reqAddr
										+ '</td>';
								var status, color;
								if (data.requestReg[i].reqStatus == 0) {
									status = '대기중';
									color = 'red';
								} else if (data.requestReg[i].reqStatus == 1) {
									status = '요청 완료';
									color = 'gray';
								}
								html += '	<td style="color: '+color+'">';
								html += '		' + status + '';
								html += '</td>';
								html += ' <td>' + data.requestReg[i].reqWriter
										+ '</td>';
								html += ' <td>' + data.requestReg[i].reqCount
										+ '</td>';
								html += ' <td>'
										+ data.requestReg[i].reqDateTime
										+ '</td>';
								html += '</tr>';
							}
							html += '</table>';
							if (data.pageTotalCount > 0) {
								for (var m = 1; m <= data.pageTotalCount; m++) {
									html += '<a id="listlink" ';
									html += 'href="#" onclick="listpage(' + m
											+ ')"';
									html += ">";
									html += '[' + m + ']';
									html += '</a>';
								}
							}

							$('#requestList').html(html);

						}
					});

		}

		$(document).ready(function() {
			list();
		});
	</script>
</body>
</html>