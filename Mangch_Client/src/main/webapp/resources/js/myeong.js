
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		var addr = $('#sample5_address').val();

		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(addr,function(result, status) {

							// 정상적으로 검색이 완료됐으면 
							if (status === kakao.maps.services.Status.OK) {

								var coords = new kakao.maps.LatLng(result[0].y,result[0].x);

								// 결과값으로 받은 위치를 마커로 표시합니다
								var marker = new kakao.maps.Marker({
									map : map,
									position : coords
								});

								// 인포윈도우로 장소에 대한 설명을 표시합니다
								var infowindow = new kakao.maps.InfoWindow(
								{
									content : '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
								});
								infowindow.open(map, marker);

								// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
								map.setCenter(coords);

								console.log("등록1 : " + coords);
								reqLocation(result[0].y, result[0].x);

							}

						});

		//요청 글 주소 변경
		$('#changeAddr')
				.click(function() {new daum.Postcode({oncomplete : function(data) {
									var addr = data.address; // 최종 주소 변수
									// 주소 정보를 해당 필드에 넣는다.
									document
											.getElementById("sample5_address").value = addr;
									// 주소로 상세 정보를 검색
									// 주소로 좌표를 검색합니다
									geocoder.addressSearch(addr,function(result,status) {

										// 정상적으로 검색이 완료됐으면 
										if (status === kakao.maps.services.Status.OK) {

											var coords = new kakao.maps.LatLng(
													result[0].y,
													result[0].x);



											// 결과값으로 받은 위치를 마커로 표시합니다
											var marker = new kakao.maps.Marker(
													{
														map : map,
														position : coords
													});

											// 인포윈도우로 장소에 대한 설명을 표시합니다
											var infowindow = new kakao.maps.InfoWindow(
													{
														content : '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
													});
											infowindow.open(map,marker);

											// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
											map.setCenter(coords);

											console.log("등록2 : "+ coords);
											reqLocation(result[0].y,result[0].x);
											}

									});
								}
							}).open();
						});

		var lat;
		var lon;
		function reqLocation(latitude, longitude) {
			lat = latitude;
			lon = longitude;
			
			console.log(lat);
			console.log(lon);
		}
		

		function regSubmit() {
			var regRequest = new FormData();
			regRequest.append('reqTitle', $('#reqTitle').val());
			regRequest.append('reqAddr', $('#sample5_address').val());
			regRequest.append('reqContents', $('#reqContents').val());
			if ($('#reqImg')[0].files[0] != null) {
				regRequest.append('reqImg', $('#reqImg')[0].files[0]);
			}
			regRequest.append('reqLatitude', lat);
			regRequest.append('reqLongitude', lon);
			
			$.ajax({
				url : 'http://localhost:8080/rl/request',
				type : 'POST',
				processData : false,
				contentType : false,
				data : regRequest,
				success : function(data) {
					
					if(data != 0){
					alert('등록되었습니다.');
					location.href="/mangh/request/requestList";
					}
				}

			});
			
		}
		
		
		
		
		
		
		