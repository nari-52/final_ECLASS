<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	div#signuptitle {
		/* border: solid 1px gray; */
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
	
	div#pwdFindcontent {
		/* border: solid 1px red; */
		width: 100%;
		height: 600px;
		background: #fafafa;
		display: inline-block;
		
	}
	
	/* 메일 인증 ------------------------------------------------------------------ */
	
	div#pwdFind_content {
		/* border: solid 1px red; */
		width: 100%;
		height: 500px;
		background: #fafafa;
		display: inline-block;
		margin: 0 auto;
	}
	
	/* 이메일 인증 배경 만들기 */
	div#pwdFind_back {
		border: solid 1px #ddd;
		width: 1080px;
		height: 370px;
		background: white;
		margin: 0 auto;
		padding-top: 50px; /* form 태그 위에 padding 주기 */
	}
		
	form#pwdFind_form {
		/* border: solid 1px gray; */
		margin: 0 auto;
		width: 620px;
		height: 150px;
		background-color: white;	
	}

	div#btn_2 {
		/* border: solid 1px blue; */
		width: 100%;
		margin-top: 50px;
	}
	
 	.btnTnC {
		border: solid 1px #ddd;
		width: 150px;
		line-height: 42px;
		margin: 0 10px;
		float: left;
		background-color: #00bcd4;
		color: white;
		font-weight: bold;
		margin-left: 10px;
		font-size: 12pt;
		font-weight: bold;
		text-align: center;
		
	}
	
	.btnTnC {
		cursor: pointer;
		
	}
	
	.agree {
		margin-left: 380px;
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
				<h1 id="head_main">비밀번호 변경 완료</h1>
			</div>
		</section>	
	</div>
	
	<div id="pwdFindcontent">
		<br/><br/><br/><br/>
		<div id="pwdFind_content">
			<div id="pwdFind_back">
				<form name="pwdFind_form" id="pwdFind_form">
					<h3 style="text-align: center;">비밀번호 변경 완료</h3>
					<hr style="margin-bottom: 30px;">
					<div id="showinfo" style="text-align: center;">변경된 비밀번호로 로그인 해 주시기 바랍니다.</div>
					<%-- <label>변경된 비밀번호 : </label><input type="text" id="pwd" name="pwd"  value="${pwd}" /> --%>
					
						

				</form>
				<div id="btn_2">
					<div id="loginbtn" class="btnTnC agree">로그인</div>
					<div id="mainbtn" class="btnTnC">메인으로</div>
				</div>
			</div>
		
		</div>
	</div>


</body>