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

#search{
	width: 65%;
}

#search_text{
	 width:90%;
	margin-right: 15px;
}

select {

    width: 50px; /* 원하는 너비설정 */
    border: 1px solid #999;
    border-radius: 0px; /* iOS 둥근모서리 제거 */
    -webkit-appearance: none; /* 네이티브 외형 감추기 */
    -moz-appearance: none;
    appearance: none;
}

.jtype{
float: left;
padding: 15px 16px;
margin : 20px;
}

.pagination li {
	float: left;
	padding: 10px 20px;
}

.pagination li> a {
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
  box-shadow:
  0 0.3px 0.6px rgba(0, 0, 0, 0.056),
  0 0.7px 1.3px rgba(0, 0, 0, 0.081),
  0 1.3px 2.5px rgba(0, 0, 0, 0.1),
  0 2.2px 4.5px rgba(0, 0, 0, 0.119),
  0 4.2px 8.4px rgba(0, 0, 0, 0.144),
  0 10px 20px rgba(0, 0, 0, 0.2);
  list-style-type: none;
  float: left;
  justify-content: center;
}

th ,td {
	text-align: center;	
}

#pageCon{

	margin: 0 auto;
	margin-left: 43.2%;
}

</style>

</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />

	<div class="w3-auto">
		<div class="w3-container w3-margin-bottom">
				<!-- 검색 타입 -->
				<div class="jtype">
					<select id="searchType">
						<option value="title">제목</option>
						<option value="name">이름</option>
					</select>
					<!-- 거리순 -->
					<c:if test="${loginInfo.mNick !=null}">
					<select id="ListType" onchange="change()">
						<option value="distance">거리순</option>
						<option value="date">최신순</option>
					</select> 
					</c:if>
				</div>
				<!-- 검색어 입력 -->
				<div id="search" class="jtype">
				<input type="text" id="search_text" placeholder="검색어를 입력하세요" >	
				<input type="button" id="search_btn" onclick="search()" value="검색">
				</div>
				<!-- 글쓰기 -->					
				<div class="jtype">
				 <a href="<c:url value="/request/requestWrite"/>" id="writer_button"></a>
				</div>
		</div>
			
		<div class="w3-container w3-margin-bottom">
			<!-- 테이블 출력 -->
			<div class=" w3-margin-bottom" id="list"></div>
		</div>
	</div>	
		<div class="w3-container" id="pageCon">
			<div class=" w3-margin-bottom" id="page"></div>
		</div>


	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
<script>

/* 로그인 했을 때 와 안했을 때 위도 경도 */
	var mLttd, mLgtd, mRedisu;

	if ('${loginInfo}' != '') {
		mLttd = '${loginInfo.mLttd}';
		mLgtd = '${loginInfo.mLgtd}';
		mRadius = '${loginInfo.mRadius}'; 
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
	
	function list() {
		$.ajax({
//					url : 'http://ec2-15-164-228-147.ap-northeast-2.compute.amazonaws.com:8080/rl/request',
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
						
						
						var button = '<button>글쓰기</button>';
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
							html += '	<th>거리</th>';
						}
						html += '	<th>상태</th>';
						html += '	<th>작성자</th>';
						html += '	<th>조회수</th>';
						html += '	<th>등록날짜</th>';

						html += '	</tr>';

						for (var i = 0; i < data.requestReg.length; i++) {
							html += '<tr>';
							html += ' <td>' + (i + data.startRow + 1) + '</td>';
						/* 	 html += ' <td> <a href="<c:url value="/request/requestDetail?idx='
									+ data.requestReg[i].reqIdx +'&distance='+data.requestReg[i].calDistance+'&count='+data.requestReg[i].reqCount
									+ '" />" >'
									+ data.requestReg[i].reqTitle + '</a></td>'; */
									
									
							html += '<td><div onclick="detail('+data.requestReg[i].reqIdx+','+data.requestReg[i].calDistance+','+data.requestReg[i].reqCount+')">'+data.requestReg[i].reqTitle+'</div></td>';		
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
							 
							var page = '<ul class="pagination ">'; 
									for (var m = 1; m <= data.pageTotalCount; m++) {
										page +=  '<li class="page-number>';
										page += '	<a id="listlink" href="#" onclick="listpage(' +m+ ')" >';
										page +=  m ;
										page += '	</a>';
										page += '</li>';
									}
									page += '</ul>';
							
						} 
						$('#page').html(page); 
						 
						$('#list').html(html);

					}
				});
	}
	$(document).ready(function() {
		list();
	});
</script>

</html>