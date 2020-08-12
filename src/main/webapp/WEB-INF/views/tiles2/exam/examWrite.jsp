<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<%	String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/reset.css" />
<link rel="stylesheet" type="text/css" href="<%=ctxPath%>/resources/css/examWrite.css" />

<script>

	var cnt = 0;

	document.addEventListener("DOMContentLoaded", function(event) { 
		
		var plusQ = document.getElementById("plusQ");
		
		plusQ.addEventListener('click', function() {
			cnt = document.getElementById("cnt").value;
			makeQ(cnt);		
		});
		
		var submit = document.getElementById("submit");
		
		submit.addEventListener('click', function() {
			cnt = document.getElementById("cnt").value;
			
			var questionArr = document.getElementsByClassName("question");
			var answerArr = document.getElementsByClassName("answer");
			
			for(var i=0; i<questionArr.length; i++) {
				console.log(questionArr[i]+answerArr[i]);
			}
			
			console.log(questionArr);
			console.log(answerArr);
			
			var sQuestion = questionArr.join();
			var sAnswer = answerArr.join();
			
			document.getElementById("sQuestion").value = sQuestion;
			document.getElementById("sAnswer").value = sAnswer;
			
		});
		
	});

	function makeQ(cnt) {
		
		var html = "";
		var goplus = document.getElementById("goplus");
		
		for(var i=0; i<cnt; i++) {			
			html += "<br><br><div class='border-line-box'></div><br><span>문제 </span><input type='text' class='question' name='question' style='height: 40px; width: 1000px;'>";
			html += "<br><br>";
			html += "<span>정답 </span><input type='text' class='answer' name='answer' style='height: 40px; width: 1000px;'/>";
		}
		
		goplus.innerHTML = html;
		
	}

</script>

<div id="contentsWrap" style="width: 1080px; margin: 0 auto;">

	<div id="register-title">시험 문제 출제</div>
	<br>
	문항수 : <input type="text" id="cnt"><button type="button" id="plusQ">문제 추가</button>
	<br><br>
	<form id="registerFrm" name="registerFrm">
		<div id="goplus"></div>
		<input type="text" id="sQuestion" name="sQuestion">
		<input type="text" id="sAnswer" name="sAnswer">
	</form>
	
	<div id="buttons">
		<button type="button" id="submit">제출</button>
		<button type="reset">취소</button>
	</div>
	
	<div style="clear: both; margin-bottom: 50px;"></div>

</div>





