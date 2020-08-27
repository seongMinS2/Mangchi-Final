<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
</main>
<!-- Footer -->
<footer class="w3-center w3-text-deep-purple w3-hide-small w3-white w3-border-theme w3-topbar w3-padding">
    <a href="https://www.w3schools.com/w3css/default.asp" class="">
		<img src="<c:url value="/resources/img/LOGO-tight.png"/>" style="height: 27px"/></a>
		&nbsp;&nbsp;<span>우리동네 렌탈 서비스</span>
</footer>

  <script>
    // Modal Image Gallery
    function onClick(element) {
      document.getElementById("img01").src = element.src;
      document.getElementById("modal01").style.display = "block";
      var captionText = document.getElementById("caption");
      captionText.innerHTML = element.alt;
    }


    // Toggle between showing and hiding the sidebar when clicking the menu icon
    var mySidebar = document.getElementById("mySidebar");

    function w3_open() {
      if (mySidebar.style.display === 'block') {
        mySidebar.style.display = 'none';
      } else {
        mySidebar.style.display = 'block';
      }
    }

    // Close the sidebar with the close button
    function w3_close() {
      mySidebar.style.display = "none";
    }
    
  </script>

</body>

</html>