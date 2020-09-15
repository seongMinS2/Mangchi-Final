var headerCheck=1;	

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
							
							if(searchText != '' || searchText.length > 0){
								html ='<div class="w3-border" id="noBox"">';
								html +='<h5 id="noList">검색결과가 없습니다. 다른 검색어를 입력하세요.</h5>';
								html +='</div>';
							} else{
								
								html ='<div class="w3-border" id="noBox"">';
								html +='<h5 id="noList">내 주변에 존재 하는 게시글이 없습니다.</h5><br><h5 id="noList">다른 요청 글을 보시려면 요청 거리을 재설정 해주세요.</h5>';
								html +='</div>';
							}
							
							$('#page').html('');
							$('#list').html(html);
							
						}
						
					}
				});
	}


//헤더 검색
function headerSearch (login,memLat,memLon,radius){
headerCheck = 2;
searchText = $('#headerText').val(); //검색어
location.href=''+contextPath+'/request/requestList?headerCheck='+headerCheck+'&text='+searchText;

}

//오버레이 창 열기
function openListener(map, marker, content){
	return function(){
		if(mapCon.getCenter() != marker.getPosition()){
			for(var m=0;m<overlayArr.length ;m++){
	    		overlayArr[m].setMap(null);
	    	}
		}
	   overlay = new daum.maps.CustomOverlay({
		        position:marker.getPosition(),
		        content: content
       });
	   overlayArr.push(overlay);
       overlay.setMap(map);
       mapCon.setCenter(marker.getPosition());
	}
}

//리스트 검색
function search(){
		searchText = $('#search_text').val();
		searchType = $('#searchType').val(); 
		if(searchText == ''){
			alert('검색어를 입력하세요.');
		}else{
			page = 1;
			list();
		}
}

//거리순 & 최신순
function change() {
	type = $('#ListType').val();
	list();	
}
//상세보기
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



//페이지 처리 ====================================================================
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

