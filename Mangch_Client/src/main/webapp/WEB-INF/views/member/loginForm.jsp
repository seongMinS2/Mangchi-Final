<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />

	<h1>로그인</h1>
	<hr>
	<form method="post">
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
	<a id="custom-login-btn" href="javascript:loginWithKakao()"> 
	<img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg"
		width="300" />
	</a>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

	<script type="text/javascript">
		function loginSubmit() {
			$.ajax({
				url : 'login',
				type : 'post',
				data : {
					mId : $('#mId').val(),
					mPw : $('#mPw').val()
				},
				success : function(data) {
					if (data == 'Y') {
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

		// ### kakao login ###
		Kakao.init('93566b80fb99a5007a395716fd157aaa');

		function loginWithKakao() {
			// 로그인 창을 띄웁니다.
			Kakao.Auth.login({
				success : function(authObj) {
					alert(JSON.stringify(authObj));

					infoWithKakao();

				},
				fail : function(err) {
					alert(JSON.stringify(err));
				}
			});
		};

/* 		function startWithKakao() {
			Kakao.Auth.getStatusInfo(function(statusObj) {
				if (statusObj.status == 'connected') {
					$('#custom-login-btn').css('display', 'none');
				} else {
					$('#custom-login-btn').css('display', 'inline');
				}
			});
		}; */
		
        function infoWithKakao() {
            // 로그인 성공시, API를 호출합니다.
            Kakao.API.request({
                url: '/v2/user/me',
                success: function(res) {
                    alert(JSON.stringify(res));
                    alert(res.id);
                    alert(res.properties.nickname);
                    alert(res.properties.profile_image);
                    alert(res.properties.thumbnail_image);
                    alert(res.kakao_account.email);
                    
                    var id = res.id;
                    var nickname = res.properties.nickname;
                    var img = res.properties.profile_image;
                    var email = res.kakao_account.email;
                    
                    $.ajax({
        				url : 'regFormKakao',
        				data : {
        					id : id,
        					nickname : nickname,
        					img : img,
        					email : email	
        				},
        				success : function(data) {
 							
        				}
        			});
                    
                    
                },
                fail: function(error) {
                    alert(JSON.stringify(error));
                }
            });
        };
	</script>
</body>
</html>