<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>요청 게시판 글쓰기</title>

<style>
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />

	<div class="w3-container">

		<c:choose>
			<c:when test="${! empty loginInfo }">
				<div>
					<h1 class="w3-left">게시물 리스트</h1>
				</div>

				<div class="w3-border">
					<form onsubmit="return false;">

						<table class="w3-table w3-border">
							<tr>
								<td><label>요청 글 제목 </label></td>
								<td><input type="text" name="reqTitle" id="reqTitle"
									required></td>
							</tr>

							<tr>
								<td><label> 요청 희망 지역 </label></td>
								<td><input type="text" name="reqAddr" id="reqAddr"
									value="${loginInfo.mAddr}" readonly></td>
							</tr>
							<tr>
								<td><label>상세내용</label></td>
								<td><textarea cols="50" rows="10" name="reqContets"
										id="reqContents" required></textarea></td>
							</tr>
							<tr>
								<td><label>이미지 </label></td>
								<td id="img"><input type="file" name="reqImg" id="reqImg"></td>
							</tr>
							<tr id="edit">
								<td></td>
								<td id="submit"><input type="submit" value="게시물 등록" onclick="regSubmit()" id="submit"></td>
							</tr>
						</table>

					</form>
				</div>
			</c:when>
			<c:when test="${empty loginInfo}">
				<script>
					alert('로그인 후 이용해주세요');
					location.href = "/mangh/member/memberLogin";
				</script>
			</c:when>
		</c:choose>

		<c:if test="${reqIdx gt 0}">
			<script>
			$.ajax({
				//url : 'http://ec2-15-164-228-147.ap-northeast-2.compute.amazonaws.com:8080/rl/request/edit/'+${reqIdx},
				url : 'http://localhost:8080/rl/request/edit/'+${reqIdx},
				type: 'GET'
				success : function(data){
					
					$('#reqTitle').val(data.reqTitle);
					$('#reqAddr').val( data.reqAddr);
					$('#reqContents').val( data.reqContents);
					
					var img_html='<input type="text" id="oldImg" name="oldImg" value="'+data.reqImg+'" style="display: none;"><br>';
					$('#img').append(img_html);
					
					var html = '<td>';
					html += ' <input type="submit" value="게시물 수정" onclick="edit();" id="submit">';	
					html += '</td>';
					
					$('#edit').append(html);
					$('#submit').remove();
				}
				
			});
			
			function edit(){
				var editRequest = new FormData();
				editRequest.append('reqWriter','${loginInfo.mNick}');
				editRequest.append('reqTitle', $('#reqTitle').val());
				editRequest.append('reqContents', $('#reqContents').val());
				if ($('#reqImg')[0].files[0] != null) {
					editRequest.append('reqImg', $('#reqImg')[0].files[0]);
				}
				
				editRequest.append('oldImg',$('#oldImg').val());
				
				 $.ajax({
					//url : 'http://ec2-15-164-228-147.ap-northeast-2.compute.amazonaws.com:8080/rl/request/'+${reqIdx},
					url : 'http://localhost:8080/rl/request/'+${reqIdx},
					type : 'POST',
					processData : false,
					contentType : false,
					data : editRequest,
					success : function(data) {
						if(data != 0){
						alert('수정되었습니다.');
						location.href="/mangh/request/requestList";
						}
					}

				});
				 
			
			}
			
			</script>

		</c:if>


	</div>

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

	<%-- <script src="${pageContext.request.contextPath}/resources/js/myeong.js"></script> --%>
	<script>
	
		function regSubmit() {
			var regRequest = new FormData();
			regRequest.append('reqWriter','${loginInfo.mNick}');
			regRequest.append('reqTitle', $('#reqTitle').val());
			regRequest.append('reqAddr', $('#reqAddr').val());
			regRequest.append('reqContents', $('#reqContents').val());
			if ($('#reqImg')[0].files[0] != null) {
				regRequest.append('reqImg', $('#reqImg')[0].files[0]);
			}
			
			var lat = '${loginInfo.mLttd}';
			var lon = '${loginInfo.mLgtd}';

			regRequest.append('reqLatitude', lat);
			regRequest.append('reqLongitude', lon);
			
			$.ajax({
				//url : 'http://ec2-15-164-228-147.ap-northeast-2.compute.amazonaws.com:8080/rl/request',
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
	</script>


</body>
</html>