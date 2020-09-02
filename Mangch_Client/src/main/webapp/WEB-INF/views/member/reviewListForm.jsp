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
.avg{
	text-align: center;
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

#pageCon {
	margin-left: 33.2%;
}

.rtab button{
 background-color: inherit;
  float: left;
  border: none;
  outline: none;
  cursor: pointer;
  padding: 14px 16px;
  transition: 0.3s;
  font-size: 17px;
  width: 50%;
}

th, td{
	text-align: center;
}


</style>
</head>



<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div class="w3-container container">
		<h2>${loginInfo.mNick}님이작성한 리뷰</h2>
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
				<div id="reviewList" style="margin-right: 10%"></div>
				<div id="page"></div>
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />




	<script>
		
		var page = 1;
		
		
		function listpage(data) {
			page = data;
			list();
		}

		// 요청리스트 출력
		function list(status) {
			$.ajax({
						/* url : 'http://ec2-15-164-228-147.ap-northeast-2.compute.amazonaws.com:8080/rl/review/'
								+ '${loginInfo.mNick}', */
						url : 'http://localhost:8080/rl/review/'+ '${loginInfo.mNick}',
						type : 'GET',
						data : {
							page : page
						},
						success : function(data) {
							var html = '';
							
							html +='<div class="avg">';
							if (data.avg > 1) {
								html += '<span id="avg">'
										+ '${loginInfo.mNick}'+ '님 의 평점 &nbsp;&nbsp;</span>';
								for (var i = 1; i <= 5; i++) {
									if (data.avg <= i) {
										html += '<span style="font-size:25px;"">&#11088;</span>';
									}
								}

							} else {
								html += ' <h5>평점이 없습니다.</h5>';
							}
							
							html +='</div>';
							
							html +='<div class="rtab">';
							html +=' <button onclick="reviewRead('+status+')">작성 한 리뷰</button>';
							html +='<button onclick="reviewWrite('+status+')">작성 가능 한 리뷰</button>';
							html +='</div>';
							
							html += '<table class="w3-border w3-hoverable">';
							html += '	<tr class="w3-hover-grayscale">';
							html += '	<th>번호</th>';
							html += '	<th>게시글 제목</th>';
							html += '	<th>상대방</th>';
							html += '	<th>작성자</th>';
							if(status == 1){
								html += '	<th>내용</th>';
							}
							html += '	</tr>';
							
							var j = 0;
							if (data.reviewList.length > 0) {
								for (var i = 0; i < data.reviewList.length; i++) {
									
									if(data.reviewList[i].status == status){
										html += '<tr>';
										html += ' <td>' + (j + 1) + '</td>';
										
										
										if(status == 1){
										html += ' <td>'
												+ data.reviewList[i].reqList.reqTitle
												+ '</td>';
										}
										else if(status == 0){				
											html += ' <td><div onclick="reviewForm('+data.reviewList[i].reviewIdx+','+data.reviewList[i].status+')">'
											+ data.reviewList[i].reqList.reqTitle
											+ '</div></td>';	
										}
										html += ' <td>'
												+ data.reviewList[i].receiver
												+ '</td>';
										html += ' <td>' + data.reviewList[i].writer
												+ '</td>';
										if(status == 1){		
											html += ' <td>' + data.reviewList[i].text
													+ '</td>';
										}
										html += '</tr>';
										j++;
									}
									
								}

							} else {
								
								if(status == 1){
									html += '<td colspan="5">작성된 리뷰가 없습니다.</td>';
								}else {
									html += '<td colspan="4">작성된 리뷰가 없습니다.</td>';

								}
								
								/* html += '<td></td>';
								html += '<td>작성된 리뷰가 없습니다.</td>';
								html += '<td></td>';
								html += '<td></td>';
 */
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

							$('#reviewList').html(html);

						}
					});

		}
	
		
		function reviewRead(status){
			status=1;
			list(status);
		}
		
		function reviewWrite(status){
			status = 0;
			list(status);
		}
		
		function reviewForm(reviewIdx,rstatus){
			alert(reviewIdx);
			alert(rstatus);
			
			var form = $('<form></form>');
		    form.attr('action', '/mangh/review/reviewForm');
		    form.attr('method', 'post');
		    form.appendTo('body');
		    var idx = $("<input type='hidden' value="+reviewIdx+" name='reviewIdx'>"); //게시글 번호
		    var status = $("<input type='hidden' value="+rstatus+" name='rstatus'>"); //게시글 번호
		    form.append(idx);
		    form.append(status);
		    form.submit(); 
			
		}
		
		$(document).ready(function() {
			
			var status= 1;
			list(status);
			
		});
	</script>

</body>
</html>