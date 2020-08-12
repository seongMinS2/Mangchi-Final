<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />

	<h1>로그인</h1>
	<hr>
	<form onsubmit="return false;">
		<table>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="mId" id="mId"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="mPw" id="mPw"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="로그인" onclick="loginSubmit();"></td>
			</tr>
		</table>
	</form>


	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

	<script type="text/javascript">
		function loginSubmit() {
			$.ajax({
				url : 'http://localhost:8080/mangh/member/loginForm/login',
				type : 'get',
				data : {
					mId : $('#mId').val(),
					mPw : $('#mPw').val()
				},
				success : function(data) {
					if (data == 'Y') {
						location.href = 'mypageForm';
						alert('환영합니다 !!!');
					} else if (data == 'N') {
						alert('아이디와 비밀번호를 확인해주세요.');
						document.getElementById('loginForm').reset();
					} else {

					}
				}
			});
			return false;
		} 
	</script>
</body>
</html>