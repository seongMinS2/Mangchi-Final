<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="<c:url value='/resources/js/myeong.js'/>"></script>
<link rel="stylesheet" href="<c:url value='/resources/css/member/mypage.css'/>">
<link rel="stylesheet" href="<c:url value="/resources/css/jin.css"/>">	
<style>
table {
	border-top: 2px solid #333333;
	border-collapse: collapse;
}

th {
	text-align: center;
	width: 5%;
	padding: 11px 0 10px;
	border-top: 3px soild #DDD;
}

th, td {
	border-bottom: 1px solid #c1c1c1;
}

td {
	padding: 11px 0 10px;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div class="w3-container container">
		<h2>${loginInfo.mNick}님의대여리스트</h2>
		<hr>
		<div class="w3-cell-row">
			<!-- <div class="w3-cell" style="width: 25%"> -->
			<div style="width: 25%">
				<div id="profile-menu" class="active">
					<a href="requestListForm">요청내역</a> 
					<a href="lendingListForm">대여내역</a>
					<a href="reviewListForm">나의 리뷰</a> 
					<a href="mypageForm">나의 정보</a> 
				</div>
			</div>
			<div class="w3-cell" id="myBox" style="width: 75%">
				<div id="myList"></div>
				<div id="page"></div>
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<script>
		var type = "lending";

		function list() {
			$.ajax({
				url : 'http://ec2-52-79-249-25.ap-northeast-2.compute.amazonaws.com:8080/rl/mypage/'+ '${loginInfo.mNick}',
				type : 'GET',
				data : {
					type : type,
					page : page
				},
				success : function(data) {

					var html = '';
					html += '<table >';
					html += '	<tr>';
					html += '	<th>번호</th>';
					html += '	<th>글 제목</th>';
					//html += '	<th>지역</th>';
					html += '	<th>상태</th>';
					html += '	<th>작성자</th>';
					html += '	<th>조회수</th>';
					html += '	<th>등록날짜</th>';
					html += '	</tr>';
					
					for (var i = 0; i < data.requestReg.length; i++) {
						html += '<tr>';
						html += ' <td class="tab_td">' + (i + data.startRow + 1) + '</td>';
								
								
						html += '<td class="title_td"><div class="clickTitle" onclick="detail(\''+data.requestReg[i].reqWriter+'\','+data.requestReg[i].reqIdx+','+data.requestReg[i].calDistance+','+data.requestReg[i].reqCount+')">'+data.requestReg[i].reqTitle+'</div></td>';		
						
						//html += ' <td>' + data.requestReg[i].reqAddr+ '</td>';
						

						var status, color;
						if (data.requestReg[i].reqStatus == 0) {
							status = '대기중';
							color = 'red';
						} else if (data.requestReg[i].reqStatus == 1) {
							status = '요청 완료';
							color = 'gray';
						}
						html += '	<td class="tab_td" style="color: '+color+'">';
						html += '		' + status + '';
						html += '</td>';
						
						html += ' <td class="tab_td">' + data.requestReg[i].reqWriter+ '</td>';
						
						html += ' <td class="tab_td">' + data.requestReg[i].reqCount+ '</td>';
						
						html += ' <td class="tab_td">' + data.requestReg[i].reqDateTime+ '</td>';
						
						html += '</tr>';
						}
					html += '</table>';
					
					if (data.pageTotalCount > 0) {
						
						 var paging ='';
						 	
						 if(pageEnd > data.pageTotalCount){
								pageEnd = data.pageTotalCount;
							} 
						 
							paging += '<span id="page_number"><button id="page_btn" onclick="prev('+page+')"><</button></span>';
							for (var m = pageStart; m <= pageEnd ; m++) {
								paging += '<span id="page_number">';
								paging += '	<button id="page_btn" ';
								if(page == m){
									paging += 'class="listlink"';
								}
								paging += ' href="#" onclick="listpage('+m+')" value="'+m+'">';
								paging +=  m ;
								paging += '	</button>';
								paging +='</span>';
							}
							paging += '<span id="page_number"><button id="page_btn" onclick="next('+page+','+data.pageTotalCount+')">></button></span>';
						 $('#page').html(paging);
						 $('#myList').html(html);
					} else{
							
							html ='<div class="w3-border" id="noBox"">';
							html +='<h5 id="noList">요청이 완료 된 게시물이 없습니다.</h5>';
							html +='</div>';
						$('#page').html('');
						$('#myList').html(html);
						$('#myList').css('margin-right','0px');
					}
				}
			});

		}

		$(document).ready(function() {
			list();
		});
	</script>

</body>
</html>