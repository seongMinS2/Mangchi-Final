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
	#wriBtn{
		margin-top: 15px;
	}
</style>

</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />

	<div class="w3-container">
		
		<div>
			<h1 class="w3-left">게시물 리스트</h1>
			<a href="<c:url value="/request/requestWrite"/>" class="w3-right"><button>글쓰기</button></a>
		</div>
		
		<div class=" w3-margin-bottom" id="list"></div>
		
	</div>


	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
<script>
	$(document).ready(function() {

		$.ajax({
			url : 'http://localhost:8080/rl/request',
			type : 'GET',

			success : function(data) {

				var html = '<table class="w3-table w3-border w3-hoverable">';
				html += '	<tr class="w3-hover-grayscale">';
				html += '	<th>글 제목</th>';
				html += '	<th>지역</th>';
				html += '	<th>거리</th>';
				html += '	<th>상태</th>';
				html += '	<th>등록날짜</th>';
				html += '	</tr>';
	
				
				for (var i = 0; i < data.length; i++) {
					html += '<tr>';
					html += ' <td> <a href="<c:url value="/request/requestDetail?idx='+data[i].reqIdx+'" />" >' + data[i].reqTitle + '</a></td>';
					html += ' <td>' + data[i].reqAddr + '</td>';
					html += ' <td>' + data[i].distance + ' m</td>';
					html += ' <td>' + data[i].reqStatus + '</td>';
					html += ' <td>' + data[i].reqDateTime + '</td>';
					html += '</tr>';
				}
				html += '</table>';
				$('#list').html(html);
			}

		});
		
	});

	
	
	
</script>

</html>