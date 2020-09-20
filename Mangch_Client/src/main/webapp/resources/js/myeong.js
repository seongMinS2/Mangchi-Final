var headerCheck=1;	



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
		page = data;
	}else{
		if(page > pageEnd){
			pageStart = page;
			pageEnd = pageEnd+3;
		}
	list();
	}
}

