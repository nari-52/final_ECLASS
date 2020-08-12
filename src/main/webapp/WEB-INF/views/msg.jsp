<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<script>


	<c:if test="${n > 0}">
		alert("${message}");
	</c:if>
	
	<c:if test="${n <= 0}">
		alert("${message}");
	</c:if>
	
	//페이지 이동
	location.href = "${loc}";
	
	self.close();//팝업창 닫기
	opener.location.reload(true);//부모창 새로고침

</script>