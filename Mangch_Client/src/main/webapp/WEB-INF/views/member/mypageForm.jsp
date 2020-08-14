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
body {
	margin: 0;
	padding: 0;
}

.memberList {
	width: 20%;
	display: block;
	margin: 0;
}

div.card {
	width: 25%;
	border: 1px solid #DDD;
	display: unset;
}

div.card>ul>li {
	list-style: none;
	font-size: 12px;
}

.haha {
	width: 50%;
	display: block;
	margin: 0;
}

#profile-menu {
	top: 90px;
	margin-left: 40px;
	width: 220px;
	display: block;
	background: #fff;
	-webkit-box-shadow: 0 0 1px 0 rgba(0, 0, 0, 0.1);
	box-shadow: 0 0 1px 0 rgba(0, 0, 0, 0.1);
	-webkit-transform: translateY(-400px);
	-moz-transform: translateY(-400px);
	-o-transform: translateY(-400px);
	-ms-transform: translateY(-400px);
	transform: translateY(-400px);
	-webkit-transition: -webkit-transform .3s;
	-moz-transition: -moz-transform .3s;
	-o-transition: -o-transform .3s;
	-ms-transition: -ms-transform .3s;
	transition: transform .3s;
	-moz-transform: translateY(-400px);
	-o-transform: translateY(-400px);
	-ms-transform: translateY(-400px);
	transform: translateY(-400px);
	background: #fff;
}

#profile-menu.active {
	-webkit-transform: translateY(0);
	-moz-transform: translateY(0);
	-o-transform: translateY(0);
	-ms-transform: translateY(0);
	transform: translateY(0)
}

#profile-menu:before {
	width: 0;
	height: 0;
	border-style: solid;
	border-width: 0 9px 9px 9px;
	border-color: transparent transparent #fff transparent;
	content: '';
	display: block;
	position: absolute;
	top: -9px;
	left: 18px
}

#profile-menu a {
	background: #fff;
	display: block;
	padding: 18px 0 18px 25px;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
	text-decoration: none;
	font-size: 16px;
	color: #333;
	border: 1px solid #e8e8e8;
	margin-top: -1px;
}

#profile-menu a:hover {
	background: #f3f3f3
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<h2>마이페이지</h2>
	<hr>
	<p>session : ${loginInfo} ${loginInfo.mIdx}</p>

	<div class="w3-container">
		<div class="w3-cell-row">
			<div class="w3-cell">
				<div id="profile-menu" class="active">
					<a href="/my/landing-page">요청 리스트</a> <a href="/my/profile">대여리스트</a>
					<a href="/my/projects">나의 리뷰</a> <a href="/my/forums">나의 댓글</a> <a
						href="/community/people/christoffer-erneholm">나의 정보</a> <a
						href="/logout">거리 설정</a> <a href="/logout">키워드 설정</a>
				</div>
			</div>
			<div class="w3-cell">
				<div id="memberList"></div>
			</div>
		</div>
	</div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

	<script>
		
	$(document).ready(function(){
		
		memberList();
	});
	
	function memberList(){
		$.ajax({
			url: 'http://localhost:8090/mc/member/'+${loginInfo.mIdx},
			type: 'get',
			success: function(data){
				alert(data);
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
					html += '		<li>mImg : <img src="http://localhost:8090/mc'+data[i].mImg+'" width=50 height=50></li>';
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