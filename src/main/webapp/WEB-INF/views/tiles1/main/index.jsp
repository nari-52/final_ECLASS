<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<% 
	String ctxPath = request.getContextPath();
	// 		/board
%>

<style>

#wholeMain{
	border: solid 1px gray;
	width: 1080px;
	margin: 0 auto;
}
	
	
</style>

<div id="wholeMain" >
	<div align="center" style="margin: 0 auto;">
			<div style="border: solid 1px black; height: 400px; width: 1080px;">
			<img src="<c:url value="/resources/images/원더플레이스.png" />">
			</div>	
	</div>
	
	
	
	<div style="width: 1000px; border: solid 1px black; margin: 0 auto; text-align: center;">
		<h3>인기강의</h3>
		
		<div style="border: solid 1px black; width: 250px; height: 250px; display: inline-block; margin: 20px;">
			<div><img src="<c:url value="/resources/images/동원.png" />" style="width: 240px; height: 240px;" ></div>
		</div>
		
		
		<div style="border: solid 1px black; width: 250px; height: 250px; display: inline-block; margin: 20px;">
			<div><img src="<c:url value="/resources/images/미샤.png" />" style="width: 240px; height: 240px;" ></div>
		</div>
		
		<div style="border: solid 1px black; width: 250px; height: 250px; display: inline-block; margin: 20px;">
			<div><img src="<c:url value="/resources/images/레노보.png" />" style="width: 240px; height: 240px;" ></div>
		</div>
	</div>
	
	
	<div style="width: 1000px; border: solid 1px black; margin: 0 auto; text-align: center;">
		<div style="border: solid 1px black; width: 450px; height: 300px; display: inline-block; margin:0 20px 0 20px; ">
			<div>후원현황</div>
		</div>	
		
		<div style="border: solid 1px black; width: 450px; height: 300px; display: inline-block;">
			<div>공지사항</div>
		</div>
		
	</div>
	
</div>




  
   