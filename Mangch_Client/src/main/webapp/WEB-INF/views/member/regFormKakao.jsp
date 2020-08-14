<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<br>
	<br>
	<h1>회원가입</h1>
	<hr>
	<form id="regForm" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>닉네임</td>
				<td><input type="text" name="mNick" id="mNick"> <span
					id="checkmsg2"></span></td>
			</tr>
			<tr>
				<td>사진</td>
				<td><input type="text" name="mImg" id="mImg"></td>
			</tr>

			<tr>
				<td>주소</td>
				<td><input type="text" name="mAddr" id="mAddr"><input
					type="button" onclick="sample5_execDaumPostcode()" value="주소 검색">
					<span id="checkmsg5"></span></td>
				<td><input type="hidden" name="mLttd" id="mLttd"></td>
				<!-- 위도 -->
				<td><input type="hidden" name="mLgtd" id="mLgtd"></td>
				<!-- 경도 -->
			</tr>
			<tr>
				<td></td>
				<td><div id="map"
						style="width: 300px; height: 300px; margin-top: 10px; display: none"></div></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="button" id="button_joinus" value="회원가입" onclick="regSubmit();"></td>
			</tr>
		</table>
	</form>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	
	
	<script>
		
	</script>
</body>
</html>