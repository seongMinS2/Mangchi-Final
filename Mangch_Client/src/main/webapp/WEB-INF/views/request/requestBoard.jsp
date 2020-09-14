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
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69c40691beee2a7bf82c96e2f85f0da8"></script>



<link rel="stylesheet" href="<c:url value="/resources/css/jin.css"/>">
<style>

/* 테이블 설정 */
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

.wrap {
	position: absolute;
	left: 0;
	bottom: 40px;
	width: 288px;
	height: 160px;
	margin-left: -144px;
	text-align: left;
	overflow: hidden;
	font-size: 12px;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	line-height: 1.5;
	margin-bottom: 5px;
}

.wrap * {
	padding: 0;
	margin: 0;
}

.wrap .info {
	width: 286px;
	height: 160px;
	border-radius: 5px;
	border-bottom: 2px solid #ccc;
	border-right: 1px solid #ccc;
	overflow: scroll;
	background: #fff;
}

.wrap .info:nth-child(1) {
	border: 0;
	box-shadow: 0px 1px 2px #888;
}

.info .title {
	border-radius: 5px 5px 0px 0px;
	padding: 5px 5px 10px 10px;
	height: 35px;
	background: #eee;
	border-bottom: 1px solid #ddd;
	font-size: 18px;
	font-weight: bold;
	text-align: center;
}


.info .body {
	position: relative;
	overflow: hidden;
	margin: 10px;
}

s .info .desc {
	position: relative;
	margin: 13px 0 0 90px;
	height: 75px;
}

.desc .ellipsis {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	padding-bottom: 8px;
	font-size: 15px;
	font-weight: bold;
}

.desc .jibun {
	font-size: 12px;
	color: #888;
	margin-top: -2px;
	padding-bottom: 8px;
	font-weight: 600;
}

#line {
	padding: 3px;
}

.maplink {
	color: #4072cf;
	font-weight: bold;
}
</style>

</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />


	<div class="w3-content">
		<h3 id="boardTitle">요청 게시판</h3>
	</div>



	<div class="w3-content" class="searchBox">
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
			<input type="button" class="allBtn" id="searchbtn" onclick="search()"
				value="검색">
		</div>

		<div class="rightbox">

			<div class="tooltip">
				<input type="button" id="mapBtn" onclick="map()"> <span
					class="tooltiptext">지도로 보기</span>
			</div>
		</div>

	</div>
	<!-- 게시글 리스트 -->
	<div class="w3-content" id="listBox">
		<div id="list"></div>
	</div>

	<!-- 게시글 등록 -->
	<div class="w3-content rightbox">
		<button id="writeBtn" class="allBtn"
			onclick="location.href='/mangh/request/requestWrite'">요청 등록</button>
	</div>

	<!-- 페이지  -->
	<div class="w3-content" id="page"></div>

	<!-- 지도로보기 모달 창 -->
	<div class="w3-modal" id="mapModal">
		<div class="w3-modal-content" style="height: 600px;">
			<header class="w3-container">
				<span onclick="modalClose()" class="w3-button w3-display-topright">&times;</span>
				<h2>지도로보기</h2>
			</header>
			<div class="w3-content" id="map" style="width: 60%; height: 400px;"></div>

		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
<script>

/* 로그인 했을 때 와 안했을 때 위도 경도 */
	var mLttd, mLgtd, mRedisu;
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
	
	
	var contents = [];
	var mapCon;
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
		   center: new kakao.maps.LatLng(37.537183, 127.005454), // 회원 로그인 상태에서의 중심 좌표 표시 
		level: 4 // 지도의 확대 레벨
    };	
	
	
	mapCon = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	var overlayArr = [];
	var overlay=null;
	
	function modalClose(){
		$('#mapModal').css('display','none');
		for(var m=0;m<overlayArr.length ;m++){
    		overlayArr[m].setMap(null);
    	}
	}
	
	
	function map(){
		
		if('${loginInfo}' == ''){
		
			alert('로그인 후 이용해주세요.');
			 location.href="/mangh/member/memberLogin"; 
		} else{
		
		$.ajax({
			url : 'http://ec2-52-79-249-25.ap-northeast-2.compute.amazonaws.com:8080/rl/request/map/'+mRadius,
			//url : 'http://localhost:8080/rl/request/map/'+mRadius,
			type : 'GET',
			data : {
				mLat : mLttd,
				mLon : mLgtd,
			},
			success : function(data) {		

				$('#mapModal').css('display','block');	
				mapCon.relayout(); //지도 영역 크기 설정 
				var html = '';
				for(var i=0;i<data.length;i++){
					
					
					//주소가 동일 데이터 출력
				  //주소가 같을 때 마커를 한개 생성하고
				    marker = new kakao.maps.Marker({
		      		  map: mapCon, // 마커를 표시할 지도
			       	  position: new kakao.maps.LatLng(data[i].reqLatitude, data[i].reqLongitude),
			       	  title : i
				    });
					
				   html +='<div class="wrap">' ;
				   html += '    <div class="info">' ;
				   html += '        <div class="title clickTitle">' +data[i].reqAddr+' </div>' ;
				   html +=  '        <div class="body">' ;
					
					//html +=  '            <div class="desc">' ;
						html +=  '            <div class="desc">' ;
						html +=  '                <div class="ellipsis clickTitle"><a href="#" class="maplink" onclick="detail(\''+data[i].reqWriter+'\','+data[i].reqIdx+','+data[i].calDistance+','+data[i].reqCount+')">'+data[i].reqTitle+'</a></div>' ;
						//회원 로그인 상태 일 때 거리 출력
						if( data[i].calDistance >= 1000){
							var calDistance = data[i].calDistance;
							calDistance = (Math.round(calDistance/100))/10;
							html +='				 <div class="jibun ">'+data[i].reqWriter+' · '+calDistance+'km</div>';
						}else{
							html +='				 <div class="jibun ">'+data[i].reqWriter+' · '+data[i].calDistance+'m</div>';
						}	
						html += '<hr id="line">';
					for(var j=i+1;j<data.length;j++){
						if(data[i].reqAddr == data[j].reqAddr){
							html +='';
							html +=  '                <div class="ellipsis clickTitle"><a href="#" class="maplink" onclick="detail(\''+data[j].reqWriter+'\','+data[j].reqIdx+','+data[j].calDistance+','+data[j].reqCount+')">'+data[j].reqTitle+'</a></div>' ;
							//회원 로그인 상태 일 때 거리 출력
							if( data[j].calDistance >= 1000){
								var calDistance = data[j].calDistance;
								calDistance = (Math.round(calDistance/100))/10;
								html +='				 <div class="jibun ellipsis">'+data[j].reqWriter+' · '+calDistance+'km</div>';
							}else{
								html +='				 <div class="jibun ellipsis">'+data[j].reqWriter+' · '+data[j].calDistance+'m</div>';
							}	
							html += '<hr id="line">';
							console.log(data[j].reqTitle);
						    data.splice(j,1);
							j--;
						}
					}
					 html +='            </div>' ; 
					 html += '        </div>' ;
					 html +=   '    </div>' ;
					 html +=  '</div>';
					 
				    
				    // 커스텀 오버레이 배열에 값을 추가한다.
				    contents.push(html);
				    html +='';
				    
				    kakao.maps.event.addListener(marker, 'mouseover', 
				    		openListener(mapCon, marker, contents[i]));
				    
				    
				    
				    
				    
					 
				}//for문
				
				mapCon.setCenter(new kakao.maps.LatLng(mLttd, mLgtd));
				mapCon.relayout(); //지도 영역 크기 설정 
			}			
		});
		}
	}
	
	
	
	
	//오버레이 창 열기
	function openListener(map, marker, content)
	{
		
		
		return function(){
	    	
			
			/* marker2 = new kakao.maps.Marker({
	      		  map: mapCon, // 마커를 표시할 지도
		       	  position: marker.getPosition(),// 마커의 위치
		       	  title : title
		    });  */
			
			
    	   overlay = new daum.maps.CustomOverlay({
			        position:marker.getPosition(),
			        content: content
		    });
    	   
    	   overlayArr.push(overlay);
    	   
    	   
    	   console.log(marker.getPosition());
	    	  
	        overlay.setMap(map);
	        
       		//kakao.maps.event.addListener(marker, 'click', closeListener(map,marker,overlay));
       		
	        kakao.maps.event.addListener(marker, 'click', 
		    		closeListener(mapCon, marker, overlay));
		}
	}
	
	//오버레이 창 닫기 
	function closeListener(map,marker,overlay){
			
		
		return function(){
			
			overlay.setMap(null);
			
			//kakao.maps.event.addListener(marker, 'click', openListener(map, marker, overlay.getContent()));
		}
	}
	
	
	
	//리스트 검색
	function search(){
		searchText = $('#search_text').val();
		searchType = $('#searchType').val(); 
		page = 1;
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
	
	
	//페이지 처리 
	var page = 1; //현재 페이지 번호
	var pageStart = 1; // 페이지 시작 수 
	var pageEnd = pageStart+3; // 페이지 끝 수   
	
	//리스트 페이징 처리
	function listpage(data) {
		page = data;
		list();
	}
	
	//이전 페이지
	function prev(data){
		page = data - 1;
		if(page == 0){
			console.log('현재 페이지 '+page);
			alert('첫 페이지 입니다.');

			page = 1;
			pageStart = 1;
			pageEnd = pageStart+3;
		
		}else{
			if(page < pageStart){
				pageStart = pageStart-page;
				pageEnd = page; 
			}
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
				pageStart = page;
				pageEnd = pageEnd+3;
			}
			list();
		}
	}
	
	function list() {
		$.ajax({
					url : 'http://ec2-52-79-249-25.ap-northeast-2.compute.amazonaws.com:8080/rl/request',
			//		url : 'http://localhost:8080/rl/request',
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
						
						/* var search = '<input type="text" id="search_text" placeholder="검색어를 입력하세요" >';
						search += '<input type="button" id="search_btn" onclick="search()" value="검색">';
						$('#search').html(search); */

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
									
									
							html += '<td class="title_td"><div class="clickTitle" onclick="detail(\''+data.requestReg[i].reqWriter+'\','+data.requestReg[i].reqIdx+','+data.requestReg[i].calDistance+','+data.requestReg[i].reqCount+')">'+data.requestReg[i].reqTitle+'</div></td>';		
							
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
							 	
							
							 if(pageEnd > data.pageTotalCount){
								pageEnd = data.pageTotalCount;
							} 
							
							 
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
							
							
							html ='<div class="w3-border" id="noBox"">';
							html +='<h5 id="noList">내 주변에 존재 하는 게시글이 없습니다.</h5><br><h5 id="noList">다른 요청 글을 보시려면 요청 거리을 재설정 해주세요.</h5>';
							
							html +='</div>';
							
							 $('#list').html(html);
							
						}
						
					}
				});
	}
	$(document).ready(function() {
		
		list();
		
		
	});
</script>

</html>