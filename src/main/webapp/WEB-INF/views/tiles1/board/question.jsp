<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<style>

	#container{
		background-color: #fafafa;
	}

	#wholeNotice{
		width: 1080px;
		margin: 0 auto;
		/* border: solid 1px black; */
		background-color: #fafafa;
	}
	
	tr,th,td{
		border: solid 1px black;
		border-collapse: collapse;
		text-align: center;
		padding: 20px;
	}
</style>

<div id ="container"><br>
<div id="wholeNotice">
	<div style="text-align: center;">
		<h3 style="color: #00BCD4; font-weight: bold;">Q&A</h3>
	</div>	
	<br>
	
	<span style="margin-left: 40px; color: white;">Total: 7</span>
	
	<div>
		<table style="margin: 0 auto; width: 1000px; background-color: white;">
			<tr style="background-color: #f2f2f2">
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>날짜</th>
			</tr>
			
			<tr>
				<td>1</td>
				<td>Q&A 게시판 테스트[비밀글]</td>
				<td>홍길동</td>
				<td>2020.07.22</td>
			</tr>
			
			<tr>
				<td>1</td>
				<td><a href="<%=ctxPath%>/questionview.up">Q&A 게시판 테스트</a></td>
				<td>홍길동</td>
				<td>2020.07.22</td>
			</tr>
			
			<tr>
				<td>1</td>
				<td>Q&A 게시판 테스트</td>
				<td>홍길동</td>
				<td>2020.07.22</td>
			</tr>
			
			<tr>
				<td>1</td>
				<td>Q&A 게시판 테스트[비밀글]</td>
				<td>홍길동</td>
				<td>2020.07.22</td>
			</tr>
			
			<tr>
				<td>1</td>
				<td>Q&A 게시판 테스트[비밀글]</td>
				<td>홍길동</td>
				<td>2020.07.22</td>
			</tr>
			
			<tr>
				<td>1</td>
				<td>Q&A 게시판 테스트</td>
				<td>홍길동</td>
				<td>2020.07.22</td>
			</tr>
			
			<tr>
				<td>1</td>
				<td>Q&A 게시판 테스트</td>
				<td>홍길동</td>
				<td>2020.07.22</td>
			</tr>
			
		</table>
	</div>
	
	<form name="searchFrm" style="margin-top: 20px; margin-left: 40px;">
		<select name="searchType" id="searchType" style="height: 26px;">
			<option value="subject">글제목</option>
			<option value="name">글쓴이</option>
		</select>
		<input type="text" name="searchWord" id="searchWord" size="40" autocomplete="off" /> 
		<button type="button">검색</button>
	</form>
	
	<div>
		<button type="button" style="margin-left: 980px;">
			<a href="<%=ctxPath%>/addquestion.up">글쓰기</a>
		</button>
	</div>	
	<br>
	
	<div style="text-align: center;">
		<span style="color: #00BCD4; font-size: 16pt; font-weight: bold;"> 1 2 3 4 5 6 7 8 9 10 다음</span>
	</div>
	<br>
	
</div>
</div>