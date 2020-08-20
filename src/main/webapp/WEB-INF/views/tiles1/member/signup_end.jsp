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
	
	/* 진행상황 시작 ------------------------------------------ */
	
	div#signupcontent {
		/* border: solid 1px red; */
		width: 100%;
		height: 700px;
		background: #fafafa;
		display: inline-block;
		
	}
	
	div#processBar {
		/* border: solid 1px yellow; */
		display: inline-block;
		padding: 40px 0 20px 180px;
		/* overflow: hidden; *//* div 태그 상위 태그 크기에 맞추기 */
		align-content: center; 
	}
	
	ul.processBar, li.processBar {
		list-style: none;
		display: inline-block;
		margin: 0 10px;
	}
	
	li.currentProcess {
		border: solid 1px #ddd;
		width: 180px;
		background-color: white;
		padding: 5px;
	}
	
	.pracessTitle {
		color: gray;
		text-align: center;
		width: 100%;
		padding: 0;
	}
	
	.processContent {
		font-size: 18px;
		text-align: center;
		padding: 0;
	}
	
	li.currentstep {
		background-color: #00bcd4;
	}
	
	/* 진행상황 끝 ------------------------------------------ */
	
	
	/* 회원가입 완료 화면 만들기  ----------------------------------------------------- */
	
	div#singupend_content {
		/* border: solid 1px red; */
		width: 100%;
		height: 850px;
		background: #fafafa;
		display: inline-block;
		margin: 0 auto;
	}
	
	/* 로그인 배경 만들기 */
	div#singupend_back {
		border: solid 1px #ddd;
		width: 1080px;
		height: 550px;
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

	
	/* 정보보여주기 */
	
	table {
		margin: 0 auto;
	}
	
	th {
		/* border: solid 1px red; */
		width: 100px;
		text-align: left;
	}
	
	/* inputbox_short */
	.inputbox_short {
		width: 250px;
		line-height: 30pt;
		padding-left: 5pt;
		border: solid 1px #ddd;
		font-size: 12pt;
	}
	
	/* 버튼 만들기 */
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
		cursor: pointer;
	}
	
	.agree {
		margin-left: 250px;
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
				<h1 id="head_main">회원가입 완료</h1>
			</div>
		</section>
	</div>
	
	<div id="singupend_content">	
		<div id="processBar">
			<ul class="processBar">
				<li class="processBar currentProcess ">
					<div class="pracessTitle">step 01</div>
					<div class="processContent">약관동의</div>
				</li>
				<li class="processBar">
					<img src="/eclass/resources/images/nari/process_arrow.png" />
				</li>
				<li class="processBar currentProcess ">
					<div class="pracessTitle">step 02</div>
					<div class="processContent">본인인증</div>
				</li>
				<li class="processBar">
					<img src="/eclass/resources/images/nari/process_arrow.png" />
				</li>
				<li class="processBar currentProcess">
					<div class="pracessTitle">step 03</div>
					<div class="processContent">정보입력</div>
				</li>
				<li class="processBar">
					<img src="/eclass/resources/images/nari/process_arrow.png" />
				</li>
				<li class="processBar currentProcess currentstep">
					<div class="pracessTitle">step 04</div>
					<div class="processContent">가입완료</div>
				</li>
			</ul>
		</div>
		<br/>
	
	
		<div id="singupend_back">
			<div id="singupend">
			
				<div style="text-align: center; font-size: 16pt; font-weight: bold; margin-bottom: 10px;">ECLASS 신규 회원가입이 완료되었습니다.</div>
				<div style="text-align: center; font-size: 12pt; font-weight: bold; color: gray; margin-bottom: 15px;"> ECLASS 회원이 되신 것을 진심으로  축하합니다.</div>
				
				<hr style="margin-bottom: 20px;">
					<table>
						<tr>
							<th>
								이름
							</th>
							<td>
								<input type="text" name="name" id="name" value="${name}" class="requiredInfo inputbox_short" readonly /> 
							</td>
						</tr>
						
						<tr>
							<th>
								아이디
							</th>
							<td>
								<input type="text" name="userid" id="userid" value="${userid}" class="requiredInfo inputbox_short" /> 
							</td>
						</tr>
												
						<tr>
							<th>
								대학명
							</th>
							<td>
								<input type="text" name="university" id="university" value="${university}" class="requiredInfo inputbox_short" /> 
							</td>
						</tr>
						
						<tr>
							<th>
								학과
							</th>
							<td>
								<input type="text" name="major" id="major" value="${major}" class="requiredInfo inputbox_short" /> 
							</td>
						</tr>
						
						<tr>
							<th>
								학번
							</th>
							<td>
								<input type="text" name="student_num" id="student_num" value="${student_num}" class="requiredInfo inputbox_short" /> 
							</td>
						</tr>
						
						<tr>
							<th>
								휴대전화
							</th>
							<td>
								<input type="text" name="mobile" id="mobile" value="${mobile}" class="requiredInfo inputbox_short" />
							</td>
						</tr>
						
						
					</table>
				<div id="btn_2">
					<div id="loginbtn" class="btnTnC agree">로그인</div>
					<div id="mainbtn" class="btnTnC ">메인으로</div>
				</div>	
			</div>

		</div>
		
	</div>
</body>