<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%	String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/myLectureforP.css?version=1.1" />

<script type="text/javascript">

	function goView(fk_subSeq) {
		var frm = document.subSeqFrm;
		frm.fk_subSeq.value = fk_subSeq;
		
		frm.method="GET";
		frm.action="<%=request.getContextPath()%>/lecture/lectureList.up";
		frm.submit();		 
	}
	
	function goAdd(subseq) {
		var frm = document.subSeqFrm;
		frm.fk_subSeq.value = subseq;
		frm.method="GET";
		frm.action="<%=request.getContextPath()%>/lecture/lectureRegister.up";
		frm.submit();		 
	}
	
	function goExamView(subseq) {
		var frm = document.subSeqFrm;
		frm.fk_subSeq.value = subseq;
		frm.method="GET";
		frm.action="<%=request.getContextPath()%>/exam/examView.up";
		frm.submit();		 
	}
	
</script>

<div id="contentsWrap" style="width: 1080px; margin: 0 auto;">

	<div id="mainCss">
		나의 강의실
	</div>
	
	<div class="tbl-wrap lecture-list">
		<table>
			<thead>
				<tr>
					<th id="tbl-subName" colspan="2">강의명</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="sublist" items="${subjectListforP}">
					<tr class="lectureDetail">
						<td id="tbl-subName" class="num">
							${sublist.subName}
						</td>
						<td id="tbl-buttons">
							<input type="button" class="button" value="강의목록" onclick="goView('${sublist.subseq}')">
							<input type="button" class="button" value="강의등록" onclick="goAdd('${sublist.subseq}')">
							<input type="button" class="button" value="시험보기" onclick="goExamView('${sublist.subseq}')">
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<form name="subSeqFrm">
		<input type="hidden" name="fk_subSeq"/>
	</form>

</div>