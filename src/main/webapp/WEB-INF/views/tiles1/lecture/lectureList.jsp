<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<%	String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/reset.css" />
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/lectureList.css" />

<script type="text/javascript">

$(document).ready(function(){

	$("#searchWord").keydown(function(event) {
		if(event.keyCode == 13) { // 엔터를 했을 경우
			 goSearch();
		}
	});
	
	
});

<%-- 검색하러 가기 --%>
function goSearch() {
	var frm = document.searchFrm;
	frm.method = "GET";
	frm.action = "<%=ctxPath%>/lecture/lectureList.up";
	frm.submit();
} // end of function goSearch()-------------------------

</script>

<div id="contentsWrap">

	<div id="leture-title">
		[강의명] 강의 목록
	</div>
	
	<form name="searchFrm">
		<div class="lecture-search" align="right">
			<input type="text" id="searchWord" name="searchWord" />
			<button type="button" onclick="goSearch();">검색</button>
		</div>
	</form>
	
	<div class="border-line-box"></div>

	<div class="tbl-wrap lecture-list">
	
		<table>
			<thead>
				<tr>
					<th id="tbl-no" class="tbl-name">차수</th>
					<th id="tbl-title" class="tbl-name">강의 제목</th>
					<th id="tbl-day" class="tbl-name">탑재일</th>
				</tr>
			</thead>
			<tbody>
					<tr class="lectureDetail">
						<td id="tbl-no" class="seq">2</td>
						<td id="tbl-title">01강 Javascript</td>
						<td id="tbl-day">2020-08-10</td>
					</tr>
					<tr class="lectureDetail">
						<td id="tbl-no" class="seq">1</td>
						<td id="tbl-title">오리엔테이션</td>
						<td id="tbl-day">2020-08-03</td>
					</tr>
			</tbody>
		</table>
	</div>

</div>