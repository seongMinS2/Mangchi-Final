<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<style>
div.card{
	width: 33%;
	float: left;
	border: 1px solid #DDD;		
}

div.card>ul>li{
	list-style: none;
	font-size: 12px;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<br>
	<br>
	<h1>마이페이지</h1>

	<h1>session : ${loginInfo}					${loginInfo.mIdx}</h1>
	<input type="hidden" id="mIdx" name="mIdx" value="${loginInfo.mIdx}" placeholder="${loginInfo.mIdx}"> 
	<br>
	
	<div id="memberList"></div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	
	<script>
		
	$(document).ready(function(){
		
		memberList();
	});
	
	function memberList(){
		$.ajax({
			crossOrigin : true,
			url: 'http://localhost:8090/mc/member',
			type: 'get',
			data : {mIdx: $('#mIdx').val()},
			success: function(data){
				alert('hi');
				console.log(${loginInfo.mIdx});
				var html = '';
				
				for(var i =0; i<data.length; i++){
					html += '<div class="card">';
					html += '	<ul>';
					html += '		<li>mIdx : '+data[i].mIdx+'</li>';
					html += '		<li>mId : '+data[i].mId+'</li>';
					html += '		<li>mPw : '+data[i].mPw+'</li>';
					html += '		<li>mNick : '+data[i].mNick+'</li>';
					html += '		<li>mScore : '+data[i].mScore+'</li>';
					html += '		<li>mRegdate : '+data[i].mRegdate+'</li>';
					html += '		<li>mAddr : '+data[i].mAddr+'</li>';
					html += '		<li>mLttd : '+data[i].mLttd+'</li>';
					html += '		<li>mLgtd : '+data[i].mLgtd+'</li>';
					html += '		<li>mImg : <img src="http://localhost:8090/mc/img/'+data[i].mImg+'" width=50 height=50></li>';
					html += '		<li>mChk : '+data[i].mChk+'</li>';
					html += '		<li>mRadius : '+data[i].mRadius+'</li>';
					html += '		<li><input type="button" value="수정" onclick="editForm('+data[i].mIdx+')"> ';
					html += '		<input type="button" value="삭제" onclick="deleteMember('+data[i].mIdx+')"></li>';
					html += '	</ul>';
					html += '</div>';
				}
				$('#memberList').html(html);
			}
		});
	}
		
		
	</script>
	
</body>
</html>