<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<link rel="stylesheet"
	href="<c:url value='/resources/css/member/mypage.css'/>">
<!-- <style>
#modal {
	position: relative;
	width: 100%;
	height: 100%;
	z-index: 1;
}

#modal h2 {
	margin: 0;
}

#modal button {
	display: inline-block;
	width: 100px;
	margin-left: calc(100% - 100px - 10px);
}

#modal .modal_content {
	width: 300px;
	margin: 100px auto;
	padding: 20px 10px;
	background: #fff;
	border: 2px solid #666;
}

#modal .modal_layer {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	z-index: -1;
}
</style> -->
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div class="w3-container container">
		<h2>마이페이지</h2>
		<hr>
		${loginInfo}
		<div class="w3-cell-row">
			<div>
				<div id="profile-menu" class="active">
					<a href="<c:url value='/member/memberMypage/requestListForm'/>">요청
						리스트</a> <a
						href="<c:url value='/member/memberMypage/lendingListForm'/>">대여리스트</a>
					<a href="<c:url value='/member/memberMypage/reviewListForm'/>">나의
						리뷰</a> <a href="<c:url value='/member/memberMypage/commentListForm'/>">나의
						댓글</a> <a href="<c:url value='/member/memberMypage/mypageForm'/>">나의
						정보</a> <a href="<c:url value='/member/memberMypage/distSetForm'/>">거리
						설정</a> <a href="<c:url value='/member/memberMypage/keywordSetForm'/>">키워드
						설정</a>
				</div>
			</div>
			<div class="w3-cell" style="width: 75%">
				<div id="mypageBox" style="margin-right: 10%">

					<div id="mypage">
						<div class="w3-cell-row">
							<div id="w3-cell"
								style="width: 30%; margin: 0; display: inline-block;">
								<c:set var="kId" value="${loginInfo.kId}" />

								<c:if test="${kId eq null}">
									<img
										src="<c:url value="/resources/img/upload/${loginInfo.mImg}"/>"
										width="150px" height="150px" style="border-radius: 100px;">
								</c:if>
								<c:if test="${kId ne null}">
									<img src="${loginInfo.mImg}" width="150px" height="150px"
										style="border-radius: 100px;">
								</c:if>
								<%-- 								<div class="filebox">
									<label for="mImg">업로드</label> 
									<input type="file" id="mImg" name="mImg" value="${loginInfo.mImg}"> 
									<input name="Img" id="Img" value="${loginInfo.mImg}">
								</div> --%>

							</div>
							<div id="w3-cell"
								style="width: 70%; margin: 0; display: inline-block;">
								<form action="<c:url value='/member/memberMypage/edit'/>" method="post" enctype="multipart/form-data">
									<c:set var="mPic" value="${loginInfo.mPic}" />
									<input type="hidden" name="mId" id="mId"
										value="${loginInfo.mId}">
									<c:if test="${mPic eq null}">
										<input type="file" name="mImg" id="mImg">
									</c:if>
									<table>
										<tr>
											<td>이름</td>
											<td><input type="text" name="mNick" id="mNick"
												value="${loginInfo.mNick}" readonly></td>
										</tr>
										<tr>
											<td>주소</td>
											<td><input type="text" name="mAddr" id="mAddr"
												value="${loginInfo.mAddr}" required> <input
												type="button" id="button"
												onclick="sample5_execDaumPostcode()" value="주소 검색"></td>
											<td><input type="hidden" name="mLttd" id="mLttd"
												value="${loginInfo.mLttd}"></td>
											<!-- 위도 -->
											<td><input type="hidden" name="mLgtd" id="mLgtd"
												value="${loginInfo.mLgtd}"></td>
											<!-- 경도 -->
										</tr>
										<tr>
											<td></td>
											<td><div id="map"
													style="width: 300px; height: 300px; margin-top: 10px; display: none"></div></td>
										</tr>
										<tr>
											<td>거리</td>
											<td><select name="mRadius" id="mRadius" value="${loginInfo.mRadius}">
													<option value="1" id="1">1km</option>
													<option value="2" id="2">2km</option>
													<option value="3" id="3">3km</option>
													<option value="4" id="4">4km</option>
											</select></td>
										</tr>
										<tr>
											<td></td>
											<td><input type="submit" value="수정 완료"></td>
										</tr>
									</table>
								</form>
							</div>

						</div>
						<hr>
						<a class="btn btn-default" href="#layer2" id="pw">비밀번호 변경</a> <a
							class="btn btn-default" href="#layer3" id="del">회원 탈퇴</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 비밀번호 변경 -->
	<div class="dim-layer" id="dim">
		<div class="dimBg"></div>
		<div id="layer2" class="pop-layer">
			<div class="pop-container">
				<div class="pop-conts">
					<!--content //-->
					<form id="editPwForm" action="editPw" method="post">
						<table>
							<tr>
								<td>현재 비밀번호</td>
								<td><input type="password" name="mPw" id="mPw" required></td>
							</tr>
							<tr>
								<td>새 비밀번호</td>
								<td><input type="password" name="nPw" id="nPw" required></td>
							</tr>
							<tr>
								<td>새 비밀번호 확인</td>
								<td><input type="password" name="nchkPw" id="nchkPw"
									required></td>
							</tr>
							<tr>
								<td></td>
								<td><input type="button" value="수정 완료"
									onclick="updatePw();"></td>
							</tr>
						</table>
					</form>
					<div class="btn-r">
						<a href="#" class="btn-layerClose">닫기</a>
					</div>
					<!--// content-->
				</div>
			</div>
		</div>
	</div>

	<!-- 회원 탈퇴 -->
	<div class="dim-layer2" id="dim2">
		<div class="dimBg2"></div>
		<div id="layer3" class="pop-layer2">
			<div class="pop-container2">
				<div class="pop-conts2">
					<!--content //-->
					<p>정말로 탈퇴하시겠습니까? 탈퇴하시려면 비밀번호를 입력해주세요.</p>
					<form id="deleteForm" action="delete" method="post">
						<table>
							<tr>
								<td>비밀번호 입력</td>
								<td><input type="password" name="dPw" id="dPw" required></td>
							</tr>

							<tr>
								<td></td>
								<td><input type="button" value="입력"
									onclick="deleteMember();"></td>
							</tr>
						</table>
					</form>
					<div class="btn-r2">
						<a href="#" class="btn-layerClose2">닫기</a>
					</div>
					<!--// content-->
				</div>
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
		var mRadius = '${loginInfo.mRadius}';
 		if(mRadius == 1){
			$('#1').attr('selected','selected');
		} else if(mRadius == 2){
			$('#2').attr('selected','selected');
		} else if(mRadius == 3){
			$('#3').attr('selected','selected');
		} else if(mRadius == 4){
			$('#4').attr('selected','selected');
		} 
		/* $('#mRadius').val().attr('selected','selected'); */
		/* $('#mRadius option:eq(${loginInfo.mRadius})').attr('selected','selected'); */
	});
	
	
		// checkbox 선택
		function oneCheckbox(a) {
			var obj = document.getElementsByName("checkbox");
			for (var i = 0; i < obj.length; i++) {
				if (obj[i] != a) {
					obj[i].checked = false;
				}
			}
		}

		// 비밀번호 변경
		function updatePw() {

			var mId = '${loginInfo.mId}';
			var mPw = $('#mPw').val();
			var nPw = $('#nPw').val();
			var nchkPw = $('#nchkPw').val();

			$.ajax({
				url : 'chkmPw',
				type : 'post',
				data : {
					mId : mId,
					mPw : mPw
				},
				success : function(data) {
					if (data == 1) {
						if (nPw != nchkPw) {
							alert('새 비밀번호가 일치하지 않습니다.');
							location.href = 'mypageForm';
						} else {
							$.ajax({
								url : 'editPw',
								type : 'post',
								data : {
									mId : mId,
									nPw : nPw
								},
								success : function(data) {
									if (data == 1) {
										alert('비밀번호가 변경되었습니다.');
									} else {
										alert('비밀번호 변경이 실패하였습니다.');
									}
									location.href = 'mypageForm';
								}
							});
						}
					} else {
						alert('비밀번호가 일치하지 않습니다.');
					}
				}

			});
		}

		// 회원 탈퇴
		function deleteMember() {
			var mId = '${loginInfo.mId}';
			var mPw = $('#dPw').val();

			$.ajax({
				url : 'chkmPw',
				type : 'post',
				data : {
					mId : mId,
					mPw : mPw
				},
				success : function(data) {
					if (data == 1) {

						$.ajax({
							url : 'delete',
							type : 'post',
							data : {
								mId : mId
							},
							success : function(data) {
								if (data == 1) {
									alert('회원탈퇴에 성공하였습니다.');
								} else {
									alert('회원탈퇴에 실패하였습니다.');
								}
								location.href = 'mypageForm';
							}
						});

					} else {
						alert('비밀번호가 일치하지 않습니다.');
						location.href = 'mypageForm';

					}
				}

			});
		}

		$('#pw').click(function() {
			var $href = $(this).attr('href');
			layer_popup($href);

		});

		function layer_popup(el) {
			var $el = $(el); //레이어의 id를 $el 변수에 저장
			var isDim = $el.prev().hasClass('dimBg'); //dimmed 레이어를 감지하기 위한 boolean 변수

			isDim ? $('.dim-layer').fadeIn() : $el.fadeIn();

			var $elWidth = ~~($el.outerWidth()), $elHeight = ~~($el
					.outerHeight()), docWidth = $(document).width(), docHeight = $(
					document).height();

			// 화면의 중앙에 레이어를 띄운다.
			if ($elHeight < docHeight || $elWidth < docWidth) {
				$el.css({
					marginTop : -$elHeight / 2,
					marginLeft : -$elWidth / 2
				})
			} else {
				$el.css({
					top : 0,
					left : 0
				});
			}

			$el.find('a.btn-layerClose').click(function() {
				isDim ? $('.dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
				return false;
			});

			$('.layer .dimBg').click(function() {
				$('.dim-layer').fadeOut();
				return false;
			});

		}

		/* 회원탈퇴 */
		$('#del').click(function() {
			var $href = $(this).attr('href');
			layer_popup2($href);

		});

		function layer_popup2(el) {
			var $el = $(el); //레이어의 id를 $el 변수에 저장
			var isDim = $el.prev().hasClass('dimBg2'); //dimmed 레이어를 감지하기 위한 boolean 변수

			isDim ? $('.dim-layer2').fadeIn() : $el.fadeIn();

			var $elWidth = ~~($el.outerWidth()), $elHeight = ~~($el
					.outerHeight()), docWidth = $(document).width(), docHeight = $(
					document).height();

			// 화면의 중앙에 레이어를 띄운다.
			if ($elHeight < docHeight || $elWidth < docWidth) {
				$el.css({
					marginTop : -$elHeight / 2,
					marginLeft : -$elWidth / 2
				})
			} else {
				$el.css({
					top : 0,
					left : 0
				});
			}

			$el.find('a.btn-layerClose2').click(function() {
				isDim ? $('.dim-layer2').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
				return false;
			});

			$('.layer .dimBg2').click(function() {
				$('.dim-layer2').fadeOut();
				return false;
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