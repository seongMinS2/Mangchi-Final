<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
session.removeAttribute("kakaoInfo");
session.removeAttribute("loginInfo");
%>
<script>
location.href = "/mangh";
</script>