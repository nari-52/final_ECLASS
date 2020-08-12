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
	
	#viewHead{
		width: 1000px;
		margin: 0 auto;
		background-color: white;
		padding: 20px 0 20px 40px;
		border-bottom: solid 1px gray;
		height: 130px;
	}
	
	#viewContent{
	 	width: 1000px;
		margin: 0 auto;
		background-color: white;
		padding: 20px 0 20px 40px;
	}
	
	#addedFile{
		width: 1000px;
		margin: 0 auto;
		background-color: #f2f2f2;		
	}
	
	#addReply{
		width: 1000px;
		margin: 0 auto;
		background-color: #f2f2f2;	
	}
	
	#updownView{
		width: 1000px;
		margin: 0 auto;
		background-color: white;
		
	}	
	
	table{
		width: 1000px;
	}
	
	 tr,th,td{
		text-align: center;
		padding: 10px;
		border-bottom: solid 1px #5E5E5E;
		border-top: solid 1px #5E5E5E;
	} 
	
	#goReply{
		display: inline-block;
		border: solid 1px gray;
		width: 100px;
		height: 100px;
		line-height: 100px;
		background-color: #ccc;
		color: white;
		cursor: pointer;
	}
	
	.button{
		display: inline-block;
		width: 70px;
		height: 40px;
		background-color: #ccc;
		float: right;
		margin-left: 20px;
		text-align: center;
		line-height: 40px;
		cursor: pointer;
	}
	
</style>

<div id ="container"><br>
<div id="wholeNotice">
	<div style="text-align: center;">
		<h3 style="color: #00BCD4; font-weight: bold;">Q&A</h3>
	</div>	
	<br>
	
	<div id="viewHead">
		<h3>Q&A 게시판 상세보기 페이지</h3>
		<div style="float: right; margin:20px;">
		<span style="font-weight: bold; font-size: 13pt;">작성자</span> <span>홍길동</span>&nbsp;
		<span style="font-weight: bold; font-size: 13pt;">작성일</span> <span>2020.07.22</span>&nbsp;
		<span style="font-weight: bold; font-size: 13pt;">조회수</span> <span>200</span>&nbsp;
		</div>
	</div>
	
	<div id="viewContent">
		<div>
			안녕하세요 홍길동입니다. 이곳은 테스트페이지입니다.<br>
			안녕하세요 홍길동입니다. 이곳은 테스트페이지입니다.<br>
			안녕하세요 홍길동입니다. 이곳은 테스트페이지입니다.<br>
			안녕하세요 홍길동입니다. 이곳은 테스트페이지입니다.<br>
			안녕하세요 홍길동입니다. 이곳은 테스트페이지입니다.<br>
			안녕하세요 홍길동입니다. 이곳은 테스트페이지입니다.<br>
			안녕하세요 홍길동입니다. 이곳은 테스트페이지입니다.<br>
			안녕하세요 홍길동입니다. 이곳은 테스트페이지입니다.<br>
		</div>
	</div>

	<div id="addedFile">
		<table>
			<tr>
				<th>첨부파일</th>
				<td>첨부파일이 없습니다</td>
			</tr>
		</table>
	</div><br>
	
	<div id="updownView">
		<table>
			<tr>
				<th>이전글</th>
				<td>Q&A 게시판 테스트</td>
			</tr>
			
			<tr>
				<th>다음글</th>
				<td>Q&A 게시판 테스트</td>
			</tr>
		</table>
	</div><br>
	
	<div id="updownView" style="height: 40px; background-color: #fafafa;">
		<span class="button">글수정</span>
		<span class="button">글삭제</span>
		<span class="button">목록</span>
	</div><br>
	
	<div id="addReply">
		<table style="margin: 0 auto;">
			<tr>
				<td><textarea rows="5" cols="110" style="height: 100px;"></textarea></td>
				<td><span id="goReply">댓글달기</span></td>
			</tr>
		</table>
	</div>
	<br>
</div>	
</div>