<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/min.css'/>">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/gh/xpressengine/xeicon@2.3.1/xeicon.min.css">
<style>
.btn {cursor:pointer;}

.comment_nick_box
{
	position: relative;
	/* z-index:1; */
} 

.comment_tool{
	margin-left:400px;
	position: relative;
	z-index:1;
}
.comment_Box {
    padding: 15px;
}

.contentBox{
		margin: auto;
		width: 400px;
		margin-top: 50px;
		margin-bottom: 100px;
	}

.xi-ellipsis-v{
	position: absolute;
}

.layerMore{
	position: absolute;
	height: 50px;
	width: 50px;
	left:auto;
	top: 10px;
	right:5px;
}
.comment_coment_area,
.comment_inbox{
	margin-left:15px;
}
.comment_inbox,
.comment_textView,
.comment_text_box{
	margin-left:15px;
}

textarea{

}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
		<script type="text/javascript">
			$(function(){
				var idx = ${idx};
				//var loginSession;
				var loginSession = `${loginInfo}`;
				if(loginSession!=null && loginSession!=''){
					loginSession = {
							mIdx:'${loginInfo.mIdx}',
							mId:'${loginInfo.mId}',
							mNick:'${loginInfo.mNick}'
					};
					contentsList(idx, loginSession);
				}else{
					loginSession = null;
					contentsList(idx, loginSession);
				}
			});
		</script>
		
	<div class="contentBox"></div>
	
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>