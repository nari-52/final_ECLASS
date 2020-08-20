<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	
	div#singupend_container {
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
	
	/* 로그인 만들기  ----------------------------------------------------- */
	
	div#singupend_content {
		/* border: solid 1px red; */
		width: 100%;
		height: 500px;
		background: #fafafa;
		display: inline-block;
		margin: 0 auto;
	}
	
	/* 로그인 배경 만들기 */
	div#singupend_back {
		border: solid 1px  #ddd;
		width: 1080px;
		height: 300px;
		background: white;
		margin: 0 auto;
		margin-top: 50px;
		padding-top: 50px; /* form 태그 위에 padding 주기 */
	}	
	div#singupend {
		/* border: solid 1px red; */
		width: 800px;
		margin: 0 auto;
	}
	
	ul.input_text {
		list-style: none;
		padding: 0;
		border: solid 0px;
	}
	
	div#loginbtn{
		border: solid 1px #ddd;
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
		cursor: pointer;
	}
	
	div#mainbtn{
		border: solid 1px #ddd;
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
		cursor: pointer;
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
		
		
	}); // end of $(document).ready()---------------------------	
	

	


</script>

<body>
	<div id="singupend_container" >
		<section>
			<div id="singupend_head">
				<h1 id="head_main">회원탈퇴 완료</h1>
			</div>
		</section>
	</div>
	
	<div id="singupend_content">	
		<div id="singupend_back">
			<div id="singupend">
				
				<h3 style="text-align: center;">ECLASS 회원 탈퇴가 완료되었습니다.</h3>
				<hr style="margin-bottom: 30px; width: 620px;">
				<div style="text-align: center; font-size: 11pt; margin-bottom: 15px;"> 그동안 이용해 주셔서 감사합니다.</div>
				
				
	
				
				<div id="mainbtn" style="margin-top: 70px;">메인으로</div>
		
			</div>

		</div>
		
	</div>
</body>