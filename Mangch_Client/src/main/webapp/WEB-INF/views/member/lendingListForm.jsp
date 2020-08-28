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
<style>
#avg {
	font-size: 120%;
}

.pagination li {
	float: left;
	padding: 10px 20px;
}

.pagination li>a {
	display: block;
	line-height: 50px;
	font-size: 20px;
	font-weight: 600;
	text-decoration: none;
	color: #777;
	border-radius: 50%;
	transition: 0.3s;
}

.pagination {
	padding: 10px 20px;
	background: white;
	border-radius: 50px;
	box-shadow: 0 0.3px 0.6px rgba(0, 0, 0, 0.056), 0 0.7px 1.3px
		rgba(0, 0, 0, 0.081), 0 1.3px 2.5px rgba(0, 0, 0, 0.1), 0 2.2px 4.5px
		rgba(0, 0, 0, 0.119), 0 4.2px 8.4px rgba(0, 0, 0, 0.144), 0 10px 20px
		rgba(0, 0, 0, 0.2);
	list-style-type: none;
	float: left;
}

#pageCon{

	margin-left: 33.2%;
}	
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div class="w3-container container">
		<h2>${loginInfo.mNick}님의대여리스트</h2>
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
				<div id="lendList" style="margin-right: 10%"></div>
				<div id="page"></div>
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<script>
		function listpage(data) {
			page = data;
			list();
		}
	
		
		function detail(reqIdx,calDistance,reqCount){
			 var form = $('<form></form>');
			    form.attr('action', '/mangh/request/requestDetail');
			    form.attr('method', 'post');
			    form.appendTo('body');
			    var idx = $("<input type='hidden' value="+reqIdx+" name='idx'>"); //게시글 번호
			    var distance = $("<input type='hidden' value="+calDistance+" name='distance'>"); //게시글 상태 
			    var count = $("<input type='hidden' value="+reqCount+" name='count'>"); //게시글 상태 
			    form.append(idx);
			    form.append(distance);
			    form.append(count);
			    form.submit(); 
		}
		
		
		var page = 1;
		// 요청리스트 출력
		var type = "lending";

		function list() {
			$
					.ajax({
						url : 'http://ec2-15-164-228-147.ap-northeast-2.compute.amazonaws.com:8080/rl/mypage/'+ '${loginInfo.mNick}',
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

							if (data.pageTotalCount > 0) {
								for (var i = 0; i < data.requestReg.length; i++) {
									html += '<tr>';
									html += ' <td>' + (i + data.startRow + 1)
											+ '</td>';
									/* html += ' <td> <a href="<c:url value="/request/requestDetail?idx='
											+ data.requestReg[i].reqIdx
											+ '&distance='
											+ data.requestReg[i].calDistance
											+ '&count='
											+ data.requestReg[i].reqCount
											+ '" />" >'
											+ data.requestReg[i].reqTitle
											+ '</a></td>'; */
									html += '<td><div onclick="detail('+data.requestReg[i].reqIdx+','+data.requestReg[i].calDistance+','+data.requestReg[i].reqCount+')">'+data.requestReg[i].reqTitle+'</div></td>';		
									html += ' <td>'
											+ data.requestReg[i].reqAddr
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
									html += ' <td>'
											+ data.requestReg[i].reqWriter
											+ '</td>';
									html += ' <td>'
											+ data.requestReg[i].reqCount
											+ '</td>';
									html += ' <td>'
											+ data.requestReg[i].reqDateTime
											+ '</td>';
									html += '</tr>';
								}
							} else {
								html += '<tr>';
								html += '<td></td>';
								html += '<td></td>';
								html += '<td></td>';
								html += '<td></td>';
								html += '<td>완료 된 요청이 없습니다.</td>';
								html += '<td></td>';
								html += '<td></td>';
								html += '</tr>';
							}

							html += '</table>';
							if (data.pageTotalCount > 0) {
								var page = '<ul class="pagination" id="pageCon">';
								for (var m = 1; m <= data.pageTotalCount; m++) {
									page += '<li class="page-number>';
									page += '	<a id="listlink" href="#" onclick="listpage('
											+ m + ')" >';
									page += m;
									page += '	</a>';
									page += '</li>';
								}
								page += '</ul>';

							}
							$('#page').html(page);

							$('#lendList').html(html);

						}
					});

		}

		$(document).ready(function() {
			list();
		});
	</script>

</body>
</html>