<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>우리 동네 대여 서비스 :: M A N G C H !</title>




</head>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic+Coding&display=swap" rel="stylesheet">


    <link rel="canonical" href="https://getbootstrap.com/docs/4.5/examples/carousel/">
    <link rel='stylesheet' href='<c:url value="/resources/assets/dist/css/bootstrap.css"/>'>
     <link rel='stylesheet' href='<c:url value="/resources/page/jquery.fullpage.min.css"/>'>
    <script src="<c:url value='/resources/page/jquery.fullpage.min.js'/>"></script>
    
<style>


.w3-theme-l1{
	z-index: 2;
	position: relative;
}

.section{
z-index: -1;}

.fp-tableCell{
vertical-align: baseline;
}

.btn-primary{
background-color: #162d59;
border-color:#162d59;
}

h1{
	font-family: 'Jua', sans-serif;
	color: black;
}

.bd-placeholder-img{
border: 3px solid #DDD;
}

p {
	font-family: 'Jua', sans-serif;
	color: white;
}
    	
.nanum {
	font-family:'Nanum Gothic Coding', monospace;;
	font-size: 1em;
}
    	
.w3-left, .w3-right, .w3-badge {cursor:pointer}
.w3-badge {height:13px;width:13px;padding:0}

.indexPic {
	padding-left: 22%;
	width: 180px;
	height: 120px;
}

.featurette, .featurette>*  {

height: 27em;
}




</style>


<div id="fullpage">

	<div class="section" id="section1">

 <div id="myCarousel" class="carousel slide" data-ride="carousel">
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>
    <div class="carousel-inner">
      <div class="carousel-item active">
      
        <img src="<c:url value='/resources/img/index/home.png'/>" style="width:100%; height: 40em;">
        <div class="container">
          <div class="carousel-caption text-left">
            <h1>당장 필요한 물건이 있는데 <br>사기엔 돈이 아깝다면?</h1>
            <p class="nanum">우리 동네 대여 서비스  M A N G C H !</p>
            <p><a class="btn btn-lg btn-primary" href="<c:url value="/member/memberReg"/>" role="button">JOIN WITH US!</a></p>
          </div>
        </div>
      </div>
      <div class="carousel-item">
       <img src="<c:url value='/resources/img/index/home3.jpg'/>" style="width:100%; height: 40em;">
        <div class="container">
          <div class="carousel-caption">
            <h1>집에서 놀고 있는 물건이 있는데 팔기엔 아쉽다면?</h1>
            <p class="nanum">우리 동네 대여 서비스  M A N G C H !</p>
            <p><a class="btn btn-lg btn-primary" href="<c:url value="/member/memberReg"/>" role="button">JOIN WITH US!</a></p>
          </div>
        </div>
      </div>
      <div class="carousel-item">
       <img src="<c:url value='/resources/img/index/wooden.png'/>" style="width:100%; height: 40em;">
        <div class="container">
          <div class="carousel-caption text-right">
            <h1>우리 동네에 내가 당장 필요한 물건과<br>내 물건이 갑자기 필요해진 사람이 있다?</h1>
            <p class="nanum">우리 동네 대여 서비스  M A N G C H !</p>
            <p><a class="btn btn-lg btn-primary" href="<c:url value="/member/memberReg"/>" role="button">JOIN WITH US!</a></p>
          </div>
        </div>
      </div>
    
    <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
    </div>
    













<%-- 
<div class="w3-content w3-display-container" style="max-width:100%; height: 40em;">
  <div class="w3-display-container  mySlides"> 
 	<img src="<c:url value='/resources/img/index/home.png'/>" style="width:100%; height: 40em;">
	<div class="w3-display-left w3-padding-16">
    <h1 style="font-size: 3vw">당장 필요한 물건이 있는데 <br>사기엔 돈이 아깝다면?</h1>
    <span  style="font-size: 1.2vw; color: white; font-weight: bold;">우리 동네 대여 서비스  M A N G C H !</span>
    </div>
  </div>
  <div class="w3-display-container  mySlides"> 
    <img src="<c:url value='/resources/img/index/home3.jpg'/>" style="width:100%; height: 40em;">
	<div class="w3-display-topright w3-padding-16">
    <h1 style="font-size: 3vw">집에서 놀고 있는 물건이 있는데 팔기엔 아쉽다면?</h1>
    <span style="font-size: 1.2vw; color: white; font-weight: bold;">우리 동네 대여 서비스  M A N G C H !</span>  
	</div>
  </div>
  <div class="w3-display-container  mySlides"> 
    <img src="<c:url value='/resources/img/index/wooden.png'/>" style="width:100%; height: 40em;">
	<div class="w3-display-middle">
	<h1 style="font-size: 3vw">우리 동네에 내가 당장 필요한 물건과<br>내 물건이 갑자기 필요해진 사람이 있다?</h1>
	<span  style="font-size: 1.2vw; color: white; font-weight: bold;">우리 동네 대여 서비스  M A N G C H !</span> 
	</div>
  </div>
  
  <div class="w3-center w3-container w3-section w3-large w3-text-white w3-display-bottommiddle" style="width:100%">
    <div class="w3-left w3-hover-text-khaki" onclick="plusDivs(-1)">&#10094;</div>
    <div class="w3-right w3-hover-text-khaki" onclick="plusDivs(1)">&#10095;</div>
    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(1)"></span>
    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(2)"></span>
    <span class="w3-badge demo w3-border w3-transparent w3-hover-white" onclick="currentDiv(3)"></span>
  </div>
  
</div> --%>

 <div class="w3-content w3-center w3-container" style="margin-bottom: 3%;">
  <div class="w3-row w3-padding" style="margin-top: 5%;">
  
  <div class="w3-col m4">
  <div class="indexPic">
  	<img src="<c:url value='/resources/img/index/request2.png'/>" style="width:180px; height:120px;">
  </div>
  	<p style="color: #162d59; font-size: 25px; margin:0;">총 요청게시물 수</p>
  	<p class="number" style="color: #162d59; font-size: 45px; margin:0;"><B>${allRequest}</B></p>
  </div>
  
  <div class="w3-col m4">
  <div class="indexPic">
  	<img src="<c:url value='/resources/img/index/visitor2.png'/>" style="width:170px; height:110px;">
  </div>
  	<p style="color: #162d59; font-size: 25px; margin:0;">총 방문자 수</p>
  	<p class="number" style="color: #162d59; font-size: 45px; margin:0;"><B>${allVisitor}</B></p>
  </div>
  
  <div class="w3-col m4">
  <div class="indexPic">
  	<img src="<c:url value='/resources/img/index/donate2.png'/>" style="width:170px; height:110px;">
  </div>
  	<p style="color: #162d59; font-size: 25px; margin:0;">총 나눔게시물 수</p>
  	<p class="number" style="color: #162d59; font-size: 45px; margin:0;"><B>${allDonate}</B></p>
  </div>
  	</div>
 </div>
 
 </div>
  </div>


<div class="section" id="section2">

  <div class="container marketing">

    <!-- START THE FEATURETTES -->

    <hr class="featurette-divider">

    <div class="row featurette">
      <div class="col-md-7">
        <h1 class="featurette-heading">간편한 회원가입, 로그인 </h1>
        <h5> <span class="text-muted"> >> BOTH! << </span></h5>
        <p class="lead" style="color: black; font: bold;">주요 포탈 API를 활용하여 클릭 한번에 회원가입부터 로그인까지 가능하도록 하였습니다.</p>
      </div>
      <div class="col-md-5">
        <img class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto" src="<c:url value='/resources/img/로그인.PNG'/>" style="width: 500px; height: 27em;" >
      </div>
    </div>

    <hr class="featurette-divider">

    <div class="row featurette">
      <div class="col-md-7 order-md-2">
        <h1 class="featurette-heading"> 요청 게시판에 대여요청 올리기 </h1>
        <h5> <span class="text-muted">당장 망치가 필요한데 한번 쓰려고 사기에는 아까워! << </span></h5>
        <p class="lead" style="color: black; font: bold;"> 당장 급한 물건이 있을 때 내 위치와 함께 필요한 물품을 게시하여 내 주위 사람들에게 도움을 청할 수 있습니다. </p>
      </div>
      <div class="col-md-5">
        <img class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto" src="<c:url value='/resources/img/테스트.jpg'/>" style="width: 500px; height: 27em;">
      </div>
    </div>

    <hr class="featurette-divider">
    </div>
</div>


<div class="section" id="section3">
 <div class="container marketing">


 <hr class="featurette-divider">

    <div class="row featurette">
      <div class="col-md-7">
        <h1 class="featurette-heading">나눔 게시판에 나눔글 올리기</h1>
        <h5> <span class="text-muted"> >> 집에 물건은 남아돌고 처리하긴 힘들고.... </span></h5>
        <p class="lead" style="color: black; font: bold;">집에 사용하지 않아 처리하기 힘든 물품들을 여러 사람들에게 나누어 줄 수 있습니다.</p>
      </div>
      <div class="col-md-5 order-md-1">
       <img class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto" src="<c:url value='/resources/img/나눔게시판.PNG'/>" style="width: 500px; height: 27em;" >
      </div>
    </div>

    <hr class="featurette-divider">


    <div class="row featurette">
      <div class="col-md-7 order-md-2">
        <h1 class="featurette-heading">근처 이웃들과 소통하는 동네생활</h1>
        <h5> <span class="text-muted"> 동네 사람들과 소통하고 싶다면? << </span></h5>
        <p class="lead" style="color: black; font: bold;">내가 설정한 동네 반경에 따라 동네 사람들과 소통을 할 수 있는 공간입니다.</p>
      </div>
      <div class="col-md-5">
        <img class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto" src="<c:url value='/resources/img/동네생활.PNG'/>" style="width: 500px; height: 27em;">
      </div>
    </div>
    
	<hr class="featurette-divider">
	</div>
    </div>
    
    <div class="section" id="section4">
     <div class="container marketing">
    
     <hr class="featurette-divider">
    
    <div class="row featurette">
      <div class="col-md-7">
        <h1 class="featurette-heading"> 모르는게 있을때는 Q&A </h1>
        <h5><span class="text-muted">>> 사이트를 이용하다 모르는게 생겼어요!  </span></h5>
        <p class="lead" style="color: black; font: bold;">사이트 이용시 모르는게 생겼을시 도움을 요청할수 있는 게시판입니다 비밀글로 안전보장!.</p>
      </div>
      <div class="col-md-5">
        <img class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto" src="<c:url value='/resources/img/qna.PNG'/>" style="width: 500px; height: 27em;" >
      </div>
    </div>

    <hr class="featurette-divider">
    
    <div class="row featurette">
      <div class="col-md-7 order-md-2">
        <h1 class="featurette-heading">상대방과 실시간 채팅 서비스 </h1>
        <h5><span class="text-muted"> 상대방과 어떻게 거래할까요? << </span></h5>
        <p class="lead" style="color: black; font: bold;"> 빌려주는사람, 요청하는사람 서로 실시간 채팅을하며 협의 해보세요!</p>
      </div>
      <div class="col-md-5">
        <img class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto" src="<c:url value='/resources/img/채팅수정.jpg'/>" style="width: 500px; height: 27em;">
      </div>
    </div>

    <hr class="featurette-divider">
    <!-- /END THE FEATURETTES -->
    
	</div>
  </div><!-- /.container -->


<jsp:include page="/WEB-INF/views/include/footer.jsp"/> 

</div>

<script src="<c:url value='/resources/assets/dist/js/bootstrap.bundle.js'/>"></script>

<script>

$(document).ready(function() {
	$('#fullpage').fullpage({
		//options here
		autoScrolling:true,
		scrollHorizontally: true,
		sectionSelector: '.section'
	});

	//methods
	$.fn.fullpage.setAllowScrolling(true);
	
	
	
	
});
setInterval(function () {
	 if ($("body").hasClass("fp-viewing-0-0") == true) {
	    	$('.w3-theme-l1').show();
	    } else {
	    	$('.w3-theme-l1').hide();
	    }
},100);
   
/* 
$('body').on('change',function(){
	alert('test');
	if($(this).hasClass('fp-viewing-0-0') == false){
		$('.w3-theme-l1').hide();
	}else {
		$('.w3-theme-l1').show();
	}
	
}); */




$(function() {

    if('${regMSG}' != ""){
    	location.href='/mangh';
        alert('${regMSG}');
    }
    if('${logoutMSG}' != ""){
        location.href='/mangh';
        alert('${logoutMSG}');
    }
	
	  var count0 = count1 = count2 = 0;
	  var allVisitor = '${allVisitor}';
	  var allRequest = '${allRequest}';
	  var allDonate = '${allDonate}';

	  timeCounter();

	  function timeCounter() {

	    id0 = setInterval(count0Fn, 12.738853);

	    function count0Fn() {
	      count0++;
	      if (count0 > allRequest) {
	        clearInterval(id0);
	      } else {
	        $(".number").eq(0).text(count0);
	      }

	    }

	    id1 = setInterval(count1Fn, 5.13171226);

	    function count1Fn() {
	      count1++;
	      if (count1 > allVisitor) {
	        clearInterval(id1);
	      } else {
	        $(".number").eq(1).text(count1);
	      }
	    }

	    id2 = setInterval(count2Fn, 15.57142857);

	    function count2Fn() {
	      count2++;
	      if (count2 > allDonate) {
	        clearInterval(id2);
	      } else {
	        $(".number").eq(2).text(count2);
	      }
	    }
	  }
	});

/* $(function() {

	var cnt = 0;
	var allCount = 0;
	var todayCount = 0;
	var allVisitor = ${allVisitor};
	var todayVisitor = ${todayVisitor};
	
	counterFn();
	allCounter();
	todayCounter();
	
	function counterFn(){
		id0 = setInterval(count0Fn, 10);
		
		function count0Fn(){
			cnt++;
			if(cnt>100){
				clearInterval(id0);
			} else{
				$(".number").text(cnt);
			}
		}
	}
	
	function allCounter(){
		id1 = setInterval(countFn1, 10);
		
		function countFn1(){
			allCount++;
			if(allCount>allVisitor){
				clearInterval(id1);
			} else {
				$(".allVisitor").html('<B>'+allCount+'</B>');
			}
		}
	}
	
	function todayCounter(){
		id2 = setInterval(countFn2, 100);
		
		function countFn2(){
			todayCount++;
			if(todayCount>todayVisitor){
				clearInterval(id2);
			} else {
				$(".todayVisitor").html('<B>'+todayCount+'</B>');
			}
		}
	}
	
}); */
/* 
var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
  showDivs(slideIndex += n);
}

function currentDiv(n) {
  showDivs(slideIndex = n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("demo");
  if (n > x.length) {slideIndex = 1}
  if (n < 1) {slideIndex = x.length}
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";  
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" w3-white", "");
  }
  x[slideIndex-1].style.display = "block";  
  dots[slideIndex-1].className += " w3-white";
}

var myIndex = 0;
carousel();

function carousel() {
  var i;
  var x = document.getElementsByClassName("mySlides");
  for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";  
  }
  myIndex++;
  if (myIndex > x.length) {myIndex = 1}    
  x[myIndex-1].style.display = "block";  
  setTimeout(carousel, 8000); // Change image every 2 seconds
}
 */




</script>
</body>
</html>