<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Cookie cancelCookie = new Cookie("cancelStatus", "cancel");    
cancelCookie.setMaxAge(5);  // 취소 버튼을 없앨 수 있는 시간                          
cancelCookie.setPath("/");                                         
response.addCookie(cancelCookie);   
%> 
<script>
	location.href="/mangh/request/requestDetail?idx="+${idx}+"&distance="+${distance}+"&count="+${count}+"&writer="+'${writer}';
</script>