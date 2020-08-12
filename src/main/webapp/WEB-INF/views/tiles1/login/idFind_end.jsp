<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	div#signuptitle {
		border: solid 1px gray;
		max-width: 1080px;
		height: 100px;
		margin: 0 auto;
	}
	
	h1#head_main {
		color: #00bcd4; /* 메인컬러  */
		margin: 0 auto;
		text-align: center;
		width: 100%;
		height: 129px;
		font-size: 25pt;
		padding-top: 25px;	
	}
	
	/* 진행상황 시작 ------------------------------------------ */
	
	div#idFindcontent {
		border: solid 1px red;
		width: 100%;
		height: 1500px;
		background: #fafafa;
		display: inline-block;
		
	}
	
	/* 메일 인증 ------------------------------------------------------------------ */
	
	div#idFind_content {
		/* border: solid 1px red; */
		width: 100%;
		height: 800px;
		background: #fafafa;
		display: inline-block;
		margin: 0 auto;
	}
	
	/* 이메일 인증 배경 만들기 */
	div#idFind_back {
		border: solid 1px #ddd;
		width: 1080px;
		height: 570px;
		background: white;
		margin: 0 auto;
		padding-top: 50px; /* form 태그 위에 padding 주기 */
	}
		
	form#idFind_form {
		/* border: solid 1px gray; */
		margin: 0 auto;
		width: 620px;
		height: 400px;
		background-color: white;	
	}

	div#loginbtn{
		border: solid 1px blue;
		margin: 0 auto;
		width: 320px;
		height: 30px;
		background-color: #00bcd4;
		color: white;
		font-size: 12pt;
		font-weight: bold;
		text-align: center;
		padding-top: 10px;
		display: inline block;
	}
	
	div#mainbtn{
		border: solid 1px blue;
		margin: 0 auto;
		width: 320px;
		height: 30px;
		background-color: #00bcd4;
		color: white;
		font-size: 12pt;
		font-weight: bold;
		text-align: center;
		padding-top: 10px;
		display: inline block;	
	}
	
</style>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){ 
		
		// 로그인 버튼 클릭 시 
		$("#loginbtn").click(function(){ 
			location.href="<%= ctxPath%>/login/login.up";
		});
		
		// 메인으로 버튼 클릭 시
		$("#mainbtn").click(function(){ 
			location.href="<%= ctxPath%>/index.up";
		});
		
	}); // end of $(document).ready(function() -----------


</script>
    
<body>

	<div id="signuptitle">
		<section>
			<div id="signup_head">
				<h1 id="head_main">아이디 찾기</h1>
			</div>
		</section>	
	</div>
	
	<div id="idFindcontent">
		<br/><br/><br/><br/>
		<div id="idFind_content">
			<div id="idFind_back">
				<form name="idFind_form" id="idFind_form">
					<h3 style="text-align: center;">아이디 찾기 완료</h3>
					
					<label>찾은 아이디 : </label><input type="text" id="userid"  value="${userid}" />
					

				</form>
				
				<div id="loginbtn" >로그인</div>
				<div id="mainbtn" >메인으로</div>
				
			</div>
		
		</div>
	</div>


</body>