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
	<br>
	<br>
	<h1>회원가입</h1>
	<hr>
	<form id="regForm" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="mId" id="mId" autofocus required oninvalid="this.setCustomValidity('아이디를 입력해주세요.')"> <span
					id="checkmsg"></span></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="mPw" id="mPw" required oninvalid="this.setCustomValidity('비밀번호를 입력해주세요.')"> <span
					id="checkmsg3"></span></td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td><input type="password" name="chkmPw" id="chkmPw" required oninvalid="this.setCustomValidity('비밀번호를 확인해주세요.')">
					<span id="checkmsg4"></span></td>
			</tr>
			<tr>
				<td></td>
				<td><div class="alert alert-success" id="alert-success">비밀번호가
						일치합니다.</div>
					<div class="alert alert-danger" id="alert-danger">비밀번호가 일치하지
						않습니다.</div></td>

			</tr>
			<tr>
				<td>이메일 인증</td>
				<td><input type="text" name="mChk" id="mChk" required oninvalid="this.setCustomValidity('인증받으실 이메일을 입력해주세요.')"></td>
			</tr>
			<tr>
				<td>닉네임</td>
				<td><input type="text" name="mNick" id="mNick" required oninvalid="this.setCustomValidity('닉네임을 입력해주세요.')"> <span
					id="checkmsg2"></span></td>
			</tr>
			<tr>
				<td>사진</td>
				<td><input type="file" name="mImg" id="mImg"></td>
			</tr>

			<tr>
				<td>주소</td>
				<td><input type="text" name="mAddr" id="mAddr" required oninvalid="this.setCustomValidity('주소를 검색해주세요.')"><input
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
				<td><input type="submit" id="submit" value="회원가입" onclick="regSubmit();">
		</table>
	</form>




	<jsp:include page="/WEB-INF/views/include/footer.jsp" />


	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=df58cedd8eb92f5d263aef4923099171&libraries=services"></script>
<!-- 	<script
		src="https://apis.google.com/js/platform.js?onload=renderButton"></script> -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

	<script>
		$(document).ready(function() {

			$("#alert-success").hide();
			$("#alert-danger").hide();
			$("#mPw, #chkmPw").keyup(function() {
				var pwd1 = $("#mPw").val();
				var pwd2 = $("#chkmPw").val();
				if (pwd1 != "" || pwd2 != "") {
					if (pwd1 == pwd2) {
						$("#alert-success").show();
						$("#alert-danger").hide();
					} else {
						$("#alert-success").hide();
						$("#alert-danger").show();

					}
				}
			});
			
			$("#mPw, #chkmPw").keydown(function() {
				$("#alert-danger").hide();
				$("#alert-success").hide();
			});
			

			$('#mId').focusin(function() {

				$('#checkmsg').text('');

				$('#checkmsg').removeClass('check_not');
				$('#checkmsg').removeClass('check_ok');
			});

			$('#mId').focusout(function() {
				 
/* 				 if ($(this).val().length < 1) {
				 $('#checkmsg').text("아이디는 필수 항목입니다.");
				 $('#checkmsg').addClass('check_not');
				 return false;
				 }   */

				// ### 회원 ID 중복체크 ###
 				$.ajax({
					url : 'memberReg/chkmId',
					data : {
						mId : $(this).val()
					},
					success : function(data) {
						if ($('#mId').val().length > 0) {
							if (data == '0') {
								$('#checkmsg').text("사용가능한 아이디 입니다.");
								$('#checkmsg').addClass('check_ok');
								$('#idchk').prop('checked', true);
							} else {
								$('#checkmsg').text("사용이 불가능한 아이디 입니다.");
								$('#checkmsg').addClass('check_not');
								$('#idchk').prop('checked', false);
							}
						}
					}
				}); 

			});

			// 회원 닉네임 중복체크
			 $('#mNick').focusin(function() {

			 $('#checkmsg2').text('');

			 $('#checkmsg2').removeClass('check_not');
			 $('#checkmsg2').removeClass('check_ok');
			 }); 

			$('#mNick').focusout(function() {

/* 				 if ($(this).val().length < 1) {
				 $('#checkmsg2').text("닉네임은 필수 항목입니다.");
				 $('#checkmsg2').addClass('check_not');
				 return false;
				 } */ 

 				$.ajax({
					url : 'memberReg/chkmNick',
					data : {
						mNick : $(this).val()
					},
					success : function(data) {
						if ($('#mNick').val().length > 0) {
							if (data == '0') {
								$('#checkmsg2').text("사용가능한 닉네임 입니다.");
								$('#checkmsg2').addClass('check_ok');
								$('#idchk').prop('checked', true);
							} else {
								$('#checkmsg2').text("사용이 불가능한 닉네임 입니다.");
								$('#checkmsg2').addClass('check_not');
								$('#idchk').prop('checked', false);
								
							}
						}
					}
				}); 

			});

			// ### 비밀번호 입력 체크 ###
			$('#mPw').focusin(function() {

			 $('#checkmsg3').text('');

			 $('#checkmsg3').removeClass('check_not');
			 $('#checkmsg3').removeClass('check_ok');
			 }); 

			$('#mPw').focusout(function() {

				if ($(this).val().length < 1) {
				 $('#checkmsg3').text("비밀번호는 필수 항목입니다.");
				 $('#checkmsg3').addClass('check_not');
				 return false;
				 } 

			});

			// ### 비밀번호 확인 체크 ###
			 $('#chkmPw').focusin(function() {

			 $('#checkmsg4').text('');

			 $('#checkmsg4').removeClass('check_not');
			 $('#checkmsg4').removeClass('check_ok');
			 }); 

			$('#chkmPw').focusout(function() {

				if ($(this).val().length < 1) {
				 $('#checkmsg4').text("비밀번호를 확인해주세요.");
				 $('#checkmsg4').addClass('check_not');
				 return false;
				 } 

			});
		});
		
		document.getElementById('regForm').onsubmit=function(){
			var mPw = $('#mPw').val();
			var chkmPw = $('#chkmPw').val();
			
			if(mPw != chkmPw){
				alert('비밀번호가 일치하지 않습니다.');
				return false;
			}
			
		}

		// ### 회원가입 Submit ### 
		function regSubmit() {
			
/* 			console.log('hi');
			 if ($('#mId').val().length < 1) {
				document.getElementById('mId').focus();
				$('#checkmsg').text("아이디를 입력해주세요.");
			} else if ($('#mPw').val().length < 1) {
				document.getElementById('mPw').focus();
				$('#checkmsg3').text("비밀번호를 입력해주세요");
			} else if ($('#chkmPw').val().length < 1) {
				document.getElementById('chkmPw').focus();
				$('#checkmsg4').text("비밀번호를 확인해주세요.");
			} else if ($('#mNick').val().length < 1) {
				document.getElementById('mNick').focus();
				$('#checkmsg2').text("닉네임을 입력해주세요.");
			} else if ($('#mAddr').val().length < 1) {
				document.getElementById('mAddr').focus();
				$('#checkmsg5').text("주소를 검색해주세요.");

			} */
			
			
/*  			var regFormData = new FormData();
			regFormData.append('mId', $('#mId').val());
			regFormData.append('mPw', $('#mPw').val());
			regFormData.append('chkmPw', $('#chkmPw').val());
			regFormData.append('chkEmail', $('#chkEmail').val());
			regFormData.append('mNick', $('#mNick').val());
			regFormData.append('mAddr', $('#mAddr').val());
			regFormData.append('mLttd', $('#mLttd').val());
			regFormData.append('mLgtd', $('#mLgtd').val());
			regFormData.append('mChk',0); 
			if ($('#mImg')[0].files[0] != null) {
				regFormData.append('mImg', $('#mImg')[0].files[0]);
			} */
/* 			$.ajax({
				url : 'reg',
				type : 'post',
				processData : false,
				contentType : false,
				data : regFormData,

				success : function(data) {
					alert('회원가입이 완료되었습니다 !!');
					location.href='http://localhost:8080/mangh';
					document.getElementById('regForm').reset();
				}
			}); */
		
		} 

		// ### 주소 검색 ###
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div
		mapOption = {
			center : new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
			level : 5
		// 지도의 확대 레벨
		};

		//지도를 미리 생성
		var map = new daum.maps.Map(mapContainer, mapOption);
		//주소-좌표 변환 객체를 생성
		var geocoder = new daum.maps.services.Geocoder();
		//마커를 미리 생성
		var marker = new daum.maps.Marker({
			position : new daum.maps.LatLng(37.537187, 127.005476),
			map : map
		});

		function sample5_execDaumPostcode() {
			new daum.Postcode({
				oncomplete : function(data) {
					var addr = data.address; // 최종 주소 변수

					// 주소 정보를 해당 필드에 넣는다.
					document.getElementById("mAddr").value = addr;
					// 주소로 상세 정보를 검색
					geocoder.addressSearch(data.address, function(results,
							status) {
						// 정상적으로 검색이 완료됐으면
						if (status === daum.maps.services.Status.OK) {

							var result = results[0]; //첫번째 결과의 값을 활용

							// 해당 주소에 대한 좌표를 받아서
							var coords = new daum.maps.LatLng(result.y,
									result.x);
							$('#lat').attr('value', result.y);
							$('#longi').attr('value', result.x);

							// 해당 주소의 좌표를 input에 보내준다.
							document.getElementById("mLttd").value = result.y;
							document.getElementById("mLgtd").value = result.x;

							// 지도를 보여준다.
							mapContainer.style.display = "block";
							map.relayout();
							// 지도 중심을 변경한다.
							map.setCenter(coords);
							// 마커를 결과값으로 받은 위치로 옮긴다.
							marker.setPosition(coords)
						}
					});
				}
			}).open();
		}

		// ID 중복체크
	</script>
</body>
</html>
