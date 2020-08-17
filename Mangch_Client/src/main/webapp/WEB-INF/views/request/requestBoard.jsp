<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>요청 게시판</title>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.12.4.js"></script> 


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
			<div id="search"></div>
			<a href="<c:url value="/request/requestWrite"/>" class="w3-right" id="writer_button"></a>
		</div>

		<div class=" w3-margin-bottom" id="list"></div>
		
		<div class="paging">
		</div>

	</div>


	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
<script>
	
	
	/* 로그인 했을 때 와 안했을 때 위도 경도 */
	var mLttd,mLgtd,mRedisu;
	
	if ('${loginInfo}' != '') {
		mLttd = '${loginInfo.mLttd}';
		mLgtd = '${loginInfo.mLgtd}';
		mRadius = '${loginInfo.mRadius}';
	}else{
		mLttd = 0;
		mLgtd = 0;
		mRadius = 0;
	}	
	
	
	//페이징 처리 
	const  requestCountPage = 4; //한 페이지 당 표현 할 리스트 수 
  	var requestTotalCount; // 전체 리스트 개수 
  	var currentPageNumber=1; //현재 페이지 
	
		$.ajax({
				url : 'http://localhost:8080/rl/request',
				type : 'GET',
				data : {
					mLat : mLttd,
					mLon : mLgtd,
					mRadius : mRadius
				},
				success : function(data) {
					
				requestTotalCount = data.length;	
				
				 //전체 페이지 수 구하기 (전체 리스트 개수 / 한페지 당 출력 할 값 )
				  var pageTotalCount = requestTotalCount / requestCountPage;
				  
				  if (requestTotalCount % requestCountPage > 0) {
					  pageTotalCount++;
				  }
				  
				  var startRow = (currentPageNumber - 1) * requestCountPage;
				  
				  var endRow =  startRow + requestCountPage ;
				  
				  if(endRow > requestTotalCount){
					  endRow = requestTotalCount;
				  }
					
				$('#board_h1').text('게시물 리스트');
				var button = '<button class="w3-right">글쓰기</button>';
				$('#writer_button').append(button);
				
				var search='<input type="text" id="search_text" placeholder="검색어를 입력하세요" >';
				search +='<input type="button" id="search_btn" onclick="search()" value="검색">';
				$('#search').append(search);
				
				
				var html = '';
				html +='<table class="w3-table w3-border w3-hoverable">';
				html += '	<tr class="w3-hover-grayscale">';
				html += '	<th>번호</th>';
				html += '	<th>글 제목</th>';
				html += '	<th>지역</th>';
				if('${loginInfo}' != ''){
					html += '	<td>거리</td>';
				}
				html += '	<th>상태</th>';
				html += '	<th>작성자</th>';
				html += '	<th>조회수</th>';
				html += '	<th>등록날짜</th>';
				
				html += '	</tr>';
				
				if(requestTotalCount >0){
				for (var i = startRow; i < endRow; i++) {
						html += '<tr>';
						html += ' <td>' + (i+1) + '</td>';
						html += ' <td> <a href="<c:url value="/request/requestDetail?idx='+ data[i].reqIdx+'" />" >'+ data[i].reqTitle + '</a></td>';
						html += ' <td>' + data[i].reqAddr + '</td>';
						//회원 로그인 상태 일 때 거리 출력
						if('${loginInfo}' != ''){
							html += ' <td>' +data[i].distance+ ' m</td>';
						}
						
						var status ,color;
						if(data[i].reqStatus == 0){
							status = '대기중';
							color = 'red';
						}else if(data[i].reqStatus == 1){
							status = '요청 완료';
							color = 'gray';
						}
						html +='	<td style="color: '+color+'">';
						html +='		'+status+'';
						html += '</td>';
						html += ' <td>' + data[i].reqWriter + '</td>';
						html += ' <td>' + data[i].reqCount + '</td>';
						html += ' <td>' + data[i].reqDateTime + '</td>';
						
						html += '</tr>';
					}
				
				} else{
					alert('게시물이 없습니다.');
				}
				
				
				if(pageTotalCount >0 ){
					
					for(var m=1;m<=pageTotalCount;m++){		 
						
						var link = document.location.href; 
						
						var page ='<a id="listlink" ';
						page +='href="#" onclick=page('+m+')';	
						page +=">";
						page +='['+m+']';
						page +='</a>';
						
						$('.paging').append(page);
					}	
				}
				
					
					html += '</table>';
					$('#list').html(html);
				}
				  
				  	  

			});
	
			
		function page(currentPage){
					
				currentPageNumber = currentPage;
			
				$.ajax({
					url : 'http://localhost:8080/rl/request',
					type : 'GET',
					data : {
						mLat : mLttd,
						mLon : mLgtd,
						mRadius : mRadius
					},
				success : function(data) {
						
				  var startRow = (currentPageNumber - 1) * requestCountPage;
				  
				  var endRow =  startRow + requestCountPage ;
				  
				  if(endRow > requestTotalCount){
					  endRow = requestTotalCount;
				  }
					
						
					$('#board_h1').text('게시물 리스트');
					
					
					var html = '';
					html +='<table class="w3-table w3-border w3-hoverable">';
					html += '	<tr class="w3-hover-grayscale">';
					html += '	<th>번호</th>';
					html += '	<th>글 제목</th>';
					html += '	<th>지역</th>';
					if('${loginInfo}' != ''){
						html += '	<td>거리</td>';
					}
					html += '	<th>상태</th>';
					html += '	<th>작성자</th>';
					html += '	<th>조회수</th>';
					html += '	<th>등록날짜</th>';
					
					html += '	</tr>';
					
					
					if(requestTotalCount >0){
						for (var i = startRow; i < endRow; i++) {
							html += '<tr>';
							html += ' <td>' + (i+1) + '</td>';
							html += ' <td> <a href="<c:url value="/request/requestDetail?idx='+ data[i].reqIdx+'" />" >'+ data[i].reqTitle + '</a></td>';
							html += ' <td>' + data[i].reqAddr + '</td>';
							//회원 로그인 상태 일 때 거리 출력
							if('${loginInfo}' != ''){
								html += ' <td>' +data[i].distance+ ' m</td>';
							}
							
							var status ,color;
							if(data[i].reqStatus == 0){
								status = '대기중';
								color = 'red';
							}else if(data[i].reqStatus == 1){
								status = '요청 완료';
								color = 'gray';
							}
							html +='	<td style="color: '+color+'">';
							html +='		'+status+'';
							html += '</td>';
							html += ' <td>' + data[i].reqWriter + '</td>';
							html += ' <td>' + data[i].reqCount + '</td>';
							html += ' <td>' + data[i].reqDateTime + '</td>';
							
							html += '</tr>';
						}
						 
					} else{
						alert('게시물이 없습니다.');
					}
					
							html += '</table>';
							$('#list').html(html);
					}

				});
		
				
			}
		
		
		function search(){
			
			console.log	($('#search_text').val());
			
		}
				
		
		
		
</script>

</html>