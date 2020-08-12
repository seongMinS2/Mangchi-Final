<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />

	<h1>회원가입</h1>
	<hr>
	<form id="regForm" method="post" enctype="multipart/form-data">
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
				<td>비밀번호 확인</td>
				<td><input type="password" name="chkmPw" id="chkmPw"></td>
			</tr>
			<tr>
				<td>이메일 인증</td>
				<td><input type="text" name="chkEmail" id="chkEmail"></td>
			</tr>
			<tr>
				<td>닉네임</td>
				<td><input type="text" name="mNick" id="mNick"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" name="mAddr" id="mAddr"></td>
			</tr>
			<tr>
				<td>사진</td>
				<td><input type="file" name="mImg" id="mImg"></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="회원가입" onclick="regSubmit();"></td>
			</tr>
		</table>
	</form>




	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	
<script>
function regSubmit(){
	
	var regFormData = new FormData();
	regFormData.append('mId', $('#mId').val());
	regFormData.append('mPw', $('#mPw').val());
	regFormData.append('chkmPw', $('#chkmPw').val());
	regFormData.append('chkEmail', $('#chkEmail').val());
	regFormData.append('mNick', $('#mNick').val());
	regFormData.append('mAddr', $('#mAddr').val());
	
	if($('#mImg')[0].files[0] != null){
		regFormData.append('mImg',$('#mImg')[0].files[0]);
	}
	$.ajax({
		url : 'http://localhost:8090/mc/member',
		type : 'post',
		processData: false,
		contentType: false, 
		data : regFormData,

		success : function(data){
			alert(data);
			document.getElementById('regForm').reset();
		}
	});
	
}
</script>
</body>
</html>
