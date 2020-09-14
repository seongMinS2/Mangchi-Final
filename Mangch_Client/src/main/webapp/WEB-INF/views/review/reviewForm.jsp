<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성</title>

<style>

#contain{
	margin-bottom: 80px;
}

#receiverInfo{
	margin: 30px 0 20px;
    text-align: center;
}

#reviewText {
	width: 750px;
	height: 200px;
}

.star-input>.input, .star-input>.input>label:hover, .star-input>.input>input:focus+label,
	.star-input>.input>input:checked+label {
	display: inline-block;
	vertical-align: middle;
	background: url('/mangh/resources/img/star.png') no-repeat;
}

.star-input {
	display: inline-block;
	white-space: nowrap;
	width: 225px;
	height: 40px;
	line-height: 30px;
}

.star-input>.input {
	display: inline-block;
	width: 150px;
	background-size: 150px;
	height: 28px;
	white-space: nowrap;
	overflow: hidden;
	position: relative;
}

.star-input>.input>input {
	position: absolute;
	width: 1px;
	height: 1px;
	opacity: 0;
}

star-input>.input.focus {
	outline: 1px dotted #ddd;
}

.star-input>.input>label {
	width: 30px;
	height: 0;
	padding: 28px 0 0 0;
	overflow: hidden;
	float: left;
	cursor: pointer;
	position: absolute;
	top: 0;
	left: 0;
}

.star-input>.input>label:hover, .star-input>.input>input:focus+label,
	.star-input>.input>input:checked+label {
	background-size: 150px;
	background-position: 0 bottom;
}

.star-input>.input>label:hover ~label {
	background-image: none;
}

.star-input>.input>label[for="p1"] {
	width: 30px;
	z-index: 5;
}

.star-input>.input>label[for="p2"] {
	width: 60px;
	z-index: 4;
}

.star-input>.input>label[for="p3"] {
	width: 90px;
	z-index: 3;
}

.star-input>.input>label[for="p4"] {
	width: 120px;
	z-index: 2;
}

.star-input>.input>label[for="p5"] {
	width: 150px;
	z-index: 1;
}

.star-input>output {
	display: inline-block;
	width: 60px;
	font-size: 18px;
	text-align: right;
	vertical-align: middle;
}

th {
	width: 15%;
	text-align: center;
}

td {
	padding: 15px 0px 5px 15px;
	width: 89px;
}

.form_btn{
		float: right; 
		text-align: center;
		padding : 6px 8px;
		width: 100px;
		margin: 5px;
		font-weight: bold;
	}
	 

#regBtn{
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
	<div class="w3-content" >
		<h3 id="receiverInfo">'${receiver}'님과의 거래 후기</h3>


		<form onsubmit="return false;">
			<table>
				<tr>
					<th>리뷰내용</th>
					<td><textarea id="reviewText"
							placeholder="거래  후기를  20자  이상  남겨주시면  다른  회원들에게도  도움이  됩니다."
							required></textarea></td>
				</tr>
				<tr>
					<th>평점</th>
					<td>
						<!-- <select id="avg">
								<option id="1" value="1">1</option>
								<option id="2" value="2">2</option>
								<option id="3" value="3">3</option>
								<option id="4" value="4">4</option>
								<option id="5" value="5">5</option>
						</select>  --> 
						<span class="star-input"> 
						<span class="input"> 
							<input type="radio" name="review_score" value="1" id="p1" checked> 
							<label for="p1">1</label> 
							<input type="radio" name="review_score" value="2" id="p2"> <label for="p2">2</label> 
							<input type="radio" name="review_score" value="3" id="p3"> <label for="p3">3</label>
							<input type="radio" name="review_score" value="4" id="p4"> <label for="p4">4</label> 
							<input type="radio" name="review_score" value="5" id="p5"> <label for="p5">5</label>
						</span> 
						<output for="star-input">
								<b>1</b>점
						</output>
					</span>
					</td>
				</tr>
			</table>
			
			<div>
				
				<span><input type="button" class="form_btn"  value="취소" onclick="cancelbtn()" id="cancel" ></span>
				<span><input type="submit" class="form_btn" value="등록" onclick="reviewSubmit()" id="regBtn"></span>
				
			</div>
		</form>
	</div>
	
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

	<script>
		//리뷰 등록
		function reviewSubmit(){
			
			var reviewInfo = {
					reviewIdx: ${reviewIdx},
					text : $('#reviewText').val(),
					//avg : $('#avg').val(),
					avg : $('input[name=review_score]:checked').val(),
					status : ${rstatus},
					receiver : '${receiver}'
			};
			
			
			   $.ajax({
				url : 'http://ec2-52-79-249-25.ap-northeast-2.compute.amazonaws.com:8080/rl/review',
				//url : 'http://localhost:8080/rl/review',
				type : 'post',
				data : reviewInfo,
				success : function(data){
					alert('리뷰가 등록되었습니다.');
					location.href="${pageContext.request.contextPath}/request/requestList"; 
				}
			});   
			
					
		}
		
	    var starRating = function() {
	        var $star = $(".star-input"),
	            $result = $star.find("output>b");

	        $(document)
	            .on("focusin", ".star-input>.input",
	                function() {
	                    $(this).addClass("focus");
	                })

	            .on("focusout", ".star-input>.input", function() {
	                var $this = $(this);
	                setTimeout(function() {
	                    if ($this.find(":focus").length === 0) {
	                        $this.removeClass("focus");
	                    }
	                }, 100);
	            })

	            .on("change", ".star-input :radio", function() {
	                $result.text($(this).next().text());
	            })
	            .on("mouseover", ".star-input label", function() {
	                $result.text($(this).text());
	            })
	            .on("mouseleave", ".star-input>.input", function() {
	                var $checked = $star.find(":checked");
	                if ($checked.length === 0) {
	                    $result.text("0");
	                } else {
	                    $result.text($checked.next().text());
	                }
	            });
	    };
	    starRating();
		
		
	</script>

</body>


</html>