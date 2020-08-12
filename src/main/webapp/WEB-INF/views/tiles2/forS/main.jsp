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
.sidecss {
	border-right: solid 1px gray;
	margin: 10px;
	padding-right: 10px;
	margin-right: 10px;
}
</style>
</head>
<body>
	<div id="test">
	  <h2>${membervo.name}님의 마이페이지 입니다</h2>
	  	<table>
			<tr>
				<td class="sidecss">학교이름</td>
				<td>${membervo.university}</td>
			</tr>
			<tr>
				<td class="sidecss">학과</td>
				<td>${membervo.major}</td>
			</tr>
			<tr>
				<td class="sidecss">학번</td>
				<td>${membervo.student_num}</td>
			</tr>
			<tr>
				<td class="sidecss">포인트</td>
				<td>${membervo.point}</td>
			</tr>
			<tr>
				<tr>
				<td class="sidecss">교과목 목록</td>
				<td>
					<c:if test="${not empty subjectList}">
						<c:forEach var="sublist" items="${subjectList}">
							${sublist.subName}<br/>
						</c:forEach>
					</c:if>
					<c:if test="${empty subjectList}">
						교과목 없음
					</c:if>
				</td>
			</tr>
		</table>
		<button type="button">내강의실로 이동</button>
	</div>  
</body>
</html>