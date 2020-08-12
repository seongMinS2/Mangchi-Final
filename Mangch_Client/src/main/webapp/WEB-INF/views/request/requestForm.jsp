<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>요청 게시판 글쓰기</title>

<style>
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- 변경 주소 -->
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69c40691beee2a7bf82c96e2f85f0da8&libraries=services"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=69c40691beee2a7bf82c96e2f85f0da8"></script>


</head>
<body>


	<jsp:include page="/WEB-INF/views/include/header.jsp" />

	<div class="w3-container">

		<div>
			<h1 class="w3-left">게시물 리스트</h1>
			<a href="<c:url value="/request/requestWrite"/>" class="w3-right"><button>등록</button></a>
		</div>

		<div class="w3-border">
			<form id="listReg" onsubmit="return false;">

				<table class="w3-table w3-border">
					<tr>
						<td><label>요청 글 제목 </label></td>
						<td><input type="text" name="reqTitle" id="reqTitle"></td>
					</tr>

					<tr>
						<td><label> 요청 희망 지역 </label></td>
						<td><input type="text" name="reqAddr" id="sample5_address"
							value="서울 종로구 경교장길 8">
							<div id="map"
								style="width: 300px; height: 300px; margin-top: 10px; display: none;"></div>
							<input type="button" value="주소 변경" id="changeAddr"></td>
					</tr>

					<tr>
						<td><label>상세내용</label></td>
						<td><textarea cols="50" rows="10" name="reqContets"
								id="reqContents"></textarea></td>
					</tr>
					<tr>
						<td><label>이미지 </label></td>
						<td><input type="file" name="reqImg" id="reqImg"></td>
					</tr>
					<tr>
					<td></td>
						<td><input type="submit" value="게시물 등록" onclick="regSubmit();"></td>
					</tr>
				</table>

			</form>
		</div>

	</div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

	<script src="${pageContext.request.contextPath}/resources/js/myeong.js"></script>



</body>
</html>