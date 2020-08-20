<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%	String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/reset.css" />
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/examSubmit.css" />

<script>

	$(document).ready(function(){
		
		$("#submit").click(function(){
			
			var examG = 0;
			
			var answerArr = new Array();
			var realArr = new Array();
			
			for(var i=0; i<7; i++) {
				answerArr.push($(".answer").eq(i).val());
				realArr.push($(".realAnswer").eq(i).val());
				
				if(answerArr[i] == realArr[i]) {
					examG += 10;
				}
			}
			
			$("input:hidden[name=examG]").val(examG);
			
			goSubmit();
			
		});
		
	}); ////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	function goSubmit(){
		if(confirm("정말 제출하시겠습니까?") == true) {
			var frm = document.registerFrm;
		    frm.method = "POST";
		    frm.action = "<%=ctxPath%>/exam/examSubmitEnd.up";
		    frm.submit();
		}
		else {
         	return;
		}
	}
	
	function goBack() {
		location.href="<%= ctxPath%>/lecture/myLecture.up";
	}

</script>

<div id="contentsWrap" style="width: 1080px; margin: 0 auto;">

	<div id="register-title">시험 제출</div>
	
	<div id="view">
		<c:if test="${not empty questionList}">
			<c:forEach var="questionvo" items="${questionList}" varStatus="status">
				<div style="margin-bottom: 8px;">${status.count}번 문제 : ${questionvo.question}</div>
				<span>정답 </span><input class="answer" type="text" style="width: 700px; height: 25px;" maxlength="10">
				<br>
				<input class="realAnswer" type="hidden" value="${questionvo.answer}">
				<br><br>
			</c:forEach>
		</c:if>
	</div>
	
	<form id="registerFrm" name="registerFrm">
		<input type="hidden" name="examG"><%-- 시험 점수 --%>
		<input type="hidden" name="subSeq" value="${subSeq}"><%-- 교과목번호 --%>
	</form>
	
	<div id="buttons">
		<button type="button" id="submit">제출</button>
		<button type="reset" onclick="goBack();">취소</button>
	</div>
	
	<div style="clear: both; margin-bottom: 50px;"></div>

</div>
