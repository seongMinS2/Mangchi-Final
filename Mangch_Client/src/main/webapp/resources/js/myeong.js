

		function regSubmit() {
			var regRequest = new FormData();
			regRequest.append('reqTitle', $('#reqTitle').val());
			regRequest.append('reqAddr', $('#sample5_address').val());
			regRequest.append('reqContents', $('#reqContents').val());
			if ($('#reqImg')[0].files[0] != null) {
				regRequest.append('reqImg', $('#reqImg')[0].files[0]);
			}
			//regRequest.append('reqLatitude', lat);
			//regRequest.append('reqLongitude', lon);
			
			console.log(loginInfo.mLttd);
			
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
		
		
		
		
		
		
		