<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>요청 게시판</title>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.12.4.js"></script>


<style>
#wriBtn {
	margin-top: 15px;
}
</style>

</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />

	<div class="w3-container">

		<div>
			<h1 class="w3-left" id="board_h1"></h1>
			<div id="search">
			
			<input type="text" id="search_text" placeholder="검색어를 입력하세요" >
			<input type="button" id="search_btn" onclick="search()" value="검색">
			</div>

			<c:if test="${loginInfo.mNick !=null}">
			<select id="ListType" onchange="change()">
				<option value="distance">거리순</option>
				<option value="date">최신순</option>
			</select> 
			</c:if>
			
			
			<select id="searchType">
				<option value="title">제목</option>
				<option value="name">이름</option>
			</select> <a href="<c:url value="/request/requestWrite"/>" class="w3-right"
				id="writer_button"></a>
		</div>

		<div class=" w3-margin-bottom" id="list"></div>

	</div>


	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
<script>
	/* 로그인 했을 때 와 안했을 때 위도 경도 */

	var mLttd, mLgtd, mRedisu;

	if ('${loginInfo}' != '') {
		mLttd = '${loginInfo.mLttd}';
		mLgtd = '${loginInfo.mLgtd}';
		mRadius = 2; 
	} else {
		mLttd = 0;
		mLgtd = 0;
		mRadius = 0;
	}

	var page = 1;
	var type;
	
	if('${loginInfo}' == ''){
		type = 'date';
	}else {
		type = 'distance';
	}
	
	var searchText = $('#search_text').val();
	var searchType = $('#searchType').val(); 
	

	
	function search(){
		searchText = $('#search_text').val();
		searchType = $('#searchType').val(); 
		list();
	}

	function listpage(data) {
		page = data;
		list();
	}

	function change() {
		type = $('#ListType').val();
		list();
	}

	function list() {
		$.ajax({
					url : 'http://localhost:8080/rl/request',
					type : 'GET',
					data : {
						mLat : mLttd,
						mLon : mLgtd,
						mRadius : mRadius,
						page : page,
						type : type,
						searchText :searchText,
						searchType : searchType
					},
					success : function(data) {

						$('#board_h1').text('게시물 리스트');
						var button = '<button class="w3-right">글쓰기</button>';
						$('#writer_button').html(button);

						var search = '<input type="text" id="search_text" placeholder="검색어를 입력하세요" >';
						search += '<input type="button" id="search_btn" onclick="search()" value="검색">';
						$('#search').html(search);

						var html = '';
						html += '<table class="w3-table w3-border w3-hoverable">';
						html += '	<tr class="w3-hover-grayscale">';
						html += '	<th>번호</th>';
						html += '	<th>글 제목</th>';
						html += '	<th>지역</th>';
						if ('${loginInfo}' != '') {
							html += '	<td>거리</td>';
						}
						html += '	<th>상태</th>';
						html += '	<th>작성자</th>';
						html += '	<th>조회수</th>';
						html += '	<th>등록날짜</th>';

						html += '	</tr>';

						for (var i = 0; i < data.requestReg.length; i++) {
							html += '<tr>';
							html += ' <td>' + (i + data.startRow + 1) + '</td>';
							html += ' <td> <a href="<c:url value="/request/requestDetail?idx='
									+ data.requestReg[i].reqIdx +'&distance='+data.requestReg[i].calDistance+'&count='+data.requestReg[i].reqCount
									+ '" />" >'
									+ data.requestReg[i].reqTitle + '</a></td>';
							html += ' <td>' + data.requestReg[i].reqAddr
									+ '</td>';
							//회원 로그인 상태 일 때 거리 출력
							if ('${loginInfo}' != '') {
							if( data.requestReg[i].calDistance >= 1000){
								var calDistance = data.requestReg[i].calDistance;
								calDistance = (Math.round(calDistance/100))/10;
								html += ' <td>' + calDistance
								+ ' km</td>';
							}else{
								html += ' <td>' + data.requestReg[i].calDistance+ ' m</td>';
							}	
							
							}
							

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
							html += ' <td>' + data.requestReg[i].reqDateTime
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
						$('#list').html(html);

					}
				});
	}
	$(document).ready(function() {
		list();
	});
</script>

</html>