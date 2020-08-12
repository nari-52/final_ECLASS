<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
	function goView(fk_subSeq){
		var frm = document.goViewFrm;
		frm.fk_subSeq.value = fk_subSeq;
		
		frm.method="GET";
		frm.action="<%=request.getContextPath()%>/lecture/lectureList.up";
		frm.submit();		 
	} // end of goView() ------------------------------------
	
	function goAdd(subseq){
		var frm = document.goViewFrm;
		frm.fk_subSeq.value = subseq;
		frm.method="GET";
		frm.action="<%=request.getContextPath()%>/lecture/lectureRegister.up";
		frm.submit();		 
	} // end of goAdd() ------------------------------------
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
			<div>${sublist.subName}&nbsp;&nbsp;&nbsp;<input type="button" name="fk_subseq" value="강의목록보기" onclick="goView('${sublist.fk_subseq}')"></div>
			<br/>
		</c:forEach>
	</c:if>
	
	<c:if test="${not empty subjectListforP}">
		<c:forEach var="sublist" items="${subjectListforP}">
			<div>${sublist.subName}&nbsp;&nbsp;&nbsp;<input type="button" name="fk_subseq" value="이동하기" onclick="goView('${sublist.subseq}')"><input type="button" name="fk_subseq" value="강의등록하기" onclick="goAdd('${sublist.subseq}')"></div>
			<br/>
		</c:forEach>
	</c:if>
	
	<form name="goViewFrm">
		<input type="hidden" name="fk_subSeq"/>
	</form>

</div>