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
	margin: 0 0 0 20px;
	color: gray;
}
#namecss{
	color: #00BCD4;
	font-weight: bold;
}
#mainCss{
	font-size: 15pt;
	background-color: #FAFAFA;
	border: solid 1px #00BCD4;
	padding: 10px;
	margin-bottom: 20px;
	width: 850px;
	text-align: center;
	border-radius: 10px;
}
#tableCss{
	text-align: center;
	font-size: 12pt;
	width: 500px;
}
.sidecss {
	padding: 0 20px;
	text-align: center;
}
.sidecss2 {
	padding: 0 10px;
	text-align: center;
}
#myG {
	color: white;
	background-color: #00BCD4;
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
			case '-':
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
	  <div id="mainCss">
		<span id="namecss">${sessionScope.loginuser.name}</span>님의 성적
	  </div>
		<table id="tableCss">
			<tr style="background-color: #00BCD4;">
				<th style="color: white;" class="sidecss">교과목명</th>
				<th style="color: white;" class="sidecss2">학점</th>
			</tr>
			<c:forEach var="GList" items="${gradeList}" varStatus="status" >
				<tr>
					<td class="sidecss">${GList.subName}</td>
					<td id="finalG${status.index}" class="finalG" class="sidecss2">${GList.finalG}</td>
				</tr>
			</c:forEach>
			<tr>
				<td style="background-color: #E5E5E5;" class="sidecss">총 합계</td>
				<td id ="Gtotal" class="sidecss2"></td>
			</tr>
			<tr>
				<td style="background-color: #E5E5E5;" class="sidecss">학점 평균</td>
				<td id="average" class="sidecss2"></td>
			</tr>
		</table>
	</div>  
</body>
</html>