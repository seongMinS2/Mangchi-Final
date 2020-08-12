<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../package/swiper-bundle.min.css">
<link rel="stylesheet" href="<c:url value="/resources/css/kjj.css"/>">
<style>

</style>
<script src="http://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<div class="w3-container">
		<div class="w3-row-padding">
			<div class="w3-col" style="width: 10%">
				<p></p>
			</div>
			<div class="w3-col" style="width: 80%">
				<div class="w3-row">
					<h1>채팅</h1>
				</div>
				<div class="w3-row">
					<div class="w3-gray w3-container w3-third">
						<h2>asdf</h2>
					</div>
					<div class="w3-container w3-twothird chatArea">
						<div class="w3-row w3-blue w3-padding receiver">
							<h3>상대방 닉네임</h3>
						</div>
						<div class="w3-row w3-light-grey w3-padding msgArea">
							<div class="w3-row">
								<div class="w3-blue msg"><p>ㅎㅇ</p></div>
							</div>
							<div class="w3-row">
								<div class="w3-green msg"><p>ㅎㅇ</p></div>
							</div>
						</div>

						<div class="w3-row w3-padding inputArea">
							<div class="w3-col" style="width: 85%">
								<input class="w3-input w3-border w3-round-small" type="text"
									id="msg">
							</div>
							<div class="w3-rest">
								<button type="button" class="w3-button w3-blue w3-center">
									전송 <i class="fa fa-plane"></i>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="w3-col" style="width: 10%">
				<p></p>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
	<script src="<c:url value="/resources/js/kjj.js"/>"></script>
</body>
</html>