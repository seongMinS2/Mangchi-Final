<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<link rel="stylesheet"
	href="<c:url value='/resources/css/member/login.css'/>">
</head>
<body>
	<div class="w3-container">
		<br><br>
		<div>
			<img src="<c:url value='/resources/img/LOGO-large.png'/>" style="margin-left: 38%;">
		</div>
		<!-- <h2>LOGIN</h2> -->
		<div id="loginbox">
			<table>
				<tr>
					<td><p class="tdname">아이디</p></td>
					<td><input type="text" name="mId" id="mId"></td>
				</tr>
				<tr>
					<td><p class="tdname">비밀번호</p></td>
					<td><input type="password" name="mPw" id="mPw"></td>
				</tr>
				<tr>
					<td></td>
					<td><input type="button" id="login" value="로그인"
						onclick="loginSubmit();"></td>
				</tr>
				<tr>
					<td></td>
					<td><a id="custom-login-btn"
						href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=a01763f7f7d5db1bd274b95045628499&redirect_uri=http://localhost:8080/mangh/member/kakao/kakaoREST">
							<img
							src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg"
							width="325" />
					</a></td>
				</tr>
				<tr>
					<td></td>
					<td><a class="signup"
						href="<c:url value="/member/memberReg"/>">Sign up</a></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<script>
	
		 function loginSubmit() {
			$.ajax({
				url : 'memberLogin',
				type : 'post',
				data : {
					mId : $('#mId').val(),
					mPw : $('#mPw').val()
				},
				success : function(data) {
					if (data == 'Y') {
						alert('환영합니다 !!!');
						location.href='memberMypage/mypageForm';
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

 		function startWithKakao() {
			Kakao.Auth.getStatusInfo(function(statusObj) {
				if (statusObj.status == 'connected') {
					$('#custom-login-btn').css('display', 'none');
				} else {
					$('#custom-login-btn').css('display', 'inline');
				}
			});
		}; 
		
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

                    var email = res.kakao_account.email;
                    var kImg = res.properties.profile_image;
                    
                    $.ajax({
        				url : 'kakao/kakaoId',
        				data : {
        					mId : email,	
        					mImg: kImg
        				},
        				success : function(data) {
 							if(data == 0) {		// 회원 가입
 								location.href='kakao';
 							} else {			// 로그인
 								// 실시간 프로필 사진 업데이트
								updateImg();
 								location.href='memberMypage/mypageForm';
 							}
        				}
        			});
                    
                    
                },
                fail: function(error) {
                    alert(JSON.stringify(error));
                }
            });
        };
        
        
        // 실시간 프로필 사진 업데이트
        function updateImg(){
        	alert('hidddd');
        	Kakao.API.request({
        	    url: '/v1/api/talk/profile',
        	    success: function(response) {
        	        alert(response);
        	    },
        	    fail: function(error) {
        	        alert(error);
        	    }
        	});
        }
          
        function kakaoLogout() {
            if (!Kakao.Auth.getAccessToken()) {
                alert('Not logged in.')
                return
            }
            Kakao.Auth.logout(function() {
                alert('logout ok\naccess token -> ' + Kakao.Auth.getAccessToken())
            })
        }


        function unlinkApp() {
            Kakao.API.request({
                url: '/v1/user/unlink',
                success: function(res) {
                    alert('success: ' + JSON.stringify(res))
                },
                fail: function(err) {
                    alert('fail: ' + JSON.stringify(err))
                },
            })
        }
	</script>
</body>
</html>