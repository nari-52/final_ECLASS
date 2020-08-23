<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	
	div#login_container {
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
	
	div#login_content {
		/* border: solid 1px red; */
		width: 100%;
		height: 600px;
		background: #fafafa;
		display: inline-block;
		margin: 0 auto;
	}
	
	/* 로그인 배경 만들기 */
	div#login_back {
		border: solid 1px  #ddd;
		width: 1080px;
		height: 450px;
		background: white;
		margin: 0 auto;
		margin-top: 50px;
		padding-top: 50px; /* form 태그 위에 padding 주기 */
	}	
	
	form#loginFrm {
		/* border: solid 1px gray; */
		margin: 0 auto;
		width: 620px;
		height: 400px;
		background-color: white;
	}
	
	ul.input_text {
		list-style: none;
		padding: 0;
	}
	
	li.saveID {
		margin: 20px 0px 30px 0px;
		text-align: right;
	}

	div#loginbtn{
		/* border: solid 1px blue; */
		margin: 0 auto;
		width: 620px;
		height: 30px;
		background-color: #00bcd4;
		color: white;
		font-size: 12pt;
		font-weight: bold;
		text-align: center;
		padding-top: 10px;
		cursor: pointer;
	}

	
	div.login_footer {
		border: solid 1px #ddd;
		margin: 0 auto;
		margin-top: 10px;
		line-height: 60px;
		text-align: center;
		width: 620px;
		height: 60px;
	}

</style>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function(){ 
		
		// 로그인 버튼 클릭 시
		$("#loginbtn").click(function() {
			 func_Login();
			 
		}); // end of $("#btnLOGIN").click();-----------------------
		
		// 비밀번호 작성 후 엔터를 쳤을 경우
		$("#pwd").keydown(function(event){
				
				if(event.keyCode == 13) { // 엔터를 했을 경우
					func_Login();
				}
		}); // end of $("#pwd").keydown();-----------------------	
		
		// 로컬에 저장된 userid 값을 불러와서 userid에 넣어주기
		var loginUserid = localStorage.getItem('saveID');
		
		if(loginUserid != null) {
			$("#userid").val(loginUserid);
			$("input:checkbox[id=saveID]").prop("checked", true);
		}
		
		// 회원탈퇴 버튼 클릭시
		$("#delMemberbtn").click(function() {
			func_delMember();
			 
		}); // end of $("#btnLOGIN").click();-----------------------
		
		
	}); // end of $(document).ready()---------------------------	
	

	
	
	// 로그인 함수
	function func_Login() {
			
		var userid = $("#userid").val();
		var pwd = $("#pwd").val();
		
		if(userid.trim()=="") {
			 alert("아이디를 입력하세요!!");
			 $("#userid").val("");
			 $("#userid").focus();
			 return;
		}
		
		if(pwd.trim()=="") {
			 alert("비밀번호를 입력하세요!!");
			 $("#pwd").val("");
			 $("#pwd").focus();
			 return;
		}
		
		var loginUserid = $("#userid").val().trim();
		
		// 아이디 저장
		if ($("input:checkbox[name=saveID]").prop("checked")) {
			// alert("아이디 저장 체크");
			
			localStorage.setItem('saveID', $("#userid").val());
		}
		else{
			// alert("아이디 저장 체크 안함");
			localStorage.removeItem('saveID');
		}
		
		var frm = document.loginFrm;
		
		frm.action = "<%=ctxPath%>/login/loginEnd.up";
		frm.method = "POST";
		frm.submit();
	}

</script>

<body>
	<div id="login_container" >
		<section>
			<div id="login_head">
				<h1 id="head_main">로그인</h1>
			</div>
		</section>
	</div>
	
	<div id="login_content">	
		<div id="login_back">
			<form name="loginFrm" id="loginFrm">
				<div id="login">
					<h3>ECLASS 회원 로그인</h3>
					<ul class="input_text">
						<li >
							<label for="userid"></label>
							<input type="text" name="userid" id="userid" class="input_text" required autofocus placeholder="아이디를 입력해주세요." style="border: solid 1px #ddd; width: 610px; height: 50px; vertical-align: middle; padding-left: 10px; font-size: 11pt;"/>
						</li>
						<li>
							<label for="pwd"></label>
							<input type="password" name="pwd" id="pwd" class="input_text" required placeholder="비밀번호를 입력해주세요." style="border: solid 1px #ddd; border-top:solid 0px;  width: 610px; height: 50px; vertical-align: middle; padding-left: 10px; font-size: 11pt;"/>
						</li>
						
						<li class="saveID">
							<input type="checkbox" name="saveID" id="saveID" style="cursor: pointer;"/>
							<label for="saveID" style="cursor: pointer;">아이디 저장</label>
						</li>
						
					</ul>
					
					<div id="loginbtn" >로그인</div>
					<!-- <div id="delMemberbtn" >회원탈퇴</div> -->
					<div class="login_footer">
						<a href="/eclass/login/idFind.up">아이디찾기</a><span>&nbsp;&nbsp;|&nbsp;&nbsp;</span>
						<a href="/eclass/login/pwdFind.up">비밀번호 찾기</a><span>&nbsp;&nbsp;|&nbsp;&nbsp;</span>
						<a href="/eclass/member/signup_step1.up?identity=1">학생 회원가입</a><span>&nbsp;&nbsp;|&nbsp;&nbsp;</span>
						<!-- <a href="/eclass/member/signup_step1.up?identity=2">교수 회원가입</a> -->
						<a onclick="alert('현재 교수 회원가입은 불가능합니다.');">교수 회원가입</a>
					</div>				
				</div>
			</form>
		</div>

		<form name="DelMemberFrm">
			<input type="hidden" name="delPwd" value="${sessionScope.loginuser.pwd}" />
			<input type="hidden" name="delUserid" value="${sessionScope.loginuser.userid}" />
			
		</form>
		<!-- <iframe src=“http://www.career.go.kr/cnet/front/base/major/FunivMajorList.iframe?apiKey=0466dca798e7b31756c6da4c354bf75b&svcType=frm&svcCode=MAJOR" scrolling="no" name="ce" width="680" height="1080" frameborder="0" style="border-width:0px;border-color:white; border-style:solid;"> </iframe> 
		-->
		
		
		
	</div>
</body>