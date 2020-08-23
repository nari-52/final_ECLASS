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
.sidecss {
	border: solid 1px #00BCD4;
	background-color: #FAFAFA;
	padding: 10px;
	color: #00BCD4;
	text-align: center;
	width: 250px;
}
#namecss{
	color: #00BCD4;
	font-weight: bold;
}
#tableCss{
	font-size: 13pt;
	width: 850px;
}
#mainCss{
	font-size: 15pt;
	background-color: #FAFAFA;
	border: solid 1px #00BCD4;
	padding: 10px;
	width: 850px;
	margin-bottom: 10px;
	border-radius: 10px;
}
.sidecss2{
	padding: 10px;
}
#myM {
	color: white;
	background-color: #00BCD4;
}

</style>
<script type="text/javascript">
	$(document).ready(function(){
		
	}); // end of $(document).ready(function()--------------
	
	function go_subject(fk_subSeq){
		
		location.href="lecture/lectureList.up?fk_subSeq="+fk_subSeq;
	}
</script>
</head>
<body>
	<div id="test">
	  <div id="mainCss">
	  	<img alt="펭귄누운짤" style="width: 180px; height:100px; margin-right: 20px;" src="<%= request.getContextPath()%>/resources/images/mainpage.jpg">
	  	<span id="namecss">${membervo.name}</span> 님의 마이페이지 입니다:)
	  </div>
	  	<table id="tableCss">
			<tr>
				<td class="sidecss">학교이름</td>
				<td class="sidecss2">${membervo.university}</td>
			</tr>
			<tr>
				<td class="sidecss">학과</td>
				<td class="sidecss2">${membervo.major}</td>
			</tr>
			<tr>
				<td class="sidecss">학번</td>
				<td class="sidecss2">${membervo.student_num}</td>
			</tr>
			<tr>
				<td class="sidecss">포인트</td>
				<td class="sidecss2">${membervo.point}</td>
			</tr>
			<tr>
				<tr>
				<td class="sidecss">수강중인 교과목</td>
				<td class="sidecss2">
					<c:if test="${not empty subjectList}">
						<ul style="margin-left: -20px;">
						<c:forEach var="sublist" items="${subjectList}">
							<li>
								${sublist.subName}
								<button type="button" onclick="go_subject('${sublist.fk_subseq}');">강의 보기!</button>
							</li>
						</c:forEach>
						</ul>
					</c:if>
					<c:if test="${empty subjectList}">
						교과목 없음
					</c:if>
				</td>
			</tr>
		</table>
		<br/>
	</div>  
</body>
</html>