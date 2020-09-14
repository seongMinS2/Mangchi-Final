<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리 동네 대여 서비스 :: M A N G C H !</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<link href="https://fonts.googleapis.com/css2?family=Jua&family=Nanum+Gothic+Coding&display=swap" rel="stylesheet">
<style>
h1{
	font-family: 'Jua', sans-serif;
	color: black;
}

p {
	font-family: 'Jua', sans-serif;
	color: white;
}
    	
.nanum {
	font-family:'Nanum Gothic Coding', monospace;;
	font-size: 1em;
}
    	

.mySlides {display:none}
.w3-left, .w3-right, .w3-badge {cursor:pointer}
.w3-badge {height:13px;width:13px;padding:0}

.indexPic {
	padding-left: 22%;
	width: 180px;
	height: 120px;
}
</style>

<div class="w3-content w3-display-container" style="max-width:70%">
  <div class="w3-display-container  mySlides"> 
 	<img src="<c:url value='/resources/img/index/home.png'/>" style="width:100%">
	<div class="w3-display-left w3-padding-16">
    <h1 style="font-size: 3vw">당장 필요한 물건이 있는데 <br>사기엔 돈이 아깝다면?</h1>
    <span  style="font-size: 1.2vw; color: white; font-weight: bold;">우리 동네 대여 서비스  M A N G C H !</span>
    </div>
  </div>
  <div class="w3-display-container  mySlides"> 
    <img src="<c:url value='/resources/img/index/home3.jpg'/>" style="width:100%">
	<div class="w3-display-topright w3-padding-16">
    <h1 style="font-size: 3vw">집에서 놀고 있는 물건이 있는데 팔기엔 아쉽다면?</h1>
    <span style="font-size: 1.2vw; color: white; font-weight: bold;">우리 동네 대여 서비스  M A N G C H !</span>  
	</div>
  </div>
  <div class="w3-display-container  mySlides"> 
    <img src="<c:url value='/resources/img/index/wooden.png'/>" style="width:100%">
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
  
</div>

 <div class="w3-content w3-center w3-container">
  <div class="w3-row w3-padding">
  
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

<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
<script>

$(function() {
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

	    id1 = setInterval(count1Fn, 8.13171226);

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
</script>

</body>
</html>