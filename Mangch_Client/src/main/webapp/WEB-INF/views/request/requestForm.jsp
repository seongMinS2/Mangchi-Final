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
<!-- <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> -->

<style>
	#contain{
		padding: 50px;
	}

	th {
		background-color: #f2deb4;
		width: 20%;
		text-align: center;
		
	}
	td {
		padding: 8px;
	}
	
 	.form_btn{
		float: right; 
		text-align: center;
		padding : 6px 8px;
		width: 100px;
		margin: 5px;
	}
	 
	
	/* 글 제목, 지역 */
	#reqTitle, #reqAddr{ 
		width: 100%;
	}
	
	#btn{
		background-color: #FFD201;
		border-radius: 5px;
		border: 1px solid #f7f7f7;
	}
	#cancel{
		border-radius: 5px;
		border: 1px solid #f7f7f7;
	}
	
	
</style>

</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />

	
	<div class="w3-container" id="contain">

		<c:choose>
			<c:when test="${! empty loginInfo }">

			<!-- 	<div class="w3-border" id="write"> -->
				<div class="w3-content" id="write">
					<form onsubmit="return false;">

						<table class="w3-content" >
							<tr>
								<th><label>요청 글 제목 </label></th>
								<td><input type="text" name="reqTitle" id="reqTitle" ></td>
							</tr>

							<tr>
								<th><label> 요청 희망 지역 </label></th>
								<td><input type="text" name="reqAddr" id="reqAddr" value="${loginInfo.mAddr}" readonly></td>
							</tr>
							<tr>
								<th></th>
								<td><textarea cols="50" rows="10" name="reqContents" id="summernote"></textarea></td>
							</tr>
							<tr>
								<th><label>이미지 </label></th>
								<td id="img"><input type="file" name="reqImg" id="reqImg"></td>
							</tr>
							<!-- <tr id="edit">
								<td></td>
								<td id="submit"><input type="submit" value="게시물 등록" onclick="regSubmit()" id="submit"></td>
							</tr> -->
						</table>
						
						<div id="edit">
							<span><input type="button"  class="form_btn" id="cancel" onclick="cancelbtn()" value="취소"></span>
							<span id="submit"><input type="submit" class="form_btn" value="등록" onclick="regSubmit()" id="btn"></span>
						</div>

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
				type: 'GET',
				success : function(data){
					
					$('#reqTitle').val(data.reqTitle);
					$('#reqAddr').val( data.reqAddr);
					//$('#reqContents').val( data.reqContents);
					//$('#summernote').val(data.reqContents);
				
				  	// Summernote에 글 내용 추가하는 코드
					 $("#summernote").summernote('code',  data.reqContents);
					
					
					
					var img_html='<input type="text" id="oldImg" name="oldImg" value="'+data.reqImg+'" style="display: none;"><br>';
					$('#img').append(img_html);
					
					var html = '<span>';
					html += ' <input type="submit" class="form_btn" value="게시물 수정" onclick="edit();" id="btn">';	
					html += '</span>';
					
					$('#edit').append(html);
					$('#submit').remove();
				}
				
			});
			
			function edit(){
				
				if($('#reqTitle').val() == ''){
					alert('제목을 입력해주세요.');
					$('#reqTitle').focus();
					$('#reqTitle').scrollIntoView();
					 return false;
				}
				if($('#summernote').summernote('isEmpty')){
					alert('내용을 입력해주세요.');
					$('#summernote').summernote('focus',true);
					$('#summernote').scrollIntoView();
					return false;	
				}
				
				else{
					var editRequest = new FormData();
					editRequest.append('reqWriter','${loginInfo.mNick}');
					editRequest.append('reqTitle', $('#reqTitle').val());
					//editRequest.append('reqContents', $('#reqContents').val());
					editRequest.append('reqContents', $('#summernote').val());
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
				 
			
			}
			
			</script>

		</c:if>


	 </div>
	

	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

	<script>
	
		function regSubmit() {
			
			
			if($('#reqTitle').val() == ''){
				alert('제목을 입력해주세요.');
				$('#reqTitle').focus();
				$('#reqTitle').scrollIntoView();
				 return false;
			}
			if($('#summernote').summernote('isEmpty')){
				alert('내용을 입력해주세요.');
				$('#summernote').summernote('focus',true);
				$('#summernote').scrollIntoView();
				return false;	
			}
			
			else {
				var regRequest = new FormData();
				regRequest.append('reqWriter','${loginInfo.mNick}');
				regRequest.append('reqTitle', $('#reqTitle').val());
				regRequest.append('reqAddr', $('#reqAddr').val());
				//regRequest.append('reqContents', $('#reqContents').val());
				regRequest.append('reqContents', $('#summernote').val());
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
			  
		}
		
		function cancelbtn(){
			location.href="/mangh/request/requestList";			
		}
		
	</script>


</body>
</html>