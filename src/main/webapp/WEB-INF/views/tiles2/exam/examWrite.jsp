<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%	String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/reset.css" />
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/examWrite.css" />

<script>
	
	$(document).ready(function(){
		
		$("#submit").click(function(){
			
			var questionArr = new Array();
			var answerArr = new Array();
			
			for(var i=0; i<7; i++) {
				questionArr.push($(".question").eq(i).val());
				answerArr.push($(".answer").eq(i).val());
			}
			var sQuestion = questionArr.join();
			var sAnswer = answerArr.join();
			
			$("input:hidden[name=sQuestion]").val(sQuestion);
            $("input:hidden[name=sAnswer]").val(sAnswer);
            
            var frm = document.registerFrm;
            frm.method = "POST";
            frm.action = "<%=ctxPath%>/exam/examWriteEnd.up";
            frm.submit(); 

		});
		
	});

</script>

<div id="contentsWrap">

	<div id="register-title">시험 문제 출제</div>
	<br><br>
	
	<form id="registerFrm" name="registerFrm">
		<span>1번 문제&nbsp;&nbsp;</span><input type='text' class='question' name='question' style='height: 40px; width: 700px;'>
		<br><br>
		<span>1번 정답&nbsp;&nbsp;</span><input type='text' class='answer' name='answer' style='height: 40px; width: 700px;'/>
		<br><br><div class='border-line-box'></div><br>
		<span>2번 문제&nbsp;&nbsp;</span><input type='text' class='question' name='question' style='height: 40px; width: 700px;'>
		<br><br>
		<span>2번 정답&nbsp;&nbsp;</span><input type='text' class='answer' name='answer' style='height: 40px; width: 700px;'/>
		<br><br><div class='border-line-box'></div><br>
		<span>3번 문제&nbsp;&nbsp;</span><input type='text' class='question' name='question' style='height: 40px; width: 700px;'>
		<br><br>
		<span>3번 정답&nbsp;&nbsp;</span><input type='text' class='answer' name='answer' style='height: 40px; width: 700px;'/>
		<br><br><div class='border-line-box'></div><br>
		<span>4번 문제&nbsp;&nbsp;</span><input type='text' class='question' name='question' style='height: 40px; width: 700px;'>
		<br><br>
		<span>4번 정답&nbsp;&nbsp;</span><input type='text' class='answer' name='answer' style='height: 40px; width: 700px;'/>
		<br><br><div class='border-line-box'></div><br>
		<span>5번 문제&nbsp;&nbsp;</span><input type='text' class='question' name='question' style='height: 40px; width: 700px;'>
		<br><br>
		<span>5번 정답&nbsp;&nbsp;</span><input type='text' class='answer' name='answer' style='height: 40px; width: 700px;'/>
		<br><br><div class='border-line-box'></div><br>
		<span>6번 문제&nbsp;&nbsp;</span><input type='text' class='question' name='question' style='height: 40px; width: 700px;'>
		<br><br>
		<span>6번 정답&nbsp;&nbsp;</span><input type='text' class='answer' name='answer' style='height: 40px; width: 700px;'/>
		<br><br><div class='border-line-box'></div><br>
		<span>7번 문제&nbsp;&nbsp;</span><input type='text' class='question' name='question' style='height: 40px; width: 700px;'>
		<br><br>
		<span>7번 정답&nbsp;&nbsp;</span><input type='text' class='answer' name='answer' style='height: 40px; width: 700px;'/>
		
		<input type="hidden" id="sQuestion" name="sQuestion">
		<input type="hidden" id="sAnswer" name="sAnswer">
		<input type="hidden" id="exam_seq" name="exam_seq" value="${examvo.exam_seq}">
	</form>
	
	<div id="buttons">
		<button type="button" id="submit">제출</button>
		<button type="reset">취소</button>
	</div>
	
	<div style="clear: both; margin-bottom: 50px;"></div>

</div>
