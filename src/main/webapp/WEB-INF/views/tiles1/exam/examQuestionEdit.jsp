<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%	String ctxPath = request.getContextPath(); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/reset.css" />
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/examQuestionEdit.css" />

<script>
	
	$(window).on("load", function(){
		
		$("#submit").click(function(){
			
			var questionArr = new Array();
			var answerArr = new Array();
			var seqArr = new Array();
			
			for(var i=0; i<7; i++) {
				questionArr.push($(".question").eq(i).val());
				answerArr.push($(".answer").eq(i).val());
				seqArr.push($(".seq").eq(i).val());
			}
			var sQuestion = questionArr.join();
			var sAnswer = answerArr.join();
			var sQuestion_seq = seqArr.join();
			
			$("input:hidden[name=sQuestion]").val(sQuestion);
            $("input:hidden[name=sAnswer]").val(sAnswer);
            $("input:hidden[name=sQuestion_seq]").val(sQuestion_seq);
            
            writeExam();

		});
		
	}); //////////////////////////////////////////////////////////////////////////////////////////
	
	function writeExam(){
		if(confirm("정말 수정하시겠습니까?") == true) {
			var frm = document.registerFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/exam/examQuestionEditEnd.up";
 			frm.submit();         
		}
		else {
         	return;
		}
      
	}
	
	function goBack() {
		window.history.back();
	}

</script>

<div id="contentsWrap">

	<div id="register-title">시험 문제 수정</div>
	<br><br>
	
	<form id="registerFrm" name="registerFrm">
		<c:forEach var="questionArr" items="${questionArr}" varStatus="status">
			<span>${status.count}번 문제&nbsp;&nbsp;</span><input type='text' class='question' name='question' value="${questionArr}" style='height: 40px; width: 700px;'>
			<br><br>
		</c:forEach>
		
		<br><div class='border-line-box'></div><br><br>
		
		<c:forEach var="answerArr" items="${answerArr}" varStatus="status">
			<span>${status.count}번 정답&nbsp;&nbsp;</span><input type='text' class='answer' name='answer' value="${answerArr}" style='height: 40px; width: 700px;'/>
			<br><br>
		</c:forEach>
		
		<c:forEach var="Arr" items="${question_seqArr}" varStatus="status">
			<input type="hidden" class="seq" name="question_seq" value="${Arr}" >
		</c:forEach>
		
		<input type="hidden" id="sQuestion" name="sQuestion">
		<input type="hidden" id="sAnswer" name="sAnswer">
		<input type="hidden" id="sQuestion_seq" name="sQuestion_seq">
		<input type="hidden" id="exam_seq" name="exam_seq" value="${exam_seq}">
	</form>
	
	<div id="buttons">
		<button type="button" id="submit">제출</button>
		<button type="reset" onclick="goBack();">취소</button>
	</div>
	
	<div style="clear: both; margin-bottom: 50px;"></div>

</div>
