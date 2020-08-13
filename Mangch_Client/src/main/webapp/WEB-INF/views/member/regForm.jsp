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
				<td>사진</td>
				<td><input type="file" name="mImg" id="mImg"></td>
			</tr>

			<tr>
				<td>주소</td>
				<td><input type="text" name="mAddr" id="mAddr"><input
					type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"></td>
					<td><input type="hidden" name="mLttd" id="mLttd"></td>	<!-- 위도 -->
					<td><input type="hidden" name="mLgtd" id="mLgtd"></td>	<!-- 경도 -->
			</tr>
			<tr>
				<td></td>
				<td><div id="map"
						style="width: 300px; height: 300px; margin-top: 10px; display: none"></div></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="회원가입" onclick="regSubmit();"></td>
			</tr>
		</table>
	</form>




	<jsp:include page="/WEB-INF/views/include/footer.jsp" />


	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=df58cedd8eb92f5d263aef4923099171&libraries=services"></script>
	<script
		src="https://apis.google.com/js/platform.js?onload=renderButton"></script>


	<script>
		// ### 회원가입 Submit ### 
		function regSubmit() {

			var regFormData = new FormData();
			regFormData.append('mId', $('#mId').val());
			regFormData.append('mPw', $('#mPw').val());
			regFormData.append('chkmPw', $('#chkmPw').val());
			regFormData.append('chkEmail', $('#chkEmail').val());
			regFormData.append('mNick', $('#mNick').val());
			regFormData.append('mAddr', $('#mAddr').val());
			regFormData.append('mLttd', $('#mLttd').val());
			regFormData.append('mLgtd', $('#mLgtd').val());

			if ($('#mImg')[0].files[0] != null) {
				regFormData.append('mImg', $('#mImg')[0].files[0]);
			}
			$.ajax({
				url : 'http://localhost:8090/mc/member',
				type : 'post',
				processData : false,
				contentType : false,
				data : regFormData,

				success : function(data) {
					alert(data);
					document.getElementById('regForm').reset();
				}
			});

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
	</script>
</body>
</html>
