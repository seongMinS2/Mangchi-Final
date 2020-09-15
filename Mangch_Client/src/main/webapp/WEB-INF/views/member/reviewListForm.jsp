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
#avg {
	font-size: 120%;
}
.avg{
	text-align: center;
	margin-bottom: 15px;
	
}

.rtab{
	width: 100%;
    margin-left: 8%;
}

.reBtn{
	color: #dadada;
    font-size: large;
    font-weight: bold;
}
.changeBtn{
	color:black;
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
  margin-bottom: 20px;
}

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
		<h2>${loginInfo.mNick}님이작성한 리뷰</h2>
		<hr>

		<div class="w3-cell-row">
			<!-- <div class="w3-cell" style="width: 25%"> -->
			<div style="width: 25%">
				<div id="profile-menu" class="active">
					<a href="requestListForm">요청 리스트</a> <a href="lendingListForm">대여리스트</a>
					<a href="reviewListForm">나의 리뷰</a> <a href="commentListForm">나의
						댓글</a> <a href="mypageForm">나의 정보</a> <a href="distSetForm">거리 설정</a>
					<a href="keywordSetForm">키워드 설정</a>
				</div>
			</div>
			<div class="w3-cell"  id="myBox" style="width: 75%">
				<div id="myList"></div>
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
						url : 'http://ec2-52-79-249-25.ap-northeast-2.compute.amazonaws.com:8080/rl/review/'+ '${loginInfo.mNick}', 
						//url : 'http://localhost:8080/rl/review/'+ '${loginInfo.mNick}',
						type : 'GET',
						data : {
							page : page
						},
						success : function(data) {
							var html = '';
							
							html +='<div class="rtab">';
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
							
							html +='<button class="reBtn ';
							if(status == 1){
								html +='changeBtn"';
							} 
							html +='"';
							html +='onclick="reviewRead('+status+')">작성 한 리뷰</button>';
							
							html +='<button class="reBtn ';
							if(status == 0){
								html +='changeBtn"';
							}
							
							
							html +='"';
							html += 'onclick="reviewWrite('+status+')">작성 가능 한 리뷰</button>';
							
							html +='</div>';
							
							html += '<table >';
							html += '	<tr>';
							html += '	<th>번호</th>';
							html += '	<th>게시글 제목</th>';
							html += '	<th>상대방</th>';
							html += '	<th>작성자</th>';
							if(status == 1){
								html += '	<th>내용</th>';
							}
							html += '	</tr>';
							
							var j = 0;
								for (var i = 0; i < data.reviewList.length; i++) {
									
									if(data.reviewList[i].status == status){
										html += '<tr>';
										html += ' <td class="tab_td">' + (j + 1) + '</td>';
										
										if(status == 1){
										html += ' <td class="tab_td">'+ data.reviewList[i].reqList.reqTitle+ '</td>';
										}
										else if(status == 0){				
											html += ' <td class="title_td"><div class="clickTitle" onclick="reviewForm('+data.reviewList[i].reviewIdx+','+data.reviewList[i].status+',\''+data.reviewList[i].receiver+'\')">'
											+ data.reviewList[i].reqList.reqTitle
											+ '</div></td>';	
										}
										html += ' <td class="tab_td">'+ data.reviewList[i].receiver+ '</td>';
										html += ' <td class="tab_td">' + data.reviewList[i].writer+ '</td>';
										if(status == 1){		
											html += ' <td class="tab_td">' + data.reviewList[i].text+ '</td>';
										}
										html += '</tr>';
										j++;
									}
									
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
								 
							}else{
								
								html ='<div class="w3-border" id="noBox"">';
								html +='<h5 id="noList">작성 할 수 있는 리뷰가 없습니다.</h5>';
								html +='</div>';
							
								$('#page').html('');
								$('#myList').html(html);
								$('#myList').css('margin-right','0px');
							}
							 

						}
					});

		}
	
		function reviewRead(status){
//			$('#rCom').addClass('reBtn');
			status=1;
			list(status); 
		}
		
		function reviewWrite(status){
			status = 0;
			list(status);
			$('#rICom').addClass('reBtn');
		}
		
		function reviewForm(reviewIdx,rstatus,receiver){
			var form = $('<form></form>');
		    form.attr('action', '/mangh/review/reviewForm');
		    form.attr('method', 'post');
		    form.appendTo('body');
		    var idx = $("<input type='hidden' value="+reviewIdx+" name='reviewIdx'>"); //게시글 번호
		    var status = $("<input type='hidden' value="+rstatus+" name='rstatus'>"); //게시글 번호
		    var reviewReceiver = $("<input type='hidden' value="+receiver+" name='receiver'>"); //게시글 번호
		    form.append(idx);
		    form.append(status);
		    form.append(reviewReceiver);
		    form.submit(); 
			
		}
		
		$(document).ready(function() {
			
			var status= 1;
			list(status);
			
		});
	</script>

</body>
</html>