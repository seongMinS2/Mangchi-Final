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
<style>
h1, p {
	font-family: 'Jua', sans-serif;
	color: black;
}
    	
.nanum {
	font-family:'Nanum Gothic Coding', monospace;;
	font-size: 1em;
}
    	

.mySlides {display:none}
.w3-left, .w3-right, .w3-badge {cursor:pointer}
.w3-badge {height:13px;width:13px;padding:0}
</style>

<div class="w3-content w3-display-container" style="max-width:80%">
  <div class="w3-display-container  mySlides"> 
 	<img src="<c:url value='/resources/img/index/home.png'/>" style="width:100%">
	<div class="w3-display-middle w3-large w3-container w3-padding-16">
    <h1>당장 필요한 물건이 있는데 <br>사기엔 돈이 아깝다면?</h1>
    <p class="nanum">우리 동네 대여 서비스  M A N G C H !</p>
    </div>
  </div>
  <div class="w3-display-container  mySlides"> 
    <img src="<c:url value='/resources/img/index/home3.jpg'/>" style="width:100%">
	<div class="w3-display-middle w3-large w3-container w3-padding-16">
    <h1>집에서 놀고 있는 물건이 있는데 팔기엔 아쉽다면?</h1>
    <p class="nanum">우리 동네 대여 서비스  M A N G C H !</p>  
	</div>
  </div>
  <div class="w3-display-container  mySlides"> 
    <img src="<c:url value='/resources/img/index/wooden.png'/>" style="width:100%">
	<div class="w3-display-middle w3-large w3-container w3-padding-16">
	<h1>우리 동네에 내가 당장 필요한 물건과<br>내 물건이 갑자기 필요해진 사람이 있다?</h1>
	<p class="nanum">우리 동네 대여 서비스  M A N G C H !</p> 
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

<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
<script>
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