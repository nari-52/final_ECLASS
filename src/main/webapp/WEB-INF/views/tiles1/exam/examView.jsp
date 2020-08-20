<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%	String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/examView.css" />

<script type="text/javascript">

	function goAdd(subseq) {
		var frm = document.addFrm;
		frm.fk_subSeq.value = subseq;
		frm.method="GET";
		frm.action="<%=request.getContextPath()%>/exam/examRegister.up";
		frm.submit();		 
	}
	
	function goEdit(exam_seq) {
		var frm = document.editFrm;
		frm.exam_seq.value = exam_seq;
		frm.method="GET";
		frm.action="<%=request.getContextPath()%>/exam/examEdit.up";
		frm.submit();		 
	}
	
	function goDelete(exam_seq, fk_subSeq) {
		var frm = document.deleteFrm;
		frm.exam_seq.value = exam_seq;
		frm.fk_subSeq.value = fk_subSeq;
		frm.method="GET";
		frm.action="<%=request.getContextPath()%>/exam/examDelete.up";
		frm.submit();		 
	}
	
</script>

<div id="contentsWrap">

	<div id="mainCss">
		시험 목록
	</div>
	
	<c:if test="${empty examvo}">
		<div style="padding: 80px 480px;">
			<input type="button" class="button" value="시험등록하기" onclick="goAdd('${fk_subSeq}')">
		</div>
	</c:if>
	
	<c:if test="${not empty examvo}">
		<div class="tbl-wrap lecture-list">
			<table>
				<thead>
					<tr>
						<th id="tbl-subName"></th>
						<th id="tbl-buttons"></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="examList" items="${examvo}">
						<tr class="lectureDetail">
							<td id="tbl-subName" class="num">
								${examList.examTitle}
							</td>
							<td id="tbl-buttons">
								<input type="button" class="button" value="수정하기" onclick="goEdit('${examList.exam_seq}')">
								<input type="button" class="button" value="삭제하기" onclick="goDelete('${examList.exam_seq}','${fk_subSeq}')">
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</c:if>
	
	<form name="addFrm">
		<input type="hidden" name="fk_subSeq"/>
	</form>
	
	<form name="editFrm">
		<input type="hidden" name="exam_seq"/>
	</form>
	
	<form name="deleteFrm">
		<input type="hidden" name="exam_seq"/>
		<input type="hidden" name="fk_subSeq"/>
	</form>

</div>