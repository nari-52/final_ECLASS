<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
#test{
	display: inline-block;
	border: solid 0px red;
	margin: 0 20px;
	height: 500px;
}

</style>
<script type="text/javascript">

	$(document).ready(function(){
		
		var j = 0;
		$(".finalG").each(function(){
			j++ // 성적을 보여줄 과목의 수
		});
		
		var total = 0;
		for(var i=0; i<j; i++){
			var grade = $("#finalG"+[i]+"").text();
		//	alert(grade);	A, B, F
			switch (grade) {
			case 'A':
				total = total+4
				break;
			case 'B':
				total = total+3
				break;
			case 'C':
				total = total+2
				break;
			case 'D':
				total = total+1
				break;
			case 'F':
				total = total+0
				break;
			}
		} 
		
		$("#Gtotal").html(total);
		
		var average = (Math.round((total/j)*100)/100.0);
		
		$("#average").html(average);
	});

</script>
</head>
<body>
	<div id="test">
	  <h2>${sessionScope.loginuser.name} 님의 성적</h2>
		<table id="tblcss" >
			<tr style="background-color: #00BCD4;">
				<th style="color: white;">교과목명</th>
				<th style="color: white;">학점</th>
			</tr>
			<c:forEach var="GList" items="${gradeList}" varStatus="status" >
				<tr>
					<td>${GList.subName}</td>
					<td id="finalG${status.index}" class="finalG">${GList.finalG}</td>
				</tr>
			</c:forEach>
			<tr>
				<td style="background-color: #E5E5E5;">총 합계</td>
				<td id ="Gtotal"></td>
			</tr>
			<tr>
				<td style="background-color: #E5E5E5;">학점 평균</td>
				<td id="average"></td>
			</tr>
		</table>
	</div>  
</body>
</html>