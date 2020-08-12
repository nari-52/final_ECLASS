<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<%	String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/reset.css" />
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/examWrite.css" />

<script>



</script>

<div id="contentsWrap" style="width: 1080px; margin: 0 auto;">

	<div id="register-title">시험 제출</div>
	
	<form id="registerFrm" name="registerFrm">
		<div id="view"></div>
	</form>
	
	<input type="hidden" name="examG">;
	
	<div id="buttons">
		<button type="button" onclick="goSubmit();">제출</button>
		<button type="reset">취소</button>
	</div>
	
	<div style="clear: both; margin-bottom: 50px;"></div>

</div>





