<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<link rel="stylesheet"
	href="<c:url value='/resources/css/member/regkakao.css'/>">
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div class="w3-container container">
		<div class="w3-center">
			<p id="addInfo">추가 정보입력</p>
			<%-- ${kakaoInfo} --%>
			<br>
			<div class="imgbox w3-center">
				<c:set var="mImg" value="${kakaoInfo.mImg}" />
				<c:if test="${mImg ne 'defalult.png'}">
					<img src="${kakaoInfo.mImg}" width=150px height=150px
						style="border-radius: 100px;">
				</c:if>
				<c:if test="${mImg eq 'defalult.png'}">
					<img src="<c:url value="/resources/img/upload/${kakaoInfo.mImg}"/>"
						width="150px" height="150px" style="border-radius: 100px;">
				</c:if>
				<input type="hidden" name="kImg" id="kImg" value="${kakaoInfo.mImg}">
			</div>
			<div class="w3-content">
			<form action="regkakao" id="kakaoForm" method="post"
				enctype="multipart/form-data">
				<input type="hidden" name="kId" id="kId" value="${kakaoInfo.kId}">
				<input type="hidden" name="mId" id="mId" value="${kakaoInfo.mId}">
				<table>
					<tr>
						<td width="100px" nowrap><p class="tdname">닉네임</p></td>
						<td><input type="text" name="mNick" id="mNick" value="${kakaoInfo.mNick}" required></td>
					</tr>
					<tr>
						<td><p class="tdname">주소</p></td>
						<td><input type="text" name="mAddr" id="mAddr">
						<input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색" id="addrBtn" required></td>
					</tr>
<!-- 					<tr>
						<td></td>
						<td><input type="button" onclick="sample5_execDaumPostcode()" value="주소 검색" id="addrBtn" required></td>
					</tr> -->
					<tr>
						<td></td>
						<td><div id="map" style="width: 230px; height: 230px; margin: auto; display: none"></div></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="submit" id="submitBtn" value="회원가입" onclick="regkakaoSubmit();"></td>
					</tr>
				</table>
				<input type="hidden" name="mLttd" id="mLttd" required>
				<!-- 위도 -->
				<input type="hidden" name="mLgtd" id="mLgtd" required>
				<!-- 경도 -->
			</form>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=df58cedd8eb92f5d263aef4923099171&libraries=services"></script>

	<script>
	$(document).ready(function(){
		
		$('#mAddr').hide();
		
	});
	
	function regkakaoSubmit() {
		
		if ($('#mAddr').val().length < 1) {
			document.getElementById('mAddr').focus();
			alert('주소를 검색해주세요.');
			$('form').attr('onSubmit', 'return false');
		} else {
			$('form').attr('onSubmit', 'return true');
		}
		
	}
	
		// Kakao.init('93566b80fb99a5007a395716fd157aaa');

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
			$('#mAddr').show();
		}
	</script>
</body>
</html>