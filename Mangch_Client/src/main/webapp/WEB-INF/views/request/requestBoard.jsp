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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69c40691beee2a7bf82c96e2f85f0da8"></script>
	
	

<link rel="stylesheet" href="<c:url value="/resources/css/jin.css"/>">
<style>
	#backImg{
		/* background-image: url("/mangh/resources/img/back.jpg"); */
		background-image: url("https://image.freepik.com/free-vector/couple-reading-goods-reviews-smartphone-line-illustration_241107-200.jpgg");
	    background-repeat: no-repeat;
		background-size: 150px, 150px; 
	}
	
	#mapBtn{
	 background: url( "/mangh/resources/img/map.png" ) no-repeat;
		 border: none;
        width: 64px;
        height: 64px;
        cursor: pointer;
	}
	#mapBox{
		text-align: right;
	}
	
</style>

</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	
	

	<!-- 배경이미지 ? -->
	<!-- <div id="backImg"> 
		<h1 style="color: white;">안녕</h1>
	</div> -->
	
	<div class="w3-content">
		<h3 id="boardTitle">요청 게시판</h3>
	</div>
	
	
	<div class="w3-content" id="conBox">
	
		<!-- <div id="searchBox"> -->
		<div class="w3-left">
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
		<input type="text" id="search_text" placeholder="검색어를 입력하세요">
		<input type="button" class="allBtn" id="search_btn" onclick="search()" value="검색">
		</div>
		
		<!-- <div id="mapBox"> -->
		<div class="w3-right">
		<input type="button" id="mapBtn" onclick="map()">
		</div>
		
	</div>
	
	
<!-- 	<div class="w3-content" id="conBox">
	
	</div> -->
	

	<div class="w3-content">
	
		<!-- 글쓰기 (왼)-->
		<!-- <div id="writeBox">
			<ul>
				<li>
					<button id="writer_button" onclick="location.href='/mangh/request/requestWrite'">요청 등록</button>
				</li>
			</ul>
		</div> -->
		<!-- 테이블 출력 (오)-->
		<div id="list"></div>
	</div>
	
	<div class="w3-content" id="conBox">
		<button id="writer_button" onclick="location.href='/mangh/request/requestWrite'">요청 등록</button>
	</div>
	
	<!-- 페이지  -->
	<div class="w3-content" id="page"></div>
	
	<!-- 지도로보기 모달 창 -->
	<div class="w3-modal" id="mapModal">
		<div class="w3-modal-content" style="height:600px;">
			 <header class="w3-container">
			 <span onclick="modalClose('+')" class="w3-button w3-display-topright">&times;</span>
			 <h2>지도로보기</h2>
			 </header>
			<div class="w3-content" id="map" style="width:60%;height:400px;"></div>
	
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
<script>

/* 로그인 했을 때 와 안했을 때 위도 경도 */
	var mLttd, mLgtd, mRedisu;
	var page = 1; //현재 페이지 번호
	var pageStart = 1; // 페이지 시작 수 
	var pageEnd = 2; // 페이지 끝 수   
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
	
	
	//지도로 보기
	//모달 닫기
	function modalClose(){
	$('#mapModal').css('display','none');
	}
	
	function map(){
		
			
		
		$.ajax({
//			url : 'http://ec2-15-164-228-147.ap-northeast-2.compute.amazonaws.com:8080/rl/request',
			url : 'http://localhost:8080/rl/request/map/'+mRadius,
			type : 'GET',
			data : {
				mLat : mLttd,
				mLon : mLgtd,
			},
			success : function(data) {		
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
			    mapOption = { 
//			        center: new kakao.maps.LatLng('${loginInfo.mLttd}', '${loginInfo.mLgtd}'), // 지도의 중심좌표
					   center: new kakao.maps.LatLng(37.537183, 127.005454), // 회원 로그인 상태에서의 중심 좌표 표시 
					level: 4 // 지도의 확대 레벨
			    };	

				var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
				$('#mapModal').css('display','block');	
				map.relayout(); //지도 영역 크기 설정 
				
				//var dataList = new Array(); // 동일 주소 배열을 담을 배열
				
				var html = '';
				
				for(var i=0;i<data.length;i++){
			
					//주소가 동일 데이터 출력
				  //주소가 같을 때 마커를 한개 생성하고
				   var marker = new kakao.maps.Marker({
		      		  map: map, // 마커를 표시할 지도
			       	  position: new kakao.maps.LatLng(data[i].reqLatitude, data[i].reqLongitude)// 마커의 위치
				    });
					  
					  
					//var reqData = new Array(); //동일 주소 객체를 담을 배열 - 인덱스가 증가 할 때 새로 생성해준다 
					
					/* reqData.push(data[i]); */

					html +='<div>'+data[i].reqTitle+'</div>';
					
					for(var j=i+1;j<data.length;j++){
						
						if(data[i].reqAddr == data[j].reqAddr){
							//마커에 출력할 데이터	- 출력 할 배열이 필요함					
							
							html += '<div>'+data[j].reqTitle+'</div>';
							
						    /* reqData.push(data[j]); */
						    
						    data.splice(j,1);
							j--;
						}
					} 
				  /*   dataList.push(reqData); */
					
					// 마커에 표시할 인포윈도우를 생성합니다 
				    var infowindow = new kakao.maps.InfoWindow({
				        content: html// 인포윈도우에 표시할 내용
				    });
					
				    infowindow.open(map, marker);  
					 html = '';
				}
				map.setCenter(new kakao.maps.LatLng(mLttd, mLgtd));
				map.relayout(); //지도 영역 크기 설정 
				
				
			}
		});
		
		
		
		 
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
		
		if(page > 1){
			pageStart = pageStart-2;
			pageEnd = pageEnd-2;
		}else{
			pageStart = 1;
			pageEnd = 2;
		}
		
		if(page == 0){
			console.log('현재 페이지 '+page);
			alert('첫 페이지 입니다.');
		}else{
			list();
		}
	}
	//마지막 페이지
	function next(data,totalCnt){
		page = data + 1;
		
		if(page > totalCnt){
			alert('마지막 페이지 입니다.');			
		}else{
			if(page > pageEnd){
				pageStart = pageStart+2;
				pageEnd = pageEnd+2;
			}
			list();
		}
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
//								for (var m = 1; m <= data.pageTotalCount; m++) {
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
							 $('#list').html(html);
						} else{
							
							/* alert('검색 결과가 없습니다.');
							page = 1;
							history.go(0); */
							alert('게시글이 없습니다.');
							
						}
						
					}
				});
	}
	$(document).ready(function() {
		
		list();
		
		
	});
</script>

</html>