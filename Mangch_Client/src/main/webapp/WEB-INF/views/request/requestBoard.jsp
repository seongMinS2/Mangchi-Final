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

<link rel="stylesheet" href="<c:url value="/resources/css/jin.css"/>">
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />

	<!-- <div class="w3-container" id="contain"> -->
	<div class="w3-content" id="conBox">

		<!-- 검색 타입 -->
		<select id="searchType">
			<option value="title">제목</option>
			<option value="name">이름</option>
		</select>

		<!-- 거리순 -->
		<select id="ListType" onchange="change()">
			<c:if test="${loginInfo.mNick !=null}">
				<option value="distance">거리순</option>
			</c:if>
			<option value="date">최신순</option>
		</select>

		<!-- 검색어 입력 -->
		<!-- <div id="search" > -->
		<input type="text" id="search_text" placeholder="검색어를 입력하세요">
		<input type="button" id="search_btn" onclick="search()" value="검색">
		<!-- </div> -->

		<!-- 글쓰기 -->
		<a href="<c:url value="/request/requestWrite"/>" id="writer_button"></a>

	</div>
	<!-- </div>	 -->

	<div class="w3-content w3-margin-bottom">
		<!-- 테이블 출력 -->
		<div class=" w3-margin-bottom" id="list"></div>
	</div>


	<!-- 페이지  -->
	<div class="w3-content w3-margin-bottom" id="page"></div>


	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
<script>

/* 로그인 했을 때 와 안했을 때 위도 경도 */
	var mLttd, mLgtd, mRedisu;
	var page = 1;
	var type;
	var searchText = $('#search_text').val();
	var searchType = $('#searchType').val(); 
	
	//사용자 위도 경도
	if ('${loginInfo}' != '') {
		mLttd = '${loginInfo.mLttd}';
		mLgtd = '${loginInfo.mLgtd}';
		mRadius = '${loginInfo.mRadius}'; 
	} else {
		mLttd = 0;
		mLgtd = 0;
		mRadius = 0;
	}

	//회원 . 비회원 첫 화면 출력 할 때 type 설정
	if('${loginInfo}' == ''){
		type = 'date';
	}else {
		type = 'distance';
	}

	//리스트 검색
	function search(){
		searchText = $('#search_text').val();
		searchType = $('#searchType').val(); 
		page = 1;
		list();
	}
	
	//리스트 페이징 처리
	function listpage(data) {
		page = data;
		list();
	}
	
	//거리순 & 최신순
	function change() {
		type = $('#ListType').val();
		list();
	}

	function detail(reqWriter,reqIdx,calDistance,reqCount){
		 var form = $('<form></form>');
		    form.attr('action', '/mangh/request/requestDetail');
		    form.attr('method', 'post');
		    form.appendTo('body');
		    var idx = $("<input type='hidden' value="+reqIdx+" name='idx'>"); //게시글 번호
		    var distance = $("<input type='hidden' value="+calDistance+" name='distance'>"); //게시글 거리
		    var count = $("<input type='hidden' value="+reqCount+" name='count'>"); //게시글 상태 
		    var rWriter = $("<input type='hidden' value="+reqWriter+" name='writer'>"); //게시글 작성자 
		    form.append(idx);
		    form.append(distance);
		    form.append(count);
		    form.append(rWriter);
		    form.submit(); 
	}
	
	
	//이전 페이지
	function prev(data){
		page = data - 1;
		list();
	}
	//마지막 페이지
	function next(data){
		page = data + 1;
		list();
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
						html += '<table style="table-layout: fixed" >';
						html += '	<tr>';
						html += '	<th>번호</th>';
						html += '	<th>글 제목</th>';
						//html += '	<th>지역</th>';
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
							html += ' <td class="tab_td">' + (i + data.startRow + 1) + '</td>';
									
									
							html += '<td class="title_td"><div onclick="detail(\''+data.requestReg[i].reqWriter+'\','+data.requestReg[i].reqIdx+','+data.requestReg[i].calDistance+','+data.requestReg[i].reqCount+')">'+data.requestReg[i].reqTitle+'width="4%123123131321311212121212121212121212121212121212</div></td>';		
							
							//html += ' <td>' + data.requestReg[i].reqAddr+ '</td>';
							
							
							//회원 로그인 상태 일 때 거리 출력
							if ('${loginInfo}' != '') {
							if( data.requestReg[i].calDistance >= 1000){
								var calDistance = data.requestReg[i].calDistance;
								calDistance = (Math.round(calDistance/100))/10;
								html += ' <td class="tab_td">' + calDistance
								+ ' km</td>';
							}else{
								html += ' <td class="tab_td">' + data.requestReg[i].calDistance+ ' m</td>';
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
							 
								paging += '<span id="page_number"><button id="page_btn" onclick="prev('+page+')"><</button></span>';
								for (var m = 1; m <= data.pageTotalCount; m++) {
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
								paging += '<span id="page_number"><button id="page_btn" onclick="next('+page+')">></button></span>';
						} 
						 $('#list').html(html);
						 $('#page').html(paging);
						
					}
				});
	}
	$(document).ready(function() {
		
		list();
		
		
	});
</script>

</html>