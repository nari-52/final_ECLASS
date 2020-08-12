<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
	function goView(fk_subseq){
		var frm = document.goViewFrm;
		frm.fk_subseq.value = fk_subseq;
		
		frm.method="GET";
		frm.action="<%=request.getContextPath()%>/lecture/lectureList.up";
		frm.submit();		 
	}
</script>

<div id="contentsWrap" style="width: 1080px; margin: 0 auto;">

	<c:if test="${paraMap.identity == 1}">
		<h2>수강중인 강의</h2>
	</c:if>
	<c:if test="${paraMap.identity == 2}">
		<h2>나의 강의실</h2>
	</c:if>

	<c:if test="${not empty subjectList}">
		<c:forEach var="sublist" items="${subjectList}">
			<div>${sublist.subName}&nbsp;&nbsp;&nbsp;<input type="button" name="fk_subseq" value="이동하기" onclick="goView('${sublist.fk_subseq}')"></div>
			<br/>
		</c:forEach>
	</c:if>
	<c:if test="${empty subjectList}">
		교과목 없음
	</c:if>
	
	<form name="goViewFrm">
		<input type="hidden" name="fk_subseq"/>
	</form>

</div>